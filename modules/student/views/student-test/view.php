<?php

use app\models\QuestionLevel;
use app\models\StudentAnswer;
use yii\helpers\Html;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\StudentTest $model */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Student Tests', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="student-test-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            // 'id',
            'points',
            'mark',
            // 'test_id',
            // 'user_id',
            'attempt',
        ],
    ]) ?>
    <?
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
            //если я нахожу в табличке student_answer совпадение
            //по id пользователя и id ответа то задаю этому ответу list-group-item list-test-item-correct
            if (StudentAnswer::getstudentAnswerByIdAndUserId($answer->id, $model->user_id) && $answer->is_true) {
                // if ($answer->id == $model->user_id) {
                // if ($answer->is_true == 1) {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item-correct'>" .
                        $answer->title .
                        "</li>"
                );
            }
            if (StudentAnswer::getstudentAnswerByIdAndUserId($answer->id, $model->user_id) && !$answer->is_true) {
                // if ($answer->id == $model->user_id) {
                // if ($answer->is_true == 1) {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item-incorrect'>" .
                        $answer->title .
                        "</li>"
                );
            } else {
                array_push(
                    $list,
                    "<li class='list-group-item list-test-item-incorrect'>" .
                        $answer->title .
                        "</li>"
                );
            }
        }
        array_push(
            $list,
            "</ul>"
        );
    }
    foreach ($list as $item) {
        echo $item;
    }
    // VarDumper::dump($list, 10, true);
    // die;
    ?>

</div>