<?php

namespace app\models;

use Yii;
use yii\db\Query;

/**
 * This is the model class for table "group_test".
 *
 * @property int $id
 * @property int $test_id
 * @property int $group_id
 *
 * @property Group $group
 * @property Test $test
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
            [['test_id', 'group_id'], 'required'],
            [['test_id', 'group_id'], 'integer'],
            [['group_id'], 'exist', 'skipOnError' => true, 'targetClass' => Group::class, 'targetAttribute' => ['group_id' => 'id']],
            [['test_id'], 'exist', 'skipOnError' => true, 'targetClass' => Test::class, 'targetAttribute' => ['test_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'test_id' => 'Test ID',
            'group_id' => 'Group ID',
        ];
    }

    /**
     * Gets query for [[Group]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getGroup()
    {
        return $this->hasOne(Group::class, ['id' => 'group_id']);
    }

    /**
     * Gets query for [[Test]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getTest()
    {
        return $this->hasOne(Test::class, ['id' => 'test_id']);
    }
    public static function getArrOfPassedTestUsers($test_id)
    {
        $testingGroup = (new Query())
            ->select('group_id')
            ->where(['test_id' => $test_id])
            ->from('group_test')
            ->indexBy('id')
            ->column();
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
}
