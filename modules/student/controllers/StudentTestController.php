<?php

namespace app\modules\student\controllers;

use app\models\StudentTest;
use app\models\UserGroup;
use app\modules\student\models\StudentTestSeach;
use Yii;
use yii\db\Query;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\VarDumper;

/**
 * StudentTestController implements the CRUD actions for StudentTest model.
 */
class StudentTestController extends Controller
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
     * Lists all StudentTest models.
     *
     * @return string
     */
    public function actionIndex()
    {
        $searchModel = new StudentTestSeach();
        $dataProvider = $searchModel->search($this->request->queryParams);
        $group_id = UserGroup::findOne(['user_id' => Yii::$app->user->id]);
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
        $activeUsersAVGmark = $getAVGmark(StudentTest::getStudentsResults(Yii::$app->user->id));
        array_multisort($arrOfAllUsersMarks, SORT_DESC);
        // VarDumper::dump($arrOfAllUsersMarks, 10, true);
        // die;
        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
            'placeInClass' => array_search($activeUsersAVGmark, $arrOfAllUsersMarks) + 1,
        ]);
    }

    /**
     * Displays a single StudentTest model.
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
     * Creates a new StudentTest model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    public function actionCreate()
    {
        $model = new StudentTest();

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
     * Updates an existing StudentTest model.
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
     * Deletes an existing StudentTest model.
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
     * Finds the StudentTest model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param int $id ID
     * @return StudentTest the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = StudentTest::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
