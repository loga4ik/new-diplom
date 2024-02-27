<?php

use app\models\UserGroup;
use yii\bootstrap5\Html as Bootstrap5Html;
use yii\helpers\Html;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\User $model */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Users', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="user-view">

    <h1>
        <?= Html::encode($this->title) ?>
    </h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('добавить группу', ['add-group', 'user_id' => $model->id], ['class' => 'btn btn-outline-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
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
            $str .= Bootstrap5Html::a($value, ['./teacher/editing-group', 'id' => $value, 'user_id' => $model->id], ['class' => 'btn btn-primary mx-2']);
        }
        return $str;
    }
        ?>
    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'name',
            'surname',
            'patronimyc',
            'login',
            'password',
            'email:email',
            'phone',
            [
                'label' => 'группа',
                'value' => $grupBtn($userGroupArr, $model),
                'format' => 'html',
            ],
            'role_id',
            'auth_key',
        ],
    ]) ?>

</div>