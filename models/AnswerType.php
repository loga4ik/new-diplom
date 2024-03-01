<?php

namespace app\models;

use Yii;
use yii\db\Query;

/**
 * This is the model class for table "answer_type".
 *
 * @property int $id
 * @property string $title
 *
 * @property Answer[] $answers
 */
class AnswerType extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'answer_type';
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
     * Gets query for [[Answers]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getAnswers()
    {
        return $this->hasMany(Answer::class, ['type_id' => 'id']);
    }
    public static function getTypes()
    {
        return (new Query())
            ->select('title')
            ->from('answer_type')
            ->indexBy('id')
            ->column();
    }
}
