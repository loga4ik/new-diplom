<?php

use app\assets\VueAsset;
use yii\bootstrap5\Html;
use yii\bootstrap5\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\User $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="user-form" id="editGroup">

    <?php $form = ActiveForm::begin(); ?>
    <?= 'текущая группа ' . $groupId ?>
    <?= $form->field($model, 'group_id')->dropDownList($groupTitle, ['id' => 'editGroupInput', 'v-on:click' => 'isFileInputClickHandler', 'prompt' => 'выберите группу']) ?>

    <div class="form-group">
        <?= Html::submitButton('сохранить', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>