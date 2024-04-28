<?php

use app\models\User;
use app\models\UserGroup;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;
use yii\helpers\ArrayHelper;
use yii\helpers\VarDumper;
use yii\widgets\Pjax;

use function PHPUnit\Framework\isEmpty;

/** @var yii\web\View $this */
/** @var app\modules\teacher\models\StudentSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Список студентов';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-index">

    <h1>
        <?= Html::encode($this->title) ?>
    </h1>
    <p>
        <?= Html::a('добавить студента', ['../teacher/student/create'], ['class' => 'btn btn-success']) ?>
        <?= $group_id ? Html::a('скачать список', ['download-list', 'id' => $group_id], ['class' => 'btn btn-primary']) : '' ?>
    </p>

    <?php Pjax::begin(); ?>
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
    <?php
    // VarDumper::dump($groups, 10, true); //64
    // die;
    // VarDumper::dump($model, 10, true);
    ?>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
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
                'label' => 'group_id',
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
                'value' => fn ($model) => Html::a('просмотр', ['view', 'id' => $model->id], ['class' => 'btn btn-primary']),
            ],
        ],
    ]); ?>

    <?php Pjax::end(); ?>

</div>