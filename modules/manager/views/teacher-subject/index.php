<?php

use app\models\Subject;
use app\models\TeacherSubject;
use app\models\User;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\widgets\Pjax;

/** @var yii\web\View $this */
/** @var app\modules\manager\models\TeacherSubjectSeach $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Предметы и преподаватели';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="teacher-subject-index">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Добавить предмет преподавателю', ['create'], ['class' => 'btn my-btn-success']) ?>
    </p>

    <?php Pjax::begin(); ?>
    <?php // echo $this->render('_search', ['model' => $searchModel]); 
    ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            [
                'attribute' => 'user_id',
                'value' => fn ($model) => User::getUserName($model->user_id)
            ],
            [
                'attribute' => 'subject_id',
                'value' => fn ($model) => Subject::getSubjectTitle($model->subject_id)
            ],
            [
                'class' => ActionColumn::className(),
                'urlCreator' => function ($action, TeacherSubject $model, $key, $index, $column) {
                    return Url::toRoute([$action, 'id' => $model->id]);
                }
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>