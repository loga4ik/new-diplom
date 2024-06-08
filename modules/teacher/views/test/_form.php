<?php

use yii\bootstrap5\Html;
use yii\bootstrap5\ActiveForm;

use wbraganca\dynamicform\DynamicFormWidget;

/** @var yii\web\View $this */
/** @var app\models\Test $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="test-form">
    <?php $form = ActiveForm::begin(['id' => 'dynamic-form',]); ?>

    <div class="row d-flex justify-content-between">
        <div class="col-sm-6">
            <?= $form->field($modelTest, 'title')->textInput(['maxlength' => true]) ?>
            <?= $form->field($modelTest, 'subject_id')->dropDownList($subjects, ['prompt' => 'Предмет', 'class' => 'form-control']) ?>
            <?= $form->field($modelTest, 'duration')->textInput(['maxlength' => true, 'type' => 'number','class'=>'w-25 form-control','placeholder'=>'20мин.']) ?>

        </div>
        <div class="status-test-blick col-sm-5">
            <div class="status-item">
                количество вопросов:
                <span id="count-questions">
                    0
                </span>
            </div>
            <div class="status-item">
                количество сложных вопросов:
                <span id="status-count-h">
                    0
                </span>
            </div>
            <div class="status-item">
                количество средних вопросов:
                <span id="status-count-m">
                    0
                </span>
            </div>
            <div class="status-item">
                количество простых вопросов:
                <span id="status-count-e">
                    0
                </span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-8">
            <? # $form->field($modelTest, 'question_count')->textInput(['type' => 'number', 'style' => 'width: 20% !important;']) 
            ?>
        </div>
    </div>
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
            'type_id'
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

                <div class="row custom-file">
                    <?= $form->field($modelQuestion, "[{$indexQuestion}]imageFile")->fileInput(['class' => 'form-control custom-file-input w-25'])->label('Изображение', ['class' => ' w-25 custom-file-label']) ?>
                    <div class="col-6">
                        <?= $form->field($modelQuestion, "[{$indexQuestion}]text")->textarea(['maxlength' => true, 'class' => 'form-control']) ?>
                    </div>
                    <div class="col-3">
                        <?= $form->field($modelQuestion, "[{$indexQuestion}]level_id")->dropDownList($levels, ['prompt' => 'Сложность вопроса', 'class' => 'form-control select-level']) ?>
                    </div>
                    <div class="col-3">
                        <?= $form->field($modelQuestion, "[{$indexQuestion}]type_id")->dropDownList($types, ['prompt' => 'Тип вопроса', 'class' => 'form-control']) ?>
                    </div>
                </div>
                <?= $this->render('_form-answers', ['form' => $form, 'indexQuestion' => $indexQuestion, 'modelsAnswer' => $modelsAnswer[$indexQuestion]])
                ?>

                <?php if (Yii::$app->controller->action->id == 'create') : ?>
                    <button type="button" class="remove-question my-btn-primary">Удалить вопрос</button>
                <?php endif; ?>
            </div>
        <?php endforeach; ?>
    </row>
    <div class="row mb-4">
        <?php if (Yii::$app->controller->action->id == 'create') : ?>
            <div style="width: auto;">
                <button type="button" class="add-question btn btn-outline-success">Добавить вопрос</button>
            </div>
        <?php endif; ?>
    </div>

    <?php DynamicFormWidget::end() ?>
    <div class="form-group">
        <?= Html::submitButton(Yii::$app->controller->action->id == 'create' ? 'Создать' : 'Изменить', ['class' => 'btn my-btn-primary']) ?>
    </div>
    <?php ActiveForm::end(); ?>
</div>


<?php $js = <<< JS

    $(".dynamicform_wrapper").on("afterInsert", function(e, item) {
        $(item).find('input,textarea,select').each(function(index,element){
            if($(element).attr('type') != 'checkbox'){
                $(element).val('');
            }

            $(element).removeClass('is-valid');
            $(element).removeClass('is-invalid');
            let numOfQuestion = element.id.split('-')[1];
            for( let i = 1; i<=11 ; i++){
                if( element.id == 'answer-'+ numOfQuestion + '-' + i + '-title' ){
                    let a_item = $(element).parents('.answer-item');
                    a_item.remove();
                }
            }
            
           
        });
    });
    
    
JS;
$this->registerJs($js, \yii\web\View::POS_READY);
$this->registerJsFile(
    "https://code.jquery.com/jquery-3.7.1.js"
);
$this->registerJsFile('/web/js/testForm.js');
?>