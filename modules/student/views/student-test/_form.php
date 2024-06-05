<?php

use app\models\Test;
use yii\helpers\Html;
use yii\helpers\VarDumper;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\StudentTest $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="student-test-form">

    <?php $form = ActiveForm::begin(); ?>
    <?php
    VarDumper::dump(Test::getFindActiveTest(), 10, true);
    ?>
    <?= $form->field($model, 'mark')->textInput() ?>

    <?= $form->field($model, 'point')->textInput() ?>

    <?= $form->field($model, 'test_id')->textInput() ?>

    <?= $form->field($model, 'user_id')->textInput() ?>

    <?= $form->field($model, 'try')->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn my-btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>