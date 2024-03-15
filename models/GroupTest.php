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
}
