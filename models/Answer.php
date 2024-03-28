<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "answer".
 *
 * @property int $id
 * @property string $title
 * @property int $is_true
 * @property int $question_id
 *
 * @property Question $question
 * @property StudentAnswer[] $studentAnswers
 */
class Answer extends \yii\db\ActiveRecord
{
    const SKIP_ANSWER = 'skip_answer';

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'answer';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['title'], 'required', 'except' => self::SKIP_ANSWER],
            [['title', 'is_true'], 'required'],
            [['title'], 'string'],
            [['is_true', 'question_id'], 'integer'],
            [['question_id'], 'exist', 'skipOnError' => true, 'targetClass' => Question::class, 'targetAttribute' => ['question_id' => 'id']],
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
            'is_true' => 'Is True',
            'question_id' => 'Question ID',
        ];
    }

    /**
     * Gets query for [[Question]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getQuestion()
    {
        return $this->hasOne(Question::class, ['id' => 'question_id']);
    }

    /**
     * Gets query for [[StudentAnswers]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStudentAnswers()
    {
        return $this->hasMany(StudentAnswer::class, ['ansuer_id' => 'id']);
    }
    // public static function getLevels()
    // {
    //     return static::find()->select('title')->indexBy('id')->column();
    // }
    public static function getAnswersOfQuestion($question_id)
    {
        return static::find()->where(['question_id' => $question_id])->asArray()->all();
    }
}
