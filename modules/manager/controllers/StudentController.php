<?php

namespace app\modules\manager\controllers;

use app\models\Group;
use app\models\StudentTest;
use app\models\User;
use app\models\UserGroup;
use app\modules\manager\models\StudentSearch;
use Yii;
use yii\db\Query;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\VarDumper;

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
        $searchModel = new StudentSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);

        if ($group_id) {
            $users_arr = [];
            foreach (UserGroup::findAll(['group_id' => $group_id]) as $value) {
                $users_arr[] = $value->user_id;
            }
            $dataProvider->query->andWhere(['id' => $users_arr]); //, 'role' => 1
        }
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
        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
            'arrOfMarks' => StudentTest::getAllUserIdMark(),
            'groups' => getGroupsArr(),
            'groupsObj' => getGroupsObj(),
        ]);
    }

    public function actionAddGroup($user_id)
    {
        $model = UserGroup::findOne(['user_id' => $user_id]) ? UserGroup::findOne(['user_id' => $user_id]) : new UserGroup();


        if ($this->request->isPost && $model->load($this->request->post())) {
            $model->user_id = $user_id;

            if ($model->save()) {
                return $this->redirect(['view', 'id' => $model->user_id]);
            }
        }

        return $this->render('addGroup', [
            'model' => $model,
            // 'groupTitle' => Group::getGroupTitle(),
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

        if ($this->request->isPost) {
            if ($model->load($this->request->post()) && $model->save()) {
                return $this->redirect(['view', 'id' => $model->id]);
            }
        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
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
