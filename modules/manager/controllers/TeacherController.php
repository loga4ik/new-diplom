<?php

namespace app\modules\manager\controllers;

use app\models\Group;
use app\models\Role;
use app\models\User;
use app\models\UserGroup;
use app\modules\manager\models\TeacherSeach;
// use app\modules\manager\models\TeacherSeach;
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
        $searchModel = new TeacherSeach();
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
        }
        ;
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

        $addGroup = function ($model) {
            $user = new UserGroup;
            $user->group_id = $model->group_id;
            $user->user_id = User::findOne(['login' => $model->login])->id;
            $user->save();
        };
        $generateAttributes = function ($model) {
            $model->login = Yii::$app->security->generateRandomString(6);
            $model->password = Yii::$app->security->generateRandomString(6);
            $model->auth_key = Yii::$app->security->generateRandomString();
            $model->role_id = Role::getRoleId('teacher');
        };

        if ($this->request->isPost) {
            if ($model->load($this->request->post())) {

                if (!$model->name) {
                    $model->fileInput = file_get_contents(UploadedFile::getInstance($model, 'fileInput')->tempName);

                    $user = explode("\n", $model->fileInput);
                    foreach ($user as $value) {

                        $model = new User();
                        $value = explode(" ", $value);
                        $model->name = $value[0];
                        $model->surname = $value[1];
                        $model->patronimyc = substr($value[2], 0, -1);
                        $generateAttributes($model);
                        $model->save();
                        $model->group_id && $addGroup($model);
                    }
                    return $this->redirect('../');

                } else {
                    $generateAttributes($model);
                    if ($model->save()) {
                        $model->group_id && $addGroup($model);
                        return $this->redirect(['view', 'id' => $model->id]);
                    }
                }
            }
        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
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
            'groupTitle' => Group::getGroupTitle(),
        ]);
    }
    public function actionEditingGroup($id, $user_id)
    {
        $model = UserGroup::findOne(['group_id' => $id, 'user_id' => $user_id,]);
        $model->group_id = '';

        $groupTitles = Group::getGroupTitle();
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
