<?php

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
            'id',
            'mark',
            'point',
            'test_id',
            'user_id',
            'try',
        ],
    ]) ?>

</div>
