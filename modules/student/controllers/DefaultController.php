<?php

namespace app\modules\student\controllers;

use app\models\Group;
use app\models\StudentTest;
use app\models\Test;
use app\models\User;
use app\models\UserGroup;
use Yii;
use yii\db\Query;
use yii\helpers\VarDumper;
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
        $tests_count = StudentTest::getTestsCount();
        $group_id = UserGroup::findOne(['user_id' => Yii::$app->user->id]);





        $getGroupUsers = (new Query())
            ->select('user_id')
            ->from('user_group')
            ->where(['group_id' => $group_id])
            ->column();
        $getAVGmark = function ($studentTest) {
            if (!$studentTest) {
                return 0;
            }
            $markSum = 0;

            foreach ($studentTest as $key => $value) {
                $markSum += $value;
            }
            return $markSum / count($studentTest);
        };
        $getAllUsersMarks = function ($getGroupUsers, $getAVGmark) {
            $usersAVGresults = [];


            foreach ($getGroupUsers as $value) {
                array_push($usersAVGresults, $getAVGmark(StudentTest::getStudentsResults($value)));
            }
            return $usersAVGresults;
        };

        $arrOfAllUsersMarks = $getAllUsersMarks($getGroupUsers, $getAVGmark);
        $activeUsersAVGmark = $getAVGmark(StudentTest::getStudentsResults(Yii::$app->user->id));
        array_multisort($arrOfAllUsersMarks, SORT_DESC);

        // VarDumper::dump($arrOfAllUsersMarks, 10, true);
        // die;

        return $this->render(
            'index',
            [
                // 'test_list' => $test_list,
                'tests_count' => $tests_count,
                'group' => $group,
                'placeInClass' => array_search($activeUsersAVGmark, $arrOfAllUsersMarks) + 1,
            ]
        );
    }
}
