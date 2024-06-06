<?php

use app\models\Test;
use yii\bootstrap5\Html;
use yii\bootstrap5\LinkPager;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\widgets\ListView;

/** @var yii\web\View $this */
/** @var app\models\TestSerch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Тесты';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="test-index">

    <div class=" d-flex align-items-center justify-content-between">
        <h1 class=" "><?= Html::encode($this->title) ?></h1>
        <?= Html::a('Добавить тест', ['create'], ['class' => 'btn my-btn-success']) ?>
    </div>

    <?php echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= ListView::widget([
        'dataProvider' => $dataProvider,
        'itemOptions' => ['class' => 'techer-test-item py-1'],
        'pager' => [
            'class' => LinkPager::class
        ],
        'layout' => '<ul class="teacher-test-list list-group list-group-flush" style="background-color:rgba(0, 0, 0, 0) !important;">{items}</ul>{pager}',
        'itemView' => function ($model, $key, $index, $widget) {
            return Html::a(Html::encode($model->title), ['view', 'id' => $model->id], ['style' => 'color:#3b7ddd', 'class' => 'my-2']);
        },
    ]) ?>


</div>