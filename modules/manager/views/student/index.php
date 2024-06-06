<?php

use app\models\User;
use yii\bootstrap5\LinkPager;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\helpers\ArrayHelper;
use yii\widgets\Pjax;

/** @var yii\web\View $this */
/** @var app\modules\manager\models\StudentSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'студенты';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-index">

    <h1>
        <?= Html::encode($this->title) ?>
    </h1>

    <?php Pjax::begin(); ?>
    <?php // echo $this->render('_search', ['model' => $searchModel]);  
    ?>
    <?php
    // header('http' . (isset($_SERVER['HTTPS']) ? 's' : '') . '://' . $_SERVER['HTTP_HOST'] . $_SERVER['SCRIPT_NAME']);
    function getAvarageMark($user_id, $arrOfMarks)
    {
        // VarDumper::dump($arrOfMarks, 10, true);
        // die;
        $marks = [];
        $averageMark = 0;
        foreach ($arrOfMarks as $value) {
            if ($value['user_id'] == $user_id) {
                $marks[] = $value['mark'];
            }
        }
        if (empty($arrOfMarks) || !$marks) {
            return 'нет пройденных тестов';
        }
        $averageMark = round(array_sum($marks) / count($marks), 2);
        return $averageMark;
    };
    ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'pager' => [
            'class' => LinkPager::class
        ],
        'summary' => false,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            [
                'attribute' => 'surname',
                'enableSorting' => false,
                'value' => fn ($model) => $model->surname,
            ],
            [
                'attribute' => 'name',
                'enableSorting' => false,
                'value' => fn ($model) => $model->name,
            ],
            [
                'attribute' => 'login',
                'enableSorting' => false,
                'filter' => false,
            ],
            [
                'label' => 'группа',
                // 'enableSorting' => false,
                'filter' => Html::activeDropDownList($searchModel, 'id', ArrayHelper::map($groupsObj, 'title', 'title'), ['class' => 'form-control', 'prompt' => 'Выберите группу']),
                // 'filter' => fn ($model) => $form->field($model, 'group_id')->dropDownList($groupArr, ['prompt' => 'выберите группу']),
                'value' => fn ($model) => $groups[$model->id],
            ],
            [
                'label' => 'средний балл',
                'visible' => (bool)$arrOfMarks,
                'value' => fn ($model) => getAvarageMark($model->id, $arrOfMarks),
            ],
            [
                'label' => '',
                'format' => 'html',
                'value' => fn ($model) => Html::a('просмотр', ['view', 'id' => $model->id], ['class' => 'btn my-btn-primary']),
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>