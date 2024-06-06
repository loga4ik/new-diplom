<?php


use yii\bootstrap5\Html;

use wbraganca\dynamicform\DynamicFormWidget;


?>


<?php DynamicFormWidget::begin([

    'widgetContainer' => 'dynamicform_inner',

    'widgetBody' => '.container-answers',

    'widgetItem' => '.answer-item',

    'limit' => 10,

    'min' => 1,

    'insertButton' => '.add-answer',

    'deleteButton' => '.remove-answer',

    'model' => $modelsAnswer[0],

    'formId' => 'dynamic-form',

    'formFields' => [
        'is_true',
        'title'
    ],

]); ?>

<div class="row d-flex justify-content-between">

    <h4 class="col-8">Ответы</h4>
    <div class="col-2">
        <button type="button" class="mb-3 p-1 add-answer btn my-btn-success btn-xs; border-radius: 100%;"><i class="fi fi-rr-plus" style="height: 20px; width: 20px; display:block"></i></button>
    </div>
</div>
<div class="container-answers">
    <?php foreach ($modelsAnswer as $indexAnswer => $modelAnswer) : ?>
        <row class="answer-item">
            <?php
            if (!$modelAnswer->isNewRecord) {
                echo Html::activeHiddenInput($modelAnswer, "[{$indexQuestion}][{$indexAnswer}]id");
            }
            ?>
            <div class="col-3">
                <?= $form->field($modelAnswer, "[{$indexQuestion}][{$indexAnswer}]imageFile")->fileInput(['class' => 'form-control custom-file-input'])->label('Изображение', ['class' => 'custom-file-label']) ?>
            </div>

            <div class="row d-flex justify-content-between align-items-center">

                <div class="col-1 d-flex justify-content-around">
                    <?= $form->field($modelAnswer, "[{$indexQuestion}][{$indexAnswer}]is_true")->label("правильный ответ", ['class' => "form-check-label w-100", 'style' => 'color:black'])->checkbox(['class' => "form-check-input"]) ?>
                </div>

                <div class="col-7">
                    <?= $form->field($modelAnswer, "[{$indexQuestion}][{$indexAnswer}]title")->label(false)->textInput(['maxlength' => true, 'class' => 'answer-input-text form-control']) ?>
                </div>

                <div class="col-2">
                    <button type="button" class="mb-3 p-1 remove-answer btn my-btn-danger btn-xs; border-radius: 100%;"><i class="fi fi-rr-cross" style="height: 20px; width: 20px; display:block"></i></button>
                </div>

            </div>
        </row>

    <?php endforeach; ?>

</div>



<?php DynamicFormWidget::end(); ?>