<?php

use app\models\User;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\helpers\VarDumper;
use yii\widgets\Pjax;

/** @var yii\web\View $this */
/** @var app\modules\teacher\models\StudentSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Список студентов';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-index">

    <h1>
        <?= Html::encode($this->title) ?>
    </h1>

    <p>
        <?= Html::a('добавить студента', ['../teacher/student/create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?php Pjax::begin(); ?>
    <?php
    $getAvarageMark = function ($user_id, $arrOfMarks) {
        $marks = [];
        $averageMark = 0;
        foreach ($arrOfMarks as $value) {
            if ($value['user_id'] == $user_id) {
                $marks[] = $value['mark'];
            }
        }
        $averageMark = round(array_sum($marks) / count($marks), 2);
        return $averageMark;
    };
    ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'summary' => false,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            [
                'attribute' => 'surname',
                'enableSorting' => false,
                'value' => fn ($model) => $model->surname,
            ],
            [
                'attribute' => 'name',
                'enableSorting' => false,
                'value' => fn ($model) => $model->name,
            ],
            [
                'attribute' => 'login',
                'enableSorting' => false,
                'filter' => false,
            ],
            [
                'label' => 'средний балл',
                'visible' => (bool)$arrOfMarks,
                'value' => fn ($model) => $getAvarageMark($model->id, $arrOfMarks)
            ],
            [
                'label' => '',
                'format' => 'html',
                'value' => fn ($model) => Html::a('просмотр', ['view', 'id' => $model->id], ['class' => 'btn btn-primary'])
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>