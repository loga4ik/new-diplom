<?php

namespace app\modules\teacher\controllers;

use app\models\Group;
use app\models\Role;
use app\models\StudentTest;
use app\models\User;
use app\models\UserGroup;
use app\modules\teacher\models\StudentSearch;
use Yii;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\VarDumper;
use yii\web\UploadedFile;

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
        // function getGroupsObj()
        // {
        //     $groupNames = Group::getAllGroupTitle();
        //     $groups = UserGroup::getStudentsGroups();
        //     $groupsObj = [];
        //     foreach ($groups as $key => $value) {
        //         $groupsObj[] = [
        //             'id' => $key,
        //             'title' => $groupNames[$value],
        //         ];
        //     }
        //     // VarDumper::dump($groups, 10, true);
        //     // die;
        //     return $groups;
        // }
        $searchModel = new StudentSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);
        if ($group_id) {
            $users_arr = [];
            foreach (UserGroup::findAll(['group_id' => $group_id]) as $value) {
                $users_arr[] = $value->user_id;
            }
            $dataProvider->query->andWhere(['id' => $users_arr]); //, 'role' => 1
        }

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
            'arrOfMarks' => StudentTest::getAllUserIdMark(),
            'groups' => getGroupsArr(),
            // 'groupsObj' => getGroupsObj(),
        ]);
    }

    /**
     * Displays a single User model.
     * @param int $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
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
        $newData = '';
        $addGroup = function ($model, $group) {
            $user = new UserGroup;
            $user->group_id = $group;
            $user->user_id = User::findOne(['login' => $model->login])->id;
            $user->save();
        };

        function createNewData($newData, $model)
        {
            $newData .= $model->name . " " . $model->surname . " " . $model->patronimyc . " login:" . $model->login . " password:" . $model->password . "\n";
            return $newData;
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
                if (!$model->name) {
                    $model->fileInput = file_get_contents(UploadedFile::getInstance($model, 'fileInput')->tempName);

                    $user = explode("\n", $model->fileInput);
                    foreach ($user as $value) {

                        $model = new User();
                        $value = explode(" ", $value);
                        $model->name = $value[0];
                        $model->surname = $value[1];
                        $model->patronimyc = substr($value[2], 0, -1);
                        // $model->group_id = $group;
                        $model->login = Yii::$app->security->generateRandomString(6);
                        $model->password = Yii::$app->security->generateRandomString(6);
                        $newData = createNewData($newData, $model);
                        // VarDumper::dump($newData, 10, true);
                        // die;
                        $model->password = Yii::$app->security->generatePasswordHash($model->password);
                        $model->auth_key = Yii::$app->security->generateRandomString();
                        $model->role_id = Role::getRoleId('teacher');
                        // VarDumper::dump($model->attributes, 10, true);
                        // die;
                        $model->save();
                        $group && $addGroup($model, $group);
                    }

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
                } else {
                    $tempPass = Yii::$app->security->generateRandomString(6);
                    $model->login = Yii::$app->security->generateRandomString(6);
                    $model->password = Yii::$app->security->generatePasswordHash($tempPass);
                    $model->auth_key = Yii::$app->security->generateRandomString();
                    $model->role_id = Role::getRoleId('teacher');
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
