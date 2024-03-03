<?php

use yii\bootstrap5\Html;
use yii\bootstrap5\ActiveForm;
use wbraganca\dynamicform\DynamicFormWidget;

/** @var yii\web\View $this */
/** @var app\models\Test $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="test-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($modelTest, 'title')->textInput() ?>

    <?= $form->field($modelTest, 'question_count')->textInput(
        [
            'type' => 'number'
        ]
    ) ?>

    <?= $form->field($modelTest, 'subject_id')->dropDownList(
        $subjects,
        [
            'prompt' => 'выберите предмет'
        ]
    ) ?>

    <?= $this->render('_form_questions', [
        'modelsQuestion' => $modelsQuestion,
        'subjects' => $subjects,
        'form' => $form,
        'levels' => $levels,
        'modelsAnswer' => $modelsAnswer,
        'types' => $types,
    ]);
    ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>