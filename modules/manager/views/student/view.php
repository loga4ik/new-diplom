<?php

use app\models\StudentTest;
use app\models\Test;
use dosamigos\chartjs\ChartJs;
use yii\helpers\Html;
use yii\helpers\VarDumper;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\User $model */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Студенты', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="info-block d-flex justify-content-between">
    <div style="width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;">
        <div class='border-bottom border-2'>
            <h2><?= $student->surname . ' ' . $student->name . ' ' . $student->patronimyc ?></h2>
            <h3>Группа: <?= $group ?></h3>
        </div>
        <?php
        // VarDumper::dump(StudentTest::getPassedTests($student->id), 10, true);
        // die;
        $createArrayTestResults = function ($model) {
            $arrayTestAttributes = [];
            foreach (StudentTest::getPassedTests($model->id) as $value) {
                $arrayTestAttributes[Test::getTestSubject($value['test_id'])][] = [
                    'id' => $value['test_id'],
                    'student_test_id' => $value['id'],
                    'attempt' => $value['attempt'],
                    'cheked' => $value['cheked'],
                    'mark' => $value['mark'],
                    'test_title' => Test::getTestTitle($value['test_id']),
                ];
            }
            return $arrayTestAttributes;
        };
        $createItem = function ($arr, $model) {
            $str = '';
            foreach ($arr as $value) {
                $str .= Html::a(
                    'тест: '
                        . $value['test_title']
                        . '   оценка: '
                        . $value['mark']
                        . '   попытка: '
                        . $value['attempt']
                        . (!$value['cheked'] ? ",   на проверке" : ''),
                    ['/teacher/test/view', 'id' => $value['id'], 'user_id' => $model->id, 'student_test_id' => $value['student_test_id']],
                    ['class' => 'btn']
                );
            }
            return $str;
        };
        $strDoneTests = '';
        foreach ($createArrayTestResults($model) as $key => $value) {
            $strDoneTests .=
                "<div class='dropdown py-2'>
                <button class='btn btn-secondary dropdown-toggle' type='button' id='dropdownMenuButton' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
                   " . $key . "
                    </button>
                    <div class='dropdown-menu flex-column' style='padding:0 .5rem;' aria-labelledby='dropdownMenuButton'>
    
                    " . $createItem($value, $model) . "
                    </div>
                </div>";
        }
        ?>
        <div class="mt-2">
            <?=
            $strDoneTests
            ?>

        </div>
        <div>
            <div class="card" style="display: inline-block;">
                <div class="card-body placeInClass">
                    Ваше место в классе:
                    <b>
                        <?= $placeInClass ?>
                    </b>
                </div>
                <?php if ($placeInClass == 1) : ?>
                    <img src="/web/img/crown.svg" class="svg-crown" alt="SVG Image">
                <?php endif ?>
                <!-- <i class="fi fi-rs-crown"></i> -->
            </div>
        </div>
    </div>
    <div>
        <?php
        $studentTest = StudentTest::getStudentsResults($student->id);
        $getArrOfMarks = function ($studentTest) {
            $arrOfMarks = [
                "2" => 0,
                "3" => 0,
                "4" => 0,
                "5" => 0,
            ];
            foreach ($studentTest as $value) {
                $arrOfMarks[$value] += 1;
            };
            return $arrOfMarks;
        };
        ?>

        <?=
        $studentTest ?
            // VarDumper::dump([...$getArrOfMarks($model)], 10, true);
            ChartJs::widget([
                'type' => 'doughnut',
                'options' => [
                    'height' => 300,
                    'width' => 400,
                    // 'scales' => [
                    //     'x' => ['max' => 150],
                    //     'y' => ['max' => 150],
                    // ]
                ],
                'data' => [
                    'labels' => ["2", "3", "4", "5"],
                    'datasets' => [
                        [
                            'label' => '# of Votes',
                            'data' => [...$getArrOfMarks($studentTest)],
                            // 'borderColor' => ['#F95C68FF'],
                            'backgroundColor' => ['#F95C68FF', '#F07427FF', '#7CC7DFFF', '#50C878FF'],
                        ]
                    ]
                ]
            ]) : ''
        ?>
    </div>
</div>