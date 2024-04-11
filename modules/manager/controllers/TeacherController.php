<?php

namespace app\modules\manager\controllers;

use app\models\Group;
use app\models\Role;
use app\models\User;
use app\models\UserGroup;
use app\modules\manager\models\TeacherSearch;
use Yii;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\VarDumper;
use yii\web\UploadedFile;

use function PHPUnit\Framework\isNull;

/**
 * UserController implements the CRUD actions for User model.
 */
class TeacherController extends Controller
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
    public function actionIndex()
    {
        $searchModel = new TeacherSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
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
        $model = $this->findModel($id);
        $userGroup = UserGroup::findAll(['user_id' => $id]);
        $userGroupArr = [];
        foreach ($userGroup as $value) {
            $userGroupArr[] = $value->group_id;
        };
        return $this->render('view', [
            'model' => $model,
            'userGroupArr' => $userGroupArr,
            'roleTitle' => Role::getRoleTitle($model->role)
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

        function createNewData($newData, $model)
        {
            $newData .= $model->name . " " . $model->surname . " " . $model->patronimyc . " login:" . $model->login . " password:" . $model->password . "\n";
            return $newData;
        }
        if ($this->request->isPost) {
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
                        $model->login = Yii::$app->security->generateRandomString(6);
                        $model->password = Yii::$app->security->generateRandomString(6);
                        $newData = createNewData($newData, $model);
                        $model->password = Yii::$app->security->generatePasswordHash($model->password);
                        $model->auth_key = Yii::$app->security->generateRandomString();
                        $model->role_id = Role::getRoleId('teacher');
                        $model->save();
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
                        return $this->redirect('../index');
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
                        return $this->redirect(['view', 'id' => $model->id, 'login' => $model->login, 'pass' => $tempPass]);
                    }
                }
            }
            return $this->redirect('../index');
        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
            'groupArr' => Group::getAllGroupTitle()
        ]);
    }

    public function actionAddGroup($user_id)
    {
        $model = new UserGroup();

        if ($this->request->isPost && $model->load($this->request->post())) {

            $model->user_id = $user_id;

            if (!$model->save())
                return;

            return $this->redirect(['view', 'id' => $model->user_id]);
        }

        return $this->render('addGroup', [
            'model' => $model,
            'groupTitle' => Group::getAllGroupTitle(),
        ]);
    }
    public function actionEditingGroup($id, $user_id)
    {
        $model = UserGroup::findOne(['group_id' => $id, 'user_id' => $user_id,]);
        $model->group_id = '';

        $groupTitles = Group::getAllGroupTitle();
        unset($groupTitles[$id]);

        if ($this->request->isPost && $model->load($this->request->post())) {
            // VarDumper::dump($model->attributes, 10, true);
            // die;
            if ($model->save()) {
                return $this->redirect(['view', 'id' => $model->user_id]);
            }
        }

        return $this->render('editingGroup', [
            'model' => $model,
            'groupTitle' => $groupTitles,
            'groupId' => $id,
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
