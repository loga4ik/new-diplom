<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "student_test".
 *
 * @property int $id
 * @property int $mark
 * @property int $point
 * @property int $test_id
 * @property int $user_id
 * @property int $try
 *
 * @property StudentAnswer[] $studentAnswers
 * @property Test $test
 * @property User $user
 */
class StudentTest extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'student_test';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['mark', 'point', 'test_id', 'user_id', 'try'], 'required'],
            [['mark', 'point', 'test_id', 'user_id', 'try'], 'integer'],
            [['test_id'], 'exist', 'skipOnError' => true, 'targetClass' => Test::class, 'targetAttribute' => ['test_id' => 'id']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::class, 'targetAttribute' => ['user_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'mark' => 'Mark',
            'point' => 'Point',
            'test_id' => 'Test ID',
            'user_id' => 'User ID',
            'try' => 'Try',
        ];
    }

    /**
     * Gets query for [[StudentAnswers]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStudentAnswers()
    {
        return $this->hasMany(StudentAnswer::class, ['student_test_id' => 'id']);
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

    /**
     * Gets query for [[User]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::class, ['id' => 'user_id']);
    }
}
