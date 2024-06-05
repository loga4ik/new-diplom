<?php

use app\models\Answer;
use app\models\Level;
use yii\bootstrap5\Html;
use yii\widgets\DetailView;
use app\models\Question;
use app\models\QuestionLevel;
use app\models\QuestionType;
use app\models\StudentAnswer;
use app\models\StudentTest;
use app\models\Test;
use yii\helpers\VarDumper;

/** @var yii\web\View $this */
/** @var app\models\Test $model */

$this->title = $model->title;
$this->params['breadcrumbs'][] = ['label' => 'Тесты', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="test-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= !$user_id ?  Html::a('Изменить', ['update', 'id' => $model->id], ['class' => 'btn my-btn-success mx-1']) .
            Html::a($model->is_active ? 'закрыть тест' : 'открыть тест', ['chenge-active-test', 'test_id' => $model->id], ['class' => 'btn my-btn-primary mx-1']) .
            Html::a('Удалить', ['delete', 'id' => $model->id], [
                'class' => 'btn my-btn-danger mx-1',
                'data' => [
                    'confirm' => 'Вы действительно хотите удалить тест?',
                    'method' => 'post',
                ],
            ]) : '' ?>
    </p>

    <?php
    $list = [];
    foreach ($model->questions as $question) {
        if ($question->level_id == QuestionLevel::getLevelId('Лёгкий')) {
            $level = 'question-easy';
        } elseif ($question->level_id == QuestionLevel::getLevelId('Средний')) {
            $level = 'question-mid';
        } else {
            $level = 'question-hard';
        }
        array_push(
            $list,
            "<ul class='test-list ' >" .
                "<li class='list-group-item list-test-question  {$level}' style='font-weight:bold'>" .
                $question->text .
                "</li>"
        );
        foreach ($question->answers as $answer) {
            if ($answer->is_true && !$user_id) {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item-correct'>" .
                        $answer->title .
                        "</li>"
                );
            } elseif ($user_id && !$answer->is_true && StudentAnswer::getstudentAnswerByIdAndUserId($answer->id, $user_id, $student_test_id)) {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item-user-incorrect'>" .
                        $answer->title .
                        "</li>"
                );
            } elseif (
                $user_id
                && StudentAnswer::getstudentAnswerByIdAndUserId($answer->id, $user_id, $student_test_id)
                && !StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => StudentTest::findOne(['id' => $student_test_id])->attempt, 'answer_id' => $answer->id])->cheked
            ) {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item-correct d-flex justify-content-between'>" .
                        StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => $studentTest->attempt, 'answer_id' => $answer_id])->answer_title
                        ? StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => $studentTest->attempt, 'answer_id' => $answer_id])
                        : $answer->title . "<div>" .
                        Html::a('Одобрить', [
                            './test/accept',
                            'test_id' => $model->id,
                            'student_test_id' => $student_test_id,
                            'user_id' => $user_id,
                            'answer_id' => $answer->id
                        ], ['class' => 'btn my-btn-success p-1 mx-1']) .
                        Html::a('Отклонить', [
                            './test/deny',
                            'test_id' => $model->id,
                            'student_test_id' => $student_test_id,
                            'user_id' => $user_id,
                            'answer_id' => $answer->id
                        ], ['class' => 'btn my-btn-danger p-1 mx-1']) .
                        "</div></li>"
                );
                // } elseif (
                //     $user_id && $answer->is_true
                //     && StudentAnswer::getstudentAnswerByIdAndUserId($answer->id, $user_id, $student_test_id)
                //     && $question->type_id == QuestionType::getTypeId('Ввод ответа от студента')
                // ) {
                //     array_push(
                //         $list,
                //         "<li class='list-group-item list-test-item-correct d-flex justify-content-between'>" .
                //             StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => StudentTest::findOne(['id' => $student_test_id])->attempt, 'answer_id' => $answer->id])->answer_title
                //             ? StudentAnswer::findOne(['user_id' => $user_id, 'attempt' => StudentTest::findOne(['id' => $student_test_id])->attempt, 'answer_id' => $answer->id])->answer_title
                //             : $answer->title . "</li>"

                //     );
            } elseif ($user_id && $answer->is_true && StudentAnswer::getstudentAnswerByIdAndUserId($answer->id, $user_id, $student_test_id)) {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item-correct d-flex justify-content-between'>" .
                        $answer->title . "</li>"

                );
            } else {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item-incorrect '>" .
                        $answer->title .
                        "</li>"
                );
            }
        }
        array_push(
            $list,
            "</ul>"
        );
    } ?>
    <?php foreach ($list as $item) {
        echo $item;
    }
    // VarDumper::dump($list, 10, true);
    // die;
    ?>


</div>