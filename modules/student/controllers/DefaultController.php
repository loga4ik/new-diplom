<?php

namespace app\modules\student\controllers;

use app\models\Group;
use app\models\StudentTest;
use app\models\Test;
use app\models\UserGroup;
use Yii;
use yii\web\Controller;

/**
 * Default controller for the `student` module
 */
class DefaultController extends Controller
{
    /**
     * Renders the index view for the module
     * @return string
     */
    public function actionIndex()
    {
        $group = Group::getGroupTitle(UserGroup::findOne(['user_id' => Yii::$app->user->identity->id])->group_id);
        // $group = Group::findOne($group_id)->title;u
        $tests_count = StudentTest::getTestsCount();

        // $tests = StudentTest::getPassedTests(Yii::$app->user->identity->id);
        // $test_list = [];
        // foreach ($tests as $group_test_id => $student_test_id) {
        //     $test_title = Test::findOne(GroupTest::findOne($group_test_id)->test_id)->title;
        //     $test_mark = StudentTest::findOne($student_test_id)->mark;
        //     if (StudentTest::findOne($student_test_id)->cheked) {
        //         array_push(
        //             $test_list,
        //             '<p class="border-bottom border-1">' . $test_title . ' - ' . '<b style="color:red">' . $test_mark . '</b>' . '</p>'
        //         );
        //     }
        // }
        // $test_list = join($test_list);
        return $this->render(
            'index',
            [
                // 'test_list' => $test_list,
                'tests_count' => $tests_count,
                'group' => $group
            ]
        );
    }
}
