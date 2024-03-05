<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "question".
 *
 * @property int $id
 * @property string $text
 * @property int $points_per_question
 * @property string $image
 * @property int $level_id
 * @property int $test_id
 *
 * @property Answer[] $answers
 * @property QuestionLevel $level
 * @property Test $test
 */
class Question extends \yii\db\ActiveRecord
{
    public $imageFile;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'question';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['text', 'level_id', 'test_id'], 'required'],
            [['text'], 'string'],
            [['points_per_question', 'level_id', 'test_id'], 'integer'],
            [['image'], 'string', 'max' => 255],
            [['level_id'], 'exist', 'skipOnError' => true, 'targetClass' => QuestionLevel::class, 'targetAttribute' => ['level_id' => 'id']],
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
            'text' => 'Text',
            'points_per_question' => 'Points Per Question',
            'image' => 'Image',
            'level_id' => 'Level ID',
            'test_id' => 'Test ID',
        ];
    }

    /**
     * Gets query for [[Answers]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getAnswers()
    {
        return $this->hasMany(Answer::class, ['question_id' => 'id']);
    }

    /**
     * Gets query for [[Level]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getLevel()
    {
        return $this->hasOne(QuestionLevel::class, ['id' => 'level_id']);
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
    public static function getQuestionsOfTest($test_id)
    {
        return $questionAttrs = self::findOne($test_id);
    }
}
