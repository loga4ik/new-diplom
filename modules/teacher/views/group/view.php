<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\Group $model */

$this->title = $model->title;
$this->params['breadcrumbs'][] = ['label' => 'группы', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="group-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <div class="d-flex justify-content-between mb-3">
        <div>
            <?= Html::a('переименовать', ['update', 'id' => $model->id], ['class' => 'btn my-btn-primary']) ?>
            <?= Html::a('удалить', ['delete', 'id' => $model->id], [
                'class' => 'btn my-btn-danger',
                'data' => [
                    'confirm' => 'Are you sure you want to delete this item?',
                    'method' => 'post',
                ],
            ]) ?>
        </div>
    </div>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'title',
        ],
    ]) ?>

</div>