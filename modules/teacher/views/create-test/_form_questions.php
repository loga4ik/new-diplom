<?php

use wbraganca\dynamicform\DynamicFormWidget;
use yii\helpers\Html;
use yii\helpers\VarDumper;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\Question $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="question-form">

    <? # $form->field($questionModel, 'text')->textarea(['rows' => 6]) 
    ?>

    <? # $form->field($questionModel, 'points_per_question')->textInput() 
    ?>

    <? # $form->field($questionModel, 'image')->textInput(['maxlength' => true]) 
    ?>

    <? # $form->field($questionModel, 'level_id')->textInput() 
    ?>

    <? # $form->field($questionModel, 'test_id')->textInput() 
    ?>

    <?php DynamicFormWidget::begin([
        'widgetContainer' => 'dynamicform_wrapper',
        'widgetBody' => '.container-items',
        'widgetItem' => '.question-item',
        'limit' => 30,
        'min' => 1,
        'insertButton' => '.add-question',
        'deleteButton' => '.remove-question',
        'model' => $modelsQuestion[0],
        'formId' => 'dynamic-form',
        'formFields' => [
            'imageFile',
            'text',
            'level_id',
        ],
    ]); ?>

    <row class="container-items">
        <?php foreach ($modelsQuestion as $indexQuestion => $modelQuestion) : ?>
            <div class="question-item pt-4 pb-4 ps-5 pe-5 mb-2 mt-2">
                <?php
                if (!$modelQuestion->isNewRecord) {
                    echo Html::activeHiddenInput($modelQuestion, "[{$indexQuestion}]id");
                }
                ?>
                <div class="row">
                    <?= $form->field($modelQuestion, "[{$indexQuestion}]imageFile")->fileInput()->label('Приложение к вопросу') ?>
                    <div class="col-6">
                        <?= $form->field($modelQuestion, "[{$indexQuestion}]text")->label('Текст вопроса')->textarea(['maxlength' => true]) ?>
                    </div>
                    <div class="col-3">
                        <?= $form->field($modelQuestion, "[{$indexQuestion}]level_id")->label('Сложность вопроса')->dropDownList($levels, ['prompt' => 'Сложность вопроса']) ?>
                    </div>
                </div>
                <? # $this->render('_form-answers', ['form' => $form, 'indexQuestion' => $indexQuestion,'modelsAnswer' => $modelsAnswer[$indexQuestion],]) 
                ?>

                <? if (Yii::$app->controller->action->id == 'create') : ?>
                    <button type="button" class="remove-question btn btn-my-red btn-xs">Удалить вопрос</span></button>
                <? endif; ?>
            </div>
        <?php endforeach; ?>
    </row>
    <div class="row mb-4">
        <? if (Yii::$app->controller->action->id == 'create') : ?>
            <div style="width: auto;">
                <button type="button" class="add-question btn btn-my-green btn-xs">Добавить вопрос</button>
            </div>
        <? endif; ?>
    </div>
    <?php DynamicFormWidget::end(); ?>
</div>
<script>
    $(".dynamicform_wrapper").on("beforeInsert", function(e, item) {
        console.log("beforeInsert");
    });

    $(".dynamicform_wrapper").on("afterInsert", function(e, item) {
        console.log("afterInsert");
    });

    $(".dynamicform_wrapper").on("beforeDelete", function(e, item) {
        if (!confirm("Are you sure you want to delete this item?")) {
            return false;
        }
        return true;
    });

    $(".dynamicform_wrapper").on("afterDelete", function(e) {
        console.log("Deleted item!");
    });

    $(".dynamicform_wrapper").on("limitReached", function(e, item) {
        alert("Limit reached");
    });
</script>