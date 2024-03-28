<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\TeacherSubject $model */

$this->title = 'Create Teacher Subject';
$this->params['breadcrumbs'][] = ['label' => 'Teacher Subjects', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="teacher-subject-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
        'users' => $users,
        'subjects'=>$subjects,
    ]) ?>

</div>
