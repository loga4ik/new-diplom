<?php

namespace app\modules\student\controllers;

use app\models\Answer;
use app\models\GroupTest;
use app\models\Question;
use app\models\StudentAnswer;
use app\models\StudentTest;
use app\models\Test;
use app\modules\student\models\TestSeach;
use DateTime;
use Yii;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\VarDumper;

/**
 * TestController implements the CRUD actions for Test model.
 */
class TestController extends Controller
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
     * Lists all Test models.
     *
     * @return string
     */
    public function actionIndex()
    {

        $group_test_id = GroupTest::getGroupTestId();
        $end_time = GroupTest::findOne(['id' => $group_test_id])->end_time;
        $current_time = date('Y-m-d H:i:s');
        $isValidTime = strtotime($end_time) > strtotime($current_time);


        $session = Yii::$app->session;
        // VarDumper::dump($isValidTime, 10, true);
        // die;
        $current_question = Yii::$app->request->post('question');
        $current_question = empty($current_question) ? 1 : $current_question;
        $test_id = $group_test_id->test_id;
        $attempt = 0;
        $attempt = StudentAnswer::getLastAttempt($group_test_id) + 1;

        if (!$isValidTime) {
            StudentTest::createStudentTest($test_id, $group_test_id, $attempt, Yii::$app->user->identity->id, $isValidTime);

            Yii::$app->session->setFlash('danger', 'время закончилось');
            return $this->redirect('/');
        }

        $modelStudentAnswer = new StudentAnswer();
        if ($this->request->isPost) {
            if (isset($_POST['StudentAnswer'])) {
                if (is_array($_POST['StudentAnswer']['answer_id'])) {
                    foreach ($_POST['StudentAnswer']['answer_id'] as $answer_id) {
                        $modelStudentAnswer = new StudentAnswer();
                        $modelStudentAnswer->user_id = Yii::$app->user->identity->id;
                        $modelStudentAnswer->question_id = $_POST['StudentAnswer']['question_id'];
                        $modelStudentAnswer->answer_id = $answer_id;
                        $modelStudentAnswer->attempt = $attempt;
                        $modelStudentAnswer->is_true = $isValidTime ? Answer::findOne(['id' => $modelStudentAnswer->answer_id])->is_true : $isValidTime;
                        $modelStudentAnswer->save();
                    }
                } else {
                    $modelStudentAnswer = new StudentAnswer();
                    $modelStudentAnswer->user_id = Yii::$app->user->identity->id;
                    $modelStudentAnswer->question_id = $_POST['StudentAnswer']['question_id'];
                    $modelStudentAnswer->load($this->request->post());
                    $modelStudentAnswer->is_true = $isValidTime ? Answer::findOne(['id' => $modelStudentAnswer->answer_id])->is_true : $isValidTime;
                    $modelStudentAnswer->save();
                }
                $current_question++;
            }
        }
        if ($current_question > 1) {
            $questions_square = $session->get('questions_square');
            $questions_square[$current_question - 1] = 'passed';
            $questions_square[$current_question] = 'current_question';
            $passed_questions = $session->get('passed_questions');
            $passed_questions[$_POST['StudentAnswer']['question_id']] = $_POST['StudentAnswer']['answer_id'];
        } else {
            $questions_square = Test::getTestQuestionsList($group_test_id);
            $questions_square[1] = 'current_question';
            $current_question = 1;
            $passed_questions = [];
        }
        $session->set('passed_questions', $passed_questions);

        $question_id = Test::getNextQuestion($session->get('passed_questions'), $test_id);
        // VarDumper::dump($question_id,10,true);die;

        if (!$question_id) {
            if (StudentTest::createStudentTest($test_id, $group_test_id, $attempt, Yii::$app->user->identity->id, $isValidTime)) {
                if (GroupTest::changeGroupTest($group_test_id)) {
                    StudentTest::getIsChecked(Yii::$app->user->identity->id, $group_test_id, $attempt);
                    return $this->redirect('/student');
                }
            } else {
                return true;
            }
        }

        $question = Question::findOne($question_id);
        $answers = Answer::find()
            ->select(['title', 'image', 'id'])
            ->where(['question_id' => $question->id])
            ->indexBy('id')
            ->all();
        // VarDumper::dump($answers, 10, true);
        // die;

        $session->set('questions_square',  $questions_square);

        $questions_str = join(array_map(fn ($question_key, $question) => "<div class='vertical-divider-item {$question} question-square text-center'><span style='display: block;'>{$question_key}</span></div>", array_keys($questions_square), $questions_square));

        $test_title = Test::findOne($test_id)->title;

        return $this->render(
            'index',
            [
                'group_test_id' => $group_test_id,
                'question' => $question,
                'modelStudentAnswer' => $modelStudentAnswer,
                'answers' => $answers,
                'questions_str' => $questions_str,
                'current_question' => $current_question,
                'test_title' => $test_title,
                'attempt' => $attempt
            ]
        );
    }

    /**
     * Displays a single Test model.
     * @param int $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id, $student_test_id)
    {
        // VarDumper::dump($user_id,10,true);die;

        return $this->render('view', [
            'model' => $this->findModel($id),
            'student_test_id' => $student_test_id,
        ]);
    }

    /**
     * Creates a new Test model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    public function actionCreate()
    {
        $model = new Test();

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
     * Updates an existing Test model.
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
     * Deletes an existing Test model.
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
     * Finds the Test model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param int $id ID
     * @return Test the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Test::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
