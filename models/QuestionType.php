<?php

namespace app\models;

use Yii;
use yii\db\Query;

/**
 * This is the model class for table "question_type".
 *
 * @property int $id
 * @property string $title
 *
 * @property Question[] $questions
 */
class QuestionType extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'question_type';
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
        return $this->hasMany(Question::class, ['type_id' => 'id']);
    }
    public static function getTypes()
    {
        return (new Query())
            ->select('title')
            ->from('question_type')
            ->indexBy('id')
            ->column();
    }
    public static function getTypeId($title)
    {
        return static::findOne(['title' => $title])->id;
    }
}
