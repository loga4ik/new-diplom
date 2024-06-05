<?php

use app\models\GroupTest;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\widgets\Pjax;
/** @var yii\web\View $this */
/** @var app\modules\teacher\models\GroupTestSeach $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Group Tests';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="group-test-index">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Create Group Test', ['create'], ['class' => 'btn my-btn-success']) ?>
    </p>

    <?php Pjax::begin(); ?>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'test_id',
            'group_id',
            [
                'class' => ActionColumn::className(),
                'urlCreator' => function ($action, GroupTest $model, $key, $index, $column) {
                    return Url::toRoute([$action, 'id' => $model->id]);
                 }
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>
