<?php

namespace app\modules\teacher\controllers;

use app\models\Group;
use app\models\Role;
use app\models\StudentTest;
use app\models\User;
use app\models\UserGroup;
use app\modules\teacher\models\StudentSearch;
use Yii;
use yii\db\Query;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\VarDumper;
use yii\web\UploadedFile;

use function PHPUnit\Framework\fileExists;

/**
 * StudentController implements the CRUD actions for User model.
 */
class StudentController extends Controller
{
    /**
     * @inheritDoc
     */
    public function behaviors()
    {
        return array_merge(
            parent::behaviors(),
            [
                'verbs' => [
                    'class' => VerbFilter::className(),
                    'actions' => [
                        'delete' => ['POST'],
                    ],
                ],
            ]
        );
    }

    /**
     * Lists all User models.
     *
     * @return string
     */
    public function actionIndex($group_id = null)
    {
        function getGroupsArr()
        {
            $groupNames = Group::getAllGroupTitle();
            $groups = UserGroup::getStudentsGroups();
            foreach ($groups as $key => $value) {
                $groups[$key] = $groupNames[$value];
            }
            // VarDumper::dump($groups, 10, true);
            // die;
            return $groups;
        }

        function getGroupsObj()
        {
            $groupNames = Group::getAllGroupTitle();
            $groups = UserGroup::getStudentsGroups();
            $groupsObj = [];
            foreach ($groups as $key => $value) {
                $groupsObj[] = [
                    'id' => $key,
                    'title' => $groupNames[$value],
                ];
            }
            // VarDumper::dump($groups, 10, true);
            // die;
            return $groupsObj;
        }
        $searchModel = new StudentSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);
        if ($group_id) {
            $users_arr = [];
            foreach (UserGroup::findAll(['group_id' => $group_id]) as $value) {
                $users_arr[] = $value->user_id;
            }
            $dataProvider->query->andWhere(['id' => $users_arr]); //, 'role' => 1
        }
        // VarDumper::dump(getGroupsObj(), 10, true);
        // die;
        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
            'group_id' => $group_id,
            'arrOfMarks' => StudentTest::getAllUserIdMark(),
            'groups' => getGroupsArr(),
            'groupsObj' => getGroupsObj(),
        ]);
    }
    private function downloadFile($group)
    {
        $json = '../web/groupListFile/' . $group . '.json';
        $txt = '../web/groupListFile/' . $group . '.txt';
        $userJson = file_get_contents($json);
        $userList = '';
        foreach (json_decode($userJson, true) as $key => $user) {
            $userList .=
                'имя: ' . $user['name'] .
                ', фамилия: ' . $user['surname'] .
                ', отчество: '  . $user['patronimyc'] .
                ', логин: ' . $user['login'] .
                ', пароль' . $user['password']  . "\n";
        }
        $fp = fopen($txt, "w+");

        fwrite($fp, $userList);

        if (file_exists($txt)) {
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="' . basename($txt) . '"');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($txt));
            ob_clean();
            flush();
            readfile($txt);
            ob_end_flush();
            fclose($fp);
            unlink($txt);
            return $this->redirect('../');
        } else {
            echo 'Файл не существует.';
            fclose($fp);
        }
    }

    public function actionDownloadList($id)
    {
        // $this->findModel($id);
        $this->downloadFile($id);
        // VarDumper
        die;

        $newData = User::getAllStudents($id);
        // VarDumper::dump($newData, 10, true, 10, true);
        $file = '../web/groupListFile/groupList.txt';
        ob_start();
        // Записать данные в файл
        file_put_contents($file, $newData);
        // Получить данные из буфера и очистить его
        ob_get_clean();

        if (file_exists($file)) {
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="' . basename($file) . '"');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($file));
            ob_clean();
            flush();
            readfile($file);
            ob_end_flush();
            return $this->redirect('../');
        } else {
            echo 'Файл не существует.';
        }
        return $this->redirect(['index']);
    }

    /**
     * Displays a single User model.
     * @param int $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        $group = Group::getGroupTitle(UserGroup::findOne(['user_id' => $id])->group_id);
        $tests_count = StudentTest::getTestsCount();
        $group_id = UserGroup::findOne(['user_id' => $id]);

        $getGroupUsers = (new Query())
            ->select('user_id')
            ->from('user_group')
            ->where(['group_id' => $group_id])
            ->column();
        $getAVGmark = function ($studentTest) {
            if (!$studentTest) {
                return 0;
            }
            $markSum = 0;

            foreach ($studentTest as $key => $value) {
                $markSum += $value;
            }
            return $markSum / count($studentTest);
        };
        $getAllUsersMarks = function ($getGroupUsers, $getAVGmark) {
            $usersAVGresults = [];


            foreach ($getGroupUsers as $value) {
                array_push($usersAVGresults, $getAVGmark(StudentTest::getStudentsResults($value)));
            }
            return $usersAVGresults;
        };

        $arrOfAllUsersMarks = $getAllUsersMarks($getGroupUsers, $getAVGmark);
        $activeUsersAVGmark = $getAVGmark(StudentTest::getStudentsResults($id));
        array_multisort($arrOfAllUsersMarks, SORT_DESC);

        return $this->render('view', [
            'model' => $this->findModel($id),    'tests_count' => $tests_count,
            'group' => $group,
            'placeInClass' => array_search($activeUsersAVGmark, $arrOfAllUsersMarks) + 1,
            'student' => User::findOne($id)

        ]);
    }

    /**
     * Creates a new User model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    
    public function actionCreate()
    {
        $model = new User();
        $newData = [];
        $addGroup = function ($model, $group) {
            $user = new UserGroup;
            $user->group_id = $group;
            $user->user_id = User::findOne(['login' => $model->login])->id;
            $user->save();
        };

        function createNewData($newData, $model)
        {
            $newData = [
                'name' => $model->name,
                'surname' => $model->surname,
                'patronimyc' => $model->patronimyc,
                'login' => $model->login,
                'password' => $model->password,
            ];
            return $newData;
        }
        function updateData($newData, $oldData)
        {
            $oldData = json_decode($oldData, true);
            // VarDumper::dump($oldData, 10, true);
            foreach ($newData as $key => $newUser) {
                // VarDumper::dump($newUser['login'], 10, true);
                foreach ($oldData as $oldUser) {
                    if ($newUser['name'] == $oldUser['name'] && $newUser['surname'] == $oldUser['surname'] && $newUser['patronimyc'] == $oldUser['patronimyc']) {
                        unset($newData[$key]);
                    }
                }
            }
            // VarDumper::dump($newData, 10, true);

            // VarDumper::dump(json_decode($oldData, true), 10, true);
            // die;
            return $newData;
        }
        function fileHandler($file, $newData)
        {
            if (!file_exists($file)) {
                $fp = fopen($file, "w+");
                fwrite($fp, json_encode($newData));
                fclose($fp);
                // VarDumper::dump(json_encode($newData), 10, true);
                // die;
            } else {
                $oldData = file_get_contents($file);
                // VarDumper::dump($oldData, 10, true);
                // die;
                $newData = updateData($newData, $oldData);

                // VarDumper::dump([...$newData, ...json_decode($oldData, true)], 10, true);
                // die;
                $fp = fopen($file, "w+");
                fwrite($fp, json_encode([...$newData, ...json_decode($oldData, true)]));
                fclose($fp);
            }
        }
        // function createNewUserGroup($user_id, $group)
        // {
        //     $model = new UserGroup();
        //     $model->user_id = $user_id;
        //     $model->group_id = $group;
        //     $model->save();
        // }
        if ($this->request->isPost) {
            // VarDumper::dump($this->request->post(), 10, true);
            // die;
            if ($model->load($this->request->post())) {
                $group = $model->group_id;
                $file = '../web/groupListFile/' . $group . '.json';
                if (!$model->name) {
                    $model->fileInput = file_get_contents(UploadedFile::getInstance($model, 'fileInput')->tempName);

                    $user = explode("\n", $model->fileInput);
                    foreach ($user as $value) {

                        $model = new User();
                        $value = explode(" ", $value);
                        $model->name = $value[0];
                        $model->surname = $value[1];
                        $model->patronimyc = substr($value[2], 0, -1);
                        $model->login = Yii::$app->security->generateRandomString(6);
                        $model->password = Yii::$app->security->generateRandomString(6);
                        array_push($newData, createNewData($newData, $model));
                        $model->auth_key = Yii::$app->security->generateRandomString();
                        $model->role_id = Role::getRoleId('student');
                        // VarDumper::dump($model->attributes, 10, true);
                        // die;
                        $model->save();
                        $group && $addGroup($model, $group);
                    }

                    // VarDumper::dump(file_exists($file), 10, true);
                    // die;

                    fileHandler($file, $newData);

                    if (file_exists($file)) {
                        $this->downloadFile($group);
                        //     header('Content-Description: File Transfer');
                        //     header('Content-Type: application/octet-stream');
                        //     header('Content-Disposition: attachment; filename="' . basename($file) . '"');
                        //     header('Content-Transfer-Encoding: binary');
                        //     header('Expires: 0');
                        //     header('Cache-Control: must-revalidate');
                        //     header('Pragma: public');
                        //     header('Content-Length: ' . filesize($file));
                        //     ob_clean();
                        //     flush();
                        //     readfile($file);
                        //     ob_end_flush();
                        //     return $this->redirect('../');
                        // } else {
                        //     echo 'Файл не существует.';
                    }
                } else {
                    $tempPass = Yii::$app->security->generateRandomString(6);
                    $model->login = Yii::$app->security->generateRandomString(6);
                    $model->password = Yii::$app->security->generatePasswordHash($tempPass);
                    $model->auth_key = Yii::$app->security->generateRandomString();
                    $model->role_id = Role::getRoleId('student');
                    array_push($newData, createNewData($newData, $model));
                    fileHandler($file, $newData);
                    if ($model->save()) {
                        $model->group_id && $addGroup($model, $group);
                        return $this->redirect(['view', 'id' => $model->id, 'login' => $model->login, 'pass' => $tempPass]);
                    }
                }
            }
            return $this->redirect('../');
        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
            'groupArr' => Group::getAllGroupTitle()
        ]);
    }

    /**
     * Updates an existing User model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param int $id ID
     * @return string|\yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */

    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($this->request->isPost && $model->load($this->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('update', [
            'model' => $model,
            'groupArr' => Group::getAllGroupTitle()
        ]);
    }

    /**
     * Deletes an existing User model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param int $id ID
     * @return \yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the User model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param int $id ID
     * @return User the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = User::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
