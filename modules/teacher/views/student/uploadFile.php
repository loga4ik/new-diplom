<?php

use yii\bootstrap5\Html;
use yii\bootstrap5\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\User $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="user-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fileInput')->fileInput() ?>

    <?= $form->field($model, 'group_id')->dropDownList($groupArr, ['prompt' => 'выберите группу']) ?>

    <div class="form-group">
        <?= Html::submitButton('Отправить', ['class' => 'btn my-btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>