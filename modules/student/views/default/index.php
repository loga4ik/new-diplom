<?php

use app\assets\AppAsset;
use app\models\StudentTest;
use app\models\Test;
use yii\bootstrap5\Html;
use yii\helpers\VarDumper;

$this->title = 'Главная страница';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="info-block">
    <div class='border-bottom border-2'>
        <h2><?= Yii::$app->user->identity->surname . ' ' . Yii::$app->user->identity->name . ' ' . Yii::$app->user->identity->patronimyc ?></h2>
        <h3>Группа: <?= $group ?></h3>
    </div>
    <?php
    $createArrayTestResults = function () {
        $arrayTestAttributes = [];
        foreach (StudentTest::getPassedTests() as $value) {
            $arrayTestAttributes[Test::getTestSubject($value['test_id'])][] = [
                'try' => $value['try'],
                'mark' => $value['mark'],
                'test_title' => Test::getTestTitle($value['test_id']),
            ];
        }
        return $arrayTestAttributes;
    };
    $createItem = function ($arr) {
        $str = '';
        foreach ($arr as $key => $value) {
            $str .= '<p class="dropdown-item">тест: ' . $value['test_title'] . '   оценка: ' . $value['mark'] . '   попытка: ' . $value['try'] . '</p>';
        }
        return $str;
    };
    $strDoneTests = '';
    foreach ($createArrayTestResults() as $key => $value) {
        $strDoneTests .=
            "<div class='dropdown py-2'>
            <button class='btn btn-secondary dropdown-toggle' type='button' id='dropdownMenuButton' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
               " . $key . "
                </button>
                <div class='dropdown-menu' aria-labelledby='dropdownMenuButton'>

                " . $createItem($value) . "
                </div>
            </div>";
    }
    ?>
    <div class="mt-2">
        <?=
        $strDoneTests
        ?>
    </div>