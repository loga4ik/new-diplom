<?php

namespace app\modules\teacher\controllers;

use app\models\Level;
use app\models\Test;
use app\models\Question;
use app\models\Answer;
use app\models\QuestionType;
use yii\web\NotFoundHttpException;
use Yii;
use yii\helpers\ArrayHelper;
use app\models\Model;
use app\models\QuestionLevel;
use app\models\Subject;
use app\models\Type;
use app\modules\teacher\models\TestSearch;
use yii\base\ErrorException;
use yii\filters\VerbFilter;
use yii\helpers\VarDumper;
use yii\web\Controller;
use yii\web\UploadedFile;

/**
 * TestController implements the CRUD actions for Test model.
 */
class TestController extends Controller
{
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
        $searchModel = new TestSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Test model.
     * @param int $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        $questions = Question::getQuestionsOfTest($id);
        return $this->render('view', [
            'model' => $this->findModel($id),
            'questions' => $questions
        ]);
    }

    /**
     * Creates a new Test model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */




    public function actionCreate()
    {
        $levels = QuestionLevel::getLevels();
        $types = QuestionType::getTypes();
        $modelTest = new Test;
        $modelsQuestion = [new Question];
        $modelsAnswer = [[new Answer]];


        // VarDumper::dump($modelTest->attributes, 10, true);
        // die;

        if ($modelTest->load(Yii::$app->request->post())) {
            $modelsQuestion = Model::createMultiple(Question::class);
            Model::loadMultiple($modelsQuestion, Yii::$app->request->post());

            $modelTest->is_active = 0;
            // $modelTest->point_count = 0;

            $valid = $modelTest->validate();
            $valid = Model::validateMultiple($modelsQuestion) && $valid;

            if (isset($_POST['Answer'][0][0])) {
                foreach ($_POST['Answer'] as $indexQuestion => $answers) {
                    foreach ($answers as $indexAnswer => $answer) {

                        $data['Answer'] = $answer;
                        $modelAnswer = new Answer();
                        $modelAnswer->load($data);
                        $modelsAnswer[$indexQuestion][$indexAnswer] = $modelAnswer;
                        foreach ($modelsQuestion as $modelQuestion) {
                            if ($modelsQuestion[$indexQuestion]->type_id == QuestionType::getTypeId('Ввод ответа от студента')) {
                                $modelAnswer->scenario = $modelAnswer::SKIP_ANSWER;
                                $modelAnswer->is_true = 1;
                            }
                        }
                        VarDumper::dump($modelsQuestion[0]->attributes, 10, true);
                        // VarDumper::dump($modelAnswer[0]->validate(), 10, true);
                        die;
                        $valid = $modelAnswer->validate();
                    }
                }
            }
            if ($valid) {
                $transaction = Yii::$app->db->beginTransaction();

                try {

                    if ($flag = $modelTest->save(false)) {

                        foreach ($modelsQuestion as $indexQuestion => $modelQuestion) {
                            if ($flag === false) {
                                break;
                            }
                            $modelQuestion->test_id = $modelTest->id;


                            if ($modelQuestion->level_id == QuestionLevel::getLevelId('Сложный')) {
                                $modelQuestion->points_per_question = 3;
                            } else if ($modelQuestion->level_id == QuestionLevel::getLevelId('Средний')) {
                                $modelQuestion->points_per_question = 2;
                            } else {
                                $modelQuestion->points_per_question = 1;
                            }

                            if ($modelQuestion->imageFile = UploadedFile::getInstance($modelQuestion, "[{$indexQuestion}]imageFile")) {
                                $modelQuestion->upload();
                            }

                            if (!($flag = $modelQuestion->save(false))) {
                                break;
                            }

                            $counter = 0;

                            if (isset($modelsAnswer[$indexQuestion]) && is_array($modelsAnswer[$indexQuestion])) {
                                foreach ($modelsAnswer[$indexQuestion] as $indexAnswer => $modelAnswer) {
                                    $modelAnswer->question_id = $modelQuestion->id;
                                    if ($modelAnswer->is_true == 1) {
                                        $counter++;
                                    }

                                    if (!($flag = $modelAnswer->save(false))) {
                                        break;
                                    }
                                }
                            }

                            if ($modelQuestion->type_id == QuestionType::getTypeId('Несколько правильных ответов')) {
                                if ($counter <= 1) {
                                    Yii::$app->session->setFlash('error', 'Необходимо указать несколько вариантов ответа в вопросе №' . $indexQuestion + 1);
                                    $flag = false;
                                }
                            }
                        }
                    }

                    if ($flag) {
                        $modelTest->point_count = Test::getTestMaxPoints($modelTest->id);
                        $modelTest->save(false);
                        $transaction->commit();
                        return $this->redirect(['view', 'id' => $modelTest->id]);
                    } else {

                        $transaction->rollBack();
                    }
                } catch (ErrorException $e) {
                    var_dump($e);
                    die;
                    $transaction->rollBack();
                }
            }
        }

        return $this->render('create', [
            'modelTest' => $modelTest,
            'modelsQuestion' => (empty($modelsQuestion)) ? [new Question] : $modelsQuestion,
            'modelsAnswer' => (empty($modelsAnswer)) ? [[new Answer]] : $modelsAnswer,
            'levels' => $levels,
            'types' => $types,
            'subjects' => Subject::getAllSubject(),
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
        $modelTest = $this->findModel($id);
        $modelsQuestion = $modelTest->questions;
        $modelsAnswer = [];
        $oldAnswers = [];
        $levels = QuestionLevel::getLevels();
        $types = QuestionType::getTypes();

        if (!empty($modelsQuestion)) {
            foreach ($modelsQuestion as $indexQuestion => $modelQuestion) {
                $answers = $modelQuestion->answers;
                $modelsAnswer[$indexQuestion] = $answers;
                $oldAnswers = ArrayHelper::merge(ArrayHelper::index($answers, 'id'), $oldAnswers);
            }
        }

        if ($modelTest->load(Yii::$app->request->post())) {
            $modelsAnswer = [];
            $oldQuestionIDs = ArrayHelper::map($modelsQuestion, 'id', 'id');
            $modelsQuestion = Model::createMultiple(Question::class, $modelsQuestion);
            Model::loadMultiple($modelsQuestion, Yii::$app->request->post());
            $deletedQuestionIDs = array_diff($oldQuestionIDs, array_filter(ArrayHelper::map($modelsQuestion, 'id', 'id')));

            $valid = $modelTest->validate();
            $valid = Model::validateMultiple($modelsQuestion) && $valid;

            $answersIDs = [];

            if (isset($_POST['Answer'][0][0])) {
                foreach ($_POST['Answer'] as $indexQuestion => $answers) {
                    $answersIDs = ArrayHelper::merge($answersIDs, array_filter(ArrayHelper::getColumn($answers, 'id')));
                    foreach ($answers as $indexAnswer => $answer) {
                        $data['Answer'] = $answer;
                        $modelAnswer = (isset($answer['id']) && isset($oldAnswers[$answer['id']])) ? $oldAnswers[$answer['id']] : new Answer;
                        $modelAnswer->load($data);
                        $modelsAnswer[$indexQuestion][$indexAnswer] = $modelAnswer;
                        foreach ($modelsQuestion as $modelQuestion) {
                            if ($modelQuestion->type_id == QuestionType::getTypeId('Ввод ответа от студента')) {
                                $modelAnswer->scenario = $modelAnswer::SKIP_ANSWER;
                            }
                        }
                        $valid = $modelAnswer->validate();
                    }
                }
            }

            $oldAnswersIDs = ArrayHelper::getColumn($oldAnswers, 'id');
            $deletedAnswersIDs = array_diff($oldAnswersIDs, $answersIDs);

            if ($valid) {
                $transaction = Yii::$app->db->beginTransaction();
                try {
                    if ($flag = $modelTest->save(false)) {

                        if (!empty($deletedAnswersIDs)) {
                            Answer::deleteAll(['id' => $deletedAnswersIDs]);
                        }

                        if (!empty($deletedQuestionIDs)) {
                            Question::deleteAll(['id' => $deletedQuestionIDs]);
                        }

                        foreach ($modelsQuestion as $indexQuestion => $modelQuestion) {

                            if ($flag === false) {
                                break;
                            }

                            $modelQuestion->test_id = $modelTest->id;

                            if (!($flag = $modelQuestion->save(false))) {
                                break;
                            }

                            if (isset($modelsAnswer[$indexQuestion]) && is_array($modelsAnswer[$indexQuestion])) {
                                foreach ($modelsAnswer[$indexQuestion] as $indexAnswer => $modelAnswer) {
                                    $modelAnswer->question_id = $modelQuestion->id;

                                    if (!($flag = $modelAnswer->save(false))) {
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    if ($flag) {
                        $transaction->commit();
                        return $this->redirect(['view', 'id' => $modelTest->id]);
                    } else {
                        $transaction->rollBack();
                    }
                } catch (ErrorException $e) {
                    $transaction->rollBack();
                }
            }
        }

        return $this->render('update', [
            'modelTest' => $modelTest,
            'modelsQuestion' => (empty($modelsQuestion)) ? [new Question] : $modelsQuestion,
            'modelsAnswer' => (empty($modelsAnswer)) ? [[new Answer]] : $modelsAnswer,
            'subjects' => Subject::getAllSubject(),
            'levels' => $levels,
            'types' => $types
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
