<?php

use yii\bootstrap5\Html;
use yii\bootstrap5\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\User $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="user-form">

    <?php $form = ActiveForm::begin(); ?>

    <? # $form->field($model, 'name')->textInput(['type' => 'date'])          ?>

    <?= $form->field($model, 'group_id')->dropDownList($groupTitle, ['prompt' => 'выберите группу']) ?>

    <? # $form->field($model, 'email')->textInput(['maxlength' => true])          ?>

    <? # $form->field($model, 'phone')->textInput(['maxlength' => true])          ?>

    <? # $form->field($model, 'group_id')->textInput()          ?>

    <? # $form->field($model, 'role_id')->textInput()          ?>

    <? # $form->field($model, 'auth_key')->textInput(['maxlength' => true])          ?>

    <div class="form-group">
        <?= Html::submitButton('сохранить', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>