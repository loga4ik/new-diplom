<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\UserGroup $model */

$this->title = 'Create User Group';
$this->params['breadcrumbs'][] = ['label' => 'User Groups', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-group-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>