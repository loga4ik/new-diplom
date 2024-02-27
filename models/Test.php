<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "test".
 *
 * @property int $id
 * @property string $title
 * @property int $question_count
 * @property int $point_count
 * @property int $subject-id
 * @property int $is_active
 *
 * @property Question[] $questions
 * @property StudentTest[] $studentTests
 * @property Subject $subject-
 */
class Test extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'test';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['title', 'question_count', 'point_count', 'subject-id', 'is_active'], 'required'],
            [['title'], 'string'],
            [['question_count', 'point_count', 'subject-id', 'is_active'], 'integer'],
            [['subject-id'], 'exist', 'skipOnError' => true, 'targetClass' => Subject::class, 'targetAttribute' => ['subject-id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'title' => 'Title',
            'question_count' => 'Question Count',
            'point_count' => 'Point Count',
            'subject-id' => 'Subject ID',
            'is_active' => 'Is Active',
        ];
    }

    /**
     * Gets query for [[Questions]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getQuestions()
    {
        return $this->hasMany(Question::class, ['test_id' => 'id']);
    }

    /**
     * Gets query for [[StudentTests]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStudentTests()
    {
        return $this->hasMany(StudentTest::class, ['test_id' => 'id']);
    }

    /**
     * Gets query for [[Subject-]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getSubject()
    {
        return $this->hasOne(Subject::class, ['id' => 'subject-id']);
    }
}
