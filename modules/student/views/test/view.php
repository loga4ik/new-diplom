<?php

use app\models\QuestionLevel;
use app\models\StudentAnswer;
use app\models\StudentTest;
use app\models\Subject;
use yii\helpers\Html;
use yii\helpers\VarDumper;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\Test $model */

$this->title = $model->title;
$this->params['breadcrumbs'][] = ['label' => 'Tests', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
$studentTest = StudentTest::findOne(['id' => $student_test_id])
?>
<div class="test-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            [
                'label' => 'оценка',
                'value' => $studentTest->mark
            ],
            [
                'label' => 'воличество баллов',
                'value' => $studentTest->points
            ],
            [
                'attribute' => 'subject_id',
                'value' => Subject::getSubjectTitle($model->subject_id)
            ],
        ],
    ]) ?>

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
        $user_id = StudentTest::findOne(['id' => $student_test_id])->user_id;

        // VarDumper::dump($user_id,10,true);die;
        foreach ($question->answers as $answer) {
            //если я нахожу в табличке student_answer совпадение
            //если надо вывести и правильные ответы и те, которфые вывел пользователь
            // VarDumper::dump(["answer_id" => $answer->id, "user_id" => $user_id, 'attempt' => StudentTest::findOne(['id' => $student_test_id])->attempt], 10, true);

            if ($user_id && StudentAnswer::getstudentAnswerByIdAndUserId($answer->id, $user_id, $student_test_id)) {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-user d-flex justify-content-between'>" .
                        $answer->title . "</li>"

                );
            } else {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item'>" .
                        $answer->title .
                        "</li>"
                );
            }
        }
        // die;
        array_push(
            $list,
            "</ul>"
        );
        // die;
    }
    foreach ($list as $item) {
        echo $item;
    }
    ?>

</div>