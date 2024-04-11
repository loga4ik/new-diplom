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

<div class="row">

    <h4 class="col-8">Ответы</h4>
    <div class="col-4">
        <button type="button" class="mb-3 p-1 add-answer btn btn-success btn-xs " style="width: auto;"><i class="fi fi-rr-plus" style="height: 15px; width: 15px; display:block"></i></button>
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
            <div class="row d-flex align-items-center">

                <div class="col-1 d-flex justify-content-around">
                    <?= $form->field($modelAnswer, "[{$indexQuestion}][{$indexAnswer}]is_true")->label(false)->checkbox() ?>
                </div>

                <div class="col-7">
                    <?= $form->field($modelAnswer, "[{$indexQuestion}][{$indexAnswer}]title")->label(false)->textInput(['maxlength' => true]) ?>
                </div>

                <div class="col-4  ">
                    <button type="button" class="mb-3 p-1 remove-answer btn btn-danger btn-xs"><i class="fi fi-rr-cross" style="height: 15px; width: 15px; display:block"></i></button>
                </div>

            </div>
        </row>

    <?php endforeach; ?>

</div>



<?php DynamicFormWidget::end(); ?>