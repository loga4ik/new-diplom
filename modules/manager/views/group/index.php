<?php

use app\models\Group;
use yii\bootstrap5\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\widgets\Pjax;

/** @var yii\web\View $this */
/** @var app\modules\manager\models\GroupSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Группы';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="group-index">

    <h1>
        <?= Html::encode($this->title) ?>
    </h1>

    <p>
        <?= Html::a('Добавить группу', ['create'], ['class' => 'btn my-btn-success']) ?>
    </p>

    <?php Pjax::begin(); ?>
    <?php // echo $this->render('_search', ['model' => $searchModel]);  
    ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            // 'title',
            [
                'attribute' => 'title',
                'format' => 'html',
                'value' => fn ($model) => html::a($model->title, ['./student', 'group_id' => $model->id], ['class' => 'btn my-btn-primary'])
            ],
            [
                'class' => ActionColumn::className(),
                'urlCreator' => function ($action, Group $model, $key, $index, $column) {
                    return Url::toRoute([$action, 'id' => $model->id]);
                }
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>