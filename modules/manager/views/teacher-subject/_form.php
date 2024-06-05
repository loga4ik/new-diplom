<?php

use yii\bootstrap5\Html;
use yii\bootstrap5\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\TeacherSubject $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="teacher-subject-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'user_id')->dropDownList($users, ['prompt' => 'выберите преподавателя']) ?>

    <?= $form->field($model, 'subject_id')->dropDownList($subjects, ['prompt' => 'выберите предмет']) ?>

    <div class="form-group">
        <?= Html::submitButton('добавить', ['class' => 'btn my-btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>