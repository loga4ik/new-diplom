<?php

use yii\bootstrap5\Html;

/** @var yii\web\View $this */
/** @var app\models\Test $model */

$this->title = 'Создание теста';
$this->params['breadcrumbs'][] = ['label' => 'Tests', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="test-create">

    <h1><?= Html::encode($this->title) ?></h1>
    <?= $this->render('_form', [
        'modelTest' => $modelTest,
        'modelsQuestion' => $modelsQuestion,
        'modelsAnswer' => $modelsAnswer,
        'levels' => $levels,
        'types' => $types,
        'subjects' => $subjects,
    ]) ?>

</div>