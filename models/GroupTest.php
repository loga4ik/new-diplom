<?php

namespace app\models;

use Yii;
use yii\db\Query;
use yii\helpers\VarDumper;

/**
 * This is the model class for table "group_test".
 *
 * @property int $id
 * @property string|null $date
 * @property float|null $avg_points
 * @property int|null $val_5
 * @property int|null $val_4
 * @property int|null $val_3
 * @property int|null $fails
 * @property int $group_id
 * @property int $test_id
 *
 * @property Deny[] $denies
 * @property StudentTest[] $studentTests
 */
class GroupTest extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'group_test';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['date'], 'safe'],
            [['avg_points'], 'number'],
            [['val_5', 'val_4', 'val_3', 'fails', 'group_id', 'test_id'], 'integer'],
            [['group_id', 'test_id'], 'required'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'date' => 'Date',
            'avg_points' => 'Avg Points',
            'val_5' => 'Val 5',
            'val_4' => 'Val 4',
            'val_3' => 'Val 3',
            'fails' => 'Fails',
            'group_id' => 'Group ID',
            'test_id' => 'Test ID',
        ];
    }

    /**
     * Gets query for [[Denies]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getDenies()
    {
        return $this->hasMany(Deny::class, ['group_test_id' => 'id']);
    }

    /**
     * Gets query for [[StudentTests]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStudentTests()
    {
        return $this->hasMany(StudentTest::class, ['group_test_id' => 'id']);
    }
    public static function getArrOfPassedTestUsers($test_id)
    {
        $testingGroup = (new Query())
            ->select('group_id')
            ->where(['test_id' => $test_id])
            ->from('group_test')
            ->indexBy('id')
            ->column();
        return $testingGroup;
    }
    public static function changeGroupTest($group_test_id)
    {
        $test = static::findOne($group_test_id);
        $students = StudentTest::find()->where(['group_test_id' => $group_test_id]);
        $student_count = $students->count();
        $all_points = 0;
        $students_column = StudentTest::find()
            ->where(['group_test_id' => $group_test_id])
            ->all();
        foreach ($students_column as $student) {
            $all_points += $student->points;
        }
        $test->avg_points = $all_points / $student_count;
        $current_student = StudentTest::findOne(['group_test_id' => $group_test_id, 'user_id' => Yii::$app->user->identity->id]);
        $mark = $current_student->mark;
        if ($mark == 5) {
            $test->val_5++;
        } elseif ($mark == 4) {
            $test->val_4++;
        } elseif ($mark == 3) {
            $test->val_3++;
        } elseif ($mark == 2) {
            $test->fails++;
        }
        return $test->save();
    }
    public static function getGroupTestId()
    {
        $groupId = UserGroup::findOne(['user_id' => Yii::$app->user->identity->id])->group_id;
        $allActiveTests = (new Query())
            ->select('id')
            ->from('test')
            ->where(['is_active' => true])
            ->indexBy('id')
            ->column();

        // die;
        // $activeTest = self::findOne(['group_id' => $groupId, 'test_id' => $allActiveTests]);
        // GroupTest::findOne(['group_id' => $groupId])->test_id;

        // VarDumper::dump($activeTest->id, 10, true);
        // VarDumper::dump($allActiveTests, 10, true);
        // VarDumper::dump($groupId, 10, true);
        // die;
        return self::findOne(['group_id' => $groupId, 'test_id' => $allActiveTests]);
    }
}
