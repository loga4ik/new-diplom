<?php

use app\models\UserGroup;
use yii\bootstrap5\Html;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\User $model */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Преподаватели', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="user-view">

    <h1>
        <?= Html::encode($this->title) ?>
    </h1>

    <p>
        <?= Html::a('редактировать', ['update', 'id' => $model->id], ['class' => 'btn my-btn-primary']) ?>
        <?= Html::a('добавить группу', ['add-group', 'user_id' => $model->id], ['class' => 'btn btn-outline-primary']) ?>
        <?= Html::a('удалить', ['delete', 'id' => $model->id], [
            'class' => 'btn my-btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>
    <?
    $grupBtn = function ($userGroupArr, $model) {
        $str = '';
        foreach ($userGroupArr as $value) {
            $str .= Html::a($value, ['./teacher/editing-group', 'id' => $value, 'user_id' => $model->id], ['class' => 'btn my-btn-primary mx-2']);
        }
        return $str;
    }
        ?>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            [
                'attribute' => 'id',
                'value' => Html::encode($model->id),
            ],
            [
                'attribute' => 'surname',
                'value' => Html::encode($model->surname),
            ],
            [
                'attribute' => 'name',
                'value' => Html::encode($model->name),
            ],
            [
                'attribute' => 'patronimyc',
                'value' => Html::encode($model->patronimyc),
            ],
            [
                'attribute' => 'login',
                'value' => Html::encode($model->login),
            ],
            [
                'attribute' => 'email',
                'filter' => false,
                'visible' => (bool) $model->email,
                'value' => Html::encode($model->email),
            ],
            [
                'attribute' => 'phone',
                'filter' => false,
                'visible' => (bool) $model->phone,
                'value' => Html::encode($model->phone),
            ],
            [
                'label' => 'группа',
                'format' => 'html',
                'value' => $userGroupArr
                    ? $grupBtn($userGroupArr, $model)
                    : Html::a('добавить группу', ['add-group', 'user_id' => $model->id], ['class' => 'btn btn-outline-primary']),
            ],
            [
                'attribute' => 'role_id',
                'visible' => (bool) $roleTitle,
                'value' => Html::encode($roleTitle),
            ],
        ],
    ]) ?>

</div>