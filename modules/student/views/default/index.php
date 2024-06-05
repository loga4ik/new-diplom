<?php

use app\assets\AppAsset;
use app\models\StudentTest;
use app\models\Test;
use dosamigos\chartjs\ChartJs;
use yii\bootstrap5\Html;
use yii\helpers\VarDumper;

$this->title = 'Главная страница';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="info-block d-flex justify-content-between">
    <div style="width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;">
        <div class='border-bottom border-2'>
            <h2><?= Yii::$app->user->identity->surname . ' ' . Yii::$app->user->identity->name . ' ' . Yii::$app->user->identity->patronimyc ?></h2>
            <h3>Группа: <?= $group ?></h3>
        </div>
        <?php
        // VarDumper::dump(StudentTest::getPassedTests(Yii::$app->user->id),10,true);die;
        $createArrayTestResults = function () {
            $arrayTestAttributes = [];
            foreach (StudentTest::getPassedTests(Yii::$app->user->id) as $value) {
                $arrayTestAttributes[Test::getTestSubject($value['test_id'])][] = [
                    'id' => $value['test_id'],
                    'student_test_id' => $value['id'],
                    'attempt' => $value['attempt'],
                    'mark' => $value['mark'],
                    'cheked' => $value['cheked'],
                    'test_title' => Test::getTestTitle($value['test_id']),
                ];
            }
            return $arrayTestAttributes;
        };
        $createItem = function ($arr) {
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
                    ['/student/test/view', 'id' => $value['id'], 'student_test_id' => $value['student_test_id']],
                    ['class' => 'btn']
                );
            }
            return $str;
        };
        // $str .= '<button class="dropdown-item">тест: ' . $value['test_title'] . '   оценка: ' . $value['mark'] . '   попытка: ' . $value['attempt'] . '</button>';
        // Html::a('тест: ' . $value['test_title'] . '   оценка: ' . $value['mark'] . '   попытка: ' . $value['attempt'], ['view', 'id' => $model->id], ['class' => 'btn my-btn-primary'])

        $strDoneTests = '';
        foreach ($createArrayTestResults() as $key => $value) {
            $strDoneTests .=
                "<div class='dropdown py-2'>
            <button class='btn btn-secondary dropdown-toggle' type='button' id='dropdownMenuButton' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
               " . $key . "
                </button>
                <div class='dropdown-menu flex-column' style='padding:0 .5rem;' aria-labelledby='dropdownMenuButton'>

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
        $studentTest = StudentTest::getStudentsResults(Yii::$app->user->id);
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