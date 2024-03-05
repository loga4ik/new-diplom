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
 * @property int $type_id
 *
 * @property Question $question
 * @property StudentAnswer[] $studentAnswers
 * @property AnswerType $type
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
            [['title'], 'string'],
            [['is_true', 'question_id', 'type_id'], 'integer'],
            [['question_id'], 'exist', 'skipOnError' => true, 'targetClass' => Question::class, 'targetAttribute' => ['question_id' => 'id']],
            [['type_id'], 'exist', 'skipOnError' => true, 'targetClass' => AnswerType::class, 'targetAttribute' => ['type_id' => 'id']],
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
            'type_id' => 'Type ID',
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

    /**
     * Gets query for [[Type]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getType()
    {
        return $this->hasOne(AnswerType::class, ['id' => 'type_id']);
    }
    public static function getLevels()
    {
        return static::find()->select('title')->indexBy('id')->column();
    }
}
