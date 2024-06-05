<?php

use yii\bootstrap5\Html;
use yii\bootstrap5\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\User $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="user-form">

    <?php $form = ActiveForm::begin(); ?>

    <? # $form->field($model, 'name')->textInput(['type' => 'date'])        
    ?>
    <?= $form->field($model, 'name')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'surname')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'patronimyc')->textInput(['maxlength' => true]) ?>

    <? # $form->field($model, 'group_id')->textInput(['maxlength' => true])    
    ?>

    <? # $form->field($model, 'email')->textInput(['maxlength' => true])        
    ?>

    <? # $form->field($model, 'phone')->textInput(['maxlength' => true])        
    ?>

    <? # $form->field($model, 'group_id')->textInput()        
    ?>

    <? # $form->field($model, 'role_id')->textInput()        
    ?>

    <? # $form->field($model, 'auth_key')->textInput(['maxlength' => true])        
    ?>

    <div class="form-group">
        <?= Html::submitButton('Отправить', ['class' => 'btn my-btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>