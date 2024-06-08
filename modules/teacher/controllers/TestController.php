<?php

namespace app\modules\teacher\controllers;

use app\models\Level;
use app\models\Test;
use app\models\Question;
use app\models\Answer;
use app\models\Group;
use app\models\GroupTest;
use app\models\QuestionType;
use yii\web\NotFoundHttpException;
use Yii;
use yii\helpers\ArrayHelper;
use app\models\Model;
use app\models\QuestionLevel;
use app\models\StudentAnswer;
use app\models\StudentTest;
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

    public function actionGetAllSubjects()
    {
        // $arr = [];
        // foreach (Subject::getAllSubject() as $key => $value) {
        //     array_push($arr, [$key => $value]);
        // }
        // return json_encode($arr);
        return json_encode(Subject::getAllSubject());
    }
    public function actionGetAllLevels()
    {
        // ['asd' => 'asd'];
        return json_encode(QuestionLevel::getLevels());
    }
    public function actionGetAllTypes()
    {
        // ['asd' => 'asd'];
        return json_encode(QuestionType::getTypes());
    }
    /**
     * Displays a single Test model.
     * @param int $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id, $student_test_id = null, $user_id = null)
    {
        $questions = Question::getQuestionsOfTest($id);

        return $this->render('view', [
            'model' => $this->findModel($id),
            'questions' => $questions,
            'student_test_id' => $student_test_id,
            'user_id' => $user_id,
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
                        $valid = $modelAnswer->validate();
                        // VarDumper::dump($modelAnswer->errors, 10, true);
                        //                         die;
                    }
                }
            }
            if ($valid) {
                $transaction = Yii::$app->db->beginTransaction();

                try {
                    $modelTest->question_count = count($modelsQuestion);
                    // Добавляем минуты, указанные в $testModel->duration
                    if (!$modelTest->duration) {
                        $modelTest->duration = 20;
                    } 
                    // VarDumper::dump($modelTest->attributes, 10, true);
                    // die;
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
                                    if ($modelAnswer->imageFile = UploadedFile::getInstance($modelAnswer, "[{$indexQuestion}][{$indexAnswer}]imageFile")) {
                                        $modelAnswer->upload();
                                    }
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
                                    Yii::$app->session->setFlash('danger', 'Необходимо указать несколько вариантов ответа в вопросе №' . $indexQuestion + 1);
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
                    // var_dump($e);
                    // die;
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

    public function actionChengeActiveTest($test_id)
    {
        $model = new GroupTest();
        $testModel = Test::findOne(['id' => $test_id]);


        if (!$testModel->is_active) {
            if ($this->request->isPost) {
                if ($model->load($this->request->post())) {
                    if (Test::getActiveTest($model->group_id)) {
                        Yii::$app->session->setFlash('danger', 'у этой группы уже есть активный тест');
                        return $this->redirect('../../teacher/test');
                    }
                    $testModel->is_active = +!$testModel->is_active;
                    $model->test_id = $test_id;

                    $currentDateTime = new \DateTime();

                    // Добавляем минуты, указанные в $testModel->duration
                    
                    $currentDateTime->modify('+' . $testModel->duration . ' minutes');

                    // Форматируем в нужный формат
                    $formattedDateTime = Yii::$app->formatter->asDatetime($currentDateTime->format('Y-m-d H:i:s'), 'php:Y-m-d H:i:s');

                    // Присваиваем отформатированную дату и время $model->end_time
                    $model->end_time = $formattedDateTime;

                    // $testModel->duration ; // минуты(int) которые необходимо добавить к end_time  
                    // $model->end_time = Yii::$app->formatter->asDatetime(strtotime(date('Y-m-d H:i:s')),'php:Y-m-d H:i:s');
                    $model->validate();
                    if ($model->save() && $testModel->save()) {
                        // VarDumper::dump($model->attributes, 10, true);
                        // die;
                        Yii::$app->session->setFlash('success', 'тест открыт');
                        return $this->redirect('../../teacher/test');
                    }
                }
            } else {
                $model->loadDefaultValues();
            }

            return $this->render('group-test-create', [
                'model' => $model,
                'groupArr' => Group::getAllGroupTitle(),
            ]);
        } else {
            $testModel->is_active = +!$testModel->is_active;
            if ($testModel->save()) {
                // $evtSource = new EventSource("ssedemo.php");
                Yii::$app->session->setFlash('success', 'тест закрыт');
                return $this->redirect('../../teacher/test');
            }
        }
    }
    // public function actionIndex()
    // {
    //     $searchModel = new TeacherSearch();
    //     $dataProvider = $searchModel->search($this->request->queryParams);

    //     return $this->render('index', [
    //         'searchModel' => $searchModel,
    //         'dataProvider' => $dataProvider,
    //     ]);
    // }
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

    public function actionAccept($test_id, $student_test_id, $user_id, $answer_id)
    {
        $test = Test::findOne(['id' => $test_id]);
        $studentTest = StudentTest::findOne(['id' => $student_test_id]);
        $answer = Answer::findOne(['id' => $answer_id]);
        $studentAnswer = StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => $studentTest->attempt, 'answer_id' => $answer_id]);
        $studentAnswer->cheked = true;
        $studentAnswer->save(false);

        if (!StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => $studentTest->attempt, 'cheked' => 0])) {
            $studentTest->cheked = 1;
        }
        $studentTest->save();
        return $this->redirect('../../teacher/test/view?id=' . $test_id . '&user_id=' . $user_id . '&student_test_id=' . $student_test_id);
    }

    public function actionDeny($test_id, $student_test_id, $user_id, $answer_id)
    {
        $test = Test::findOne(['id' => $test_id]);
        $studentTest = StudentTest::findOne(['id' => $student_test_id]);
        $answer = Answer::findOne(['id' => $answer_id]);
        $studentAnswer = StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => $studentTest->attempt, 'answer_id' => $answer_id]);
        $studentAnswer->cheked = true;
        $studentAnswer->is_true = 0;
        $studentAnswer->save(false);

        if (!StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => $studentTest->attempt, 'cheked' => 0])) {
            $studentTest->cheked = 1;
        }
        $percent =  ($studentTest->points - Question::findOne(['id' => $answer->question_id])->points_per_question) * 100 / $test->point_count;
        if ($percent >= 80) {
            $mark = 5;
        } elseif ($percent < 80 && $percent >= 60) {
            $mark = 4;
        } elseif ($percent < 60 && $percent >= 40) {
            $mark = 3;
        } else {
            $mark = 2;
        }
        $studentTest->mark = $mark;
        $studentTest->save();
        return $this->redirect('../../teacher/test/view?id=' . $test_id . '&user_id=' . $user_id . '&student_test_id=' . $student_test_id);
    }
}
