<?php

use app\models\StudentTest;
use app\models\Test;
use app\models\User;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\helpers\VarDumper;
use yii\widgets\Pjax;

/** @var yii\web\View $this */
/** @var app\modules\teacher\models\StudentTestSeach $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'проверка тестов';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="student-test-index">

    <h1><?= Html::encode($this->title) ?></h1>


    <?php Pjax::begin(); ?>
    <?php // echo $this->render('_search', ['model' => $searchModel]); 
    // VarDumper::dump($model, 10, true);
    //             die;
    ?>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        // 'filter' => false,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            // 'id',
            // 'points',
            [
                'attribute' => 'points',
                'label' => 'предв. баллы',
                'value' => fn ($model) => $model->points
            ],
            'mark',
            // 'test_id',
            [
                'attribute' => 'test_id',
                'value' => fn ($model) => Test::getTestTitle($model->test_id)
            ],
            [
                'attribute' => 'user_id',
                'value' => fn ($model) => User::getUserName($model->user_id)
            ],
            //'group_test_id',
            // 'cheked',
            //'date',
            //'attempt',
            //'ip',
            [
                'label' => 'действия',
                'format' => 'html',
                'value' => fn ($model) => Html::a('Проверить', ['test/view', 'id' => $model->test_id, 'user_id' => $model->user_id, 'student_test_id' => $model->id], ['class' => 'btn my-btn-primary'])
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>