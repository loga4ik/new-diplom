<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "subject".
 *
 * @property int $id
 * @property string $title
 *
 * @property Test[] $tests
 */
class Subject extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'subject';
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
     * Gets query for [[Tests]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getTests()
    {
        return $this->hasMany(Test::class, ['subject_id' => 'id']);
    }
}
