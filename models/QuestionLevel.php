<?php

namespace app\models;

use Yii;
use yii\db\Query;

/**
 * This is the model class for table "question_level".
 *
 * @property int $id
 * @property string $title
 *
 * @property Question[] $questions
 */
class QuestionLevel extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'question_level';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['title'], 'required'],
            [['title'], 'string', 'max' => 255],
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
        ];
    }

    /**
     * Gets query for [[Questions]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getQuestions()
    {
        return $this->hasMany(Question::class, ['level_id' => 'id']);
    }
    public static function getLevels()
    {
        return (new Query())
            ->select('title')
            ->from('question_level')
            ->indexBy('id')
            ->column();
    }
    public static function getLevelId($title)
    {
        return static::findOne(['title' => $title])->id;
    }
}
