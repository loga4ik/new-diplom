<?php

use app\models\StudentTest;
use dosamigos\chartjs\ChartJs;
use yii\helpers\Html;
use yii\helpers\VarDumper;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\Test $model */

$this->title = $model->title;
$this->params['breadcrumbs'][] = ['label' => 'Tests', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="test-view">

    <h1><?= Html::encode($this->title) ?></h1>
    <h3 style="color: red;">предумать способ как подвязать тест к каждой группе, чтобы показывать сколько студентов прошли тест(ну и для прохождения теста)</h3>
    <h4>как вариант можно созать еще 1 табличку и подвязывать туде группу и тест</h4>
    <?php
    // $getArrIsPassed = function ($model) {
    //     $arrIsPassed = [
    //         "2" => 0,
    //         "3" => 0,
    //         "4" => 0,
    //         "5" => 0,
    //         "прошли" => 0,
    //         "не прошли" => 0,
    //     ];
    //     foreach (StudentTest::getTestResults($model->id) as $key => $value) {
    //         $arrIsPassed[$value] += 1;
    //     };
    //     return $arrIsPassed;
    // };
    $getArrOfMarks = function ($model) {
        $arrOfMarks = [
            "2" => 0,
            "3" => 0,
            "4" => 0,
            "5" => 0,
        ];
        foreach (StudentTest::getTestResults($model->id) as $value) {
            $arrOfMarks[$value] += 1;
        };
        return $arrOfMarks;
    };

    ?>
    <?=
    ChartJs::widget([
        'type' => 'doughnut',
        'options' => [
            'height' => 200,
            'width' => 600,
            // 'scales' => [
            //     'x' => ['max' => 150],
            //     'y' => ['max' => 150],
            // ]
        ],
        'data' => [
            'labels' => ["2", "3", "4", "5", "прошли", "не прошли"],
            // 'labels' => ["прошли", "не прошли"],
            'datasets' => [
                [
                    'label' => '# of Votes',
                    'data' => [...$getArrOfMarks($model)],
                    // 'borderColor' => ['#F95C68FF'],
                    'backgroundColor' => ['#F95C68FF', '#F07427FF', '#7CC7DFFF', '#50C878FF'],
                ],
                [
                    'label' => '# of Votes',
                    //тут поставить массив прошедших тест
                    'data' => ['', '', '', '', 2, 4]
                ]
            ]
        ]
    ]);
    ?>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'title:ntext',
            'question_count',
            'point_count',
            'subject_id',
            'is_active',
        ],
    ]) ?>

</div>