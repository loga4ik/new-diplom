<?php

use app\models\Group;
use yii\bootstrap5\Html;
use yii\bootstrap5\LinkPager;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\widgets\Pjax;

/** @var yii\web\View $this */
/** @var app\modules\teacher\models\GroupSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Группы';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="group-index">

    <h1>
        <?= Html::encode($this->title) ?>
    </h1>

    <p>
        <?= Html::a('Создать группу', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?php Pjax::begin(); ?>
    <?php // echo $this->render('_search', ['model' => $searchModel]);           
    ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'pager' => [
            'class' => LinkPager::class
        ],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            // [
            //     'attribute' => 'id',
            //     'format' => 'html',
            //     'filter' => false,
            //     'enableSorting' => false,
            //     'value' => fn ($model) => $model->id
            // ],
            [
                'attribute' => 'title',
                'format' => 'html',
                // 'filter' => false,
                'enableSorting' => false,
                'value' => fn ($model) => Html::a($model->title, ['../teacher/student', 'group_id' => $model->id], ['class' => 'btn btn-primary'])
            ],
            [
                'label' => '',
                'enableSorting' => false,
                'format' => 'html',
                'value' => fn ($model) => Html::a('Сменить название', ['update', 'id' => $model->id], ['class' => 'btn btn-primary'])
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>