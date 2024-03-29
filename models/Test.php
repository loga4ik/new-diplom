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
 * @property int $subject_id
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
            [['title', 'question_count', 'subject_id', 'is_active'], 'required'],
            [['title'], 'string'],
            [['question_count', 'point_count', 'subject_id', 'is_active'], 'integer'],
            [['subject_id'], 'exist', 'skipOnError' => true, 'targetClass' => Subject::class, 'targetAttribute' => ['subject_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'title' => 'Название',
            'question_count' => 'Количество вопросов',
            'point_count' => 'Количество баллов',
            'subject_id' => 'Предмет',
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
        return $this->hasOne(Subject::class, ['id' => 'subject_id']);
    }

    public static function getTestMaxPoints($id)
    {
        $question_count = Test::findOne($id)->question_count;

        $mid_level_id = QuestionLevel::getLevelId('Средний');
        $hard_level_id = QuestionLevel::getLevelId('Сложный');

        $mid_questions = Question::find()
            ->where(['test_id' => $id, 'level_id' => $mid_level_id])
            ->count();
        $hard_questions = Question::find()
            ->where(['test_id' => $id, 'level_id' => $hard_level_id])
            ->count();

        if ($hard_questions >= $question_count - 2) {
            $max_points = $question_count * 3 - 2;
        } elseif ($hard_questions < $question_count - 2 && $mid_questions >= $question_count - $hard_questions) {
            $max_points = $question_count * 2 + $hard_questions;
        } elseif ($hard_questions < $question_count - 2 && $mid_questions < $question_count - $hard_questions) {
            $max_points = $hard_questions * 2 + $mid_questions + $question_count;
        }

        return $max_points;
    }
    public static function getTestTitle($id)
    {
        return self::findOne(['id' => $id])->title;
    }
    public static function getTestSubject($id)
    {
        return Subject::findOne(['test_id', self::findOne(['id' => $id])->subject_id])->title;
    }
}
