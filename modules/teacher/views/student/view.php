<?php

use app\models\StudentTest;
use dosamigos\chartjs\ChartJs;
use yii\helpers\Html;
use yii\helpers\VarDumper;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\User $model */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Users', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="user-view">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php
    $getArrOfMarks = function ($model) {
        $arrOfMarks = [
            "2" => 0,
            "3" => 0,
            "4" => 0,
            "5" => 0,
        ];
        foreach (StudentTest::getStudentsResults($model->id) as $value) {
            $arrOfMarks[$value] += 1;
        };
        return $arrOfMarks;
    };

    ?>
    <?=
    // VarDumper::dump([...$getArrOfMarks($model)], 10, true);
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
            'labels' => ["2", "3", "4", "5"],
            'datasets' => [
                [
                    'label' => '# of Votes',
                    'data' => [...$getArrOfMarks($model)],
                    // 'borderColor' => ['#F95C68FF'],
                    'backgroundColor' => ['#F95C68FF', '#F07427FF', '#7CC7DFFF', '#50C878FF'],
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
            'name',
            'surname',
            'patronimyc',
            'login',
            'password',
            'email:email',
            'phone',
            'role_id',
            'auth_key',
        ],
    ]) ?>

</div>