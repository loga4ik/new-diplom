<?php

use app\models\User;
use yii\bootstrap5\Html;
use yii\bootstrap5\LinkPager;
// use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\widgets\Pjax;

/** @var yii\web\View $this */
// /** @var app\modules\manager\models\UserSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Преподаватели';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-index">

    <h1>
        <?= Html::encode($this->title) ?>
    </h1>

    <!-- <p>
        <?= Html::a('Create User', ['create'], ['class' => 'btn my-btn-success']) ?>
    </p> -->

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
            //     'filter' => false,
            // ],
            'surname',
            'name',
            [
                'attribute' => 'login',
                'filter' => false,
            ],
            [
                'label' => '',
                'format' => 'html',
                'value' => fn ($model) => Html::a('просмотр', ['view', 'id' => $model->id], ['class' => 'btn my-btn-primary'])
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>