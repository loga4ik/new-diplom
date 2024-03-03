<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "student_answer".
 *
 * @property int $student_test_id
 * @property int $ansuer_id
 * @property string|null $text
 *
 * @property Answer $ansuer
 * @property StudentTest $studentTest
 */
class StudentAnswer extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'student_answer';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['student_test_id', 'ansuer_id'], 'required'],
            [['student_test_id', 'ansuer_id'], 'integer'],
            [['text'], 'string'],
            [['student_test_id'], 'exist', 'skipOnError' => true, 'targetClass' => StudentTest::class, 'targetAttribute' => ['student_test_id' => 'id']],
            [['ansuer_id'], 'exist', 'skipOnError' => true, 'targetClass' => Answer::class, 'targetAttribute' => ['ansuer_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'student_test_id' => 'Student Test ID',
            'ansuer_id' => 'Ansuer ID',
            'text' => 'Text',
        ];
    }

    /**
     * Gets query for [[Ansuer]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getAnsuer()
    {
        return $this->hasOne(Answer::class, ['id' => 'ansuer_id']);
    }

    /**
     * Gets query for [[StudentTest]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStudentTest()
    {
        return $this->hasOne(StudentTest::class, ['id' => 'student_test_id']);
    }
}
