<?php

use app\models\StudentTest;
use app\models\Subject;
use app\models\Test;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\bootstrap5\Html;

/** @var yii\web\View $this */
/** @var app\modules\student\models\StudentTestSeach $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'мои оценки';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="student-test-index">

    <h1><?= Html::encode($this->title) ?></h1>

    <?php Pjax::begin(); ?>
    <style>
        th {
            color: #007bff;
        }
    </style>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'summary' => false,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            // 'id',
            // 'test_id',
            [
                'label' => 'предмет',
                'value' => fn ($model) => Subject::getSubjectTitle(Test::findOne(['id', $model->test_id])->subject_id)
            ],
            [
                'attribute' => 'test_id',
                'label' => 'тест',
                'value' => fn ($model) => Test::getTestTitle($model->test_id)
            ],
            [
                'attribute' => 'mark',
                'format' => 'html',
                'value' => fn ($model) => '<div style="display:flex;justify-content:center;">' . $model->mark . '</div>'
            ],
            'points',
            'attempt',
            [
                'attribute' => 'cheked',
                'value' => fn ($model) => $model->cheked ? 'проверено' : 'на проверке'
            ],
            [
                'label' => 'рейтинг в классе',
                'value' => fn ($model) => StudentTest::getPlaceInClass($model->test_id)
            ],
            [
                // 'title' => 'просмотр',
                'format' => 'html',
                'value' => fn ($model) => Html::a('просмотр', ['/student/test/view', 'id' => $model->test_id, 'student_test_id' => $model->id], ['class' => 'btn my-btn-primary']),
            ],

        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>