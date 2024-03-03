<?php

use app\assets\AppAsset;
use app\assets\VueAsset;
use yii\bootstrap5\Html;

/** @var yii\web\View $this */
/** @var app\models\User $model */

$this->title = 'Добавить преподавателя';
$this->params['breadcrumbs'][] = ['label' => 'Преподаватели', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-create" id="createTeacher">

    <h1>
        <?= Html::encode($this->title) ?>
        <br>
    </h1>

    <button v-on:click='isFileInputClickHandler' class="btn btn-outline-secondary">{{viewName[isFileInput+0]}}</button>

    <div v-if="isFileInput == true">
        <?= $this->render('uploadFile', [
            'model' => $model,
        ]) ?>
    </div>

    <div v-else>
        <?= $this->render('_form', [
            'model' => $model,
        ]) ?>
    </div>


</div>
<?php
$this->registerJsFile('/js/createUsers.js', [
    'depends' => [
        VueAsset::class,
    ]
]);
?>