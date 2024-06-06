<?php

use app\assets\VueAsset;
use app\models\Group;
use yii\bootstrap5\Html;
use yii\bootstrap5\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\User $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="user-form" id="editGroup">

    <?php $form = ActiveForm::begin(); ?>
    <?= 'текущая группа ' . Group::getGroupTitle($groupId) ?>
    <?= $form->field($model, 'group_id')->dropDownList($groupTitle, ['id' => 'editGroupInput', 'v-on:click' => 'isFileInputClickHandler', 'class' => 'form-control w-25', 'style' => 'min-width: 200px', 'prompt' => 'выберите группу']) ?>

    <div class="form-group">
        <?= Html::submitButton('сохранить', ['class' => 'btn my-btn-success']) ?>
        <?= Html::a('Удалить', ['../user-group/delete', 'id' => $model->id], [
            'class' => 'btn my-btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </div>


    <?php ActiveForm::end(); ?>

</div>