<?php

namespace app\models;

use Yii;
use yii\helpers\VarDumper;

/**
 * This is the model class for table "question".
 *
 * @property int $id
 * @property string $text
 * @property int $points_per_question
 * @property string $image
 * @property int $level_id
 * @property int $test_id
 * @property int $type_id
 *
 * @property Answer[] $answers
 * @property QuestionLevel $level
 * @property Test $test
 * @property QuestionType $type
 */
class Question extends \yii\db\ActiveRecord
{


    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'question';
    }
    public $imageFile;
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['text', 'points_per_question', 'level_id', 'test_id', 'type_id'], 'required'],
            [['text', 'image'], 'string'],
            [['points_per_question', 'level_id', 'test_id', 'type_id'], 'integer'],
            [['level_id'], 'exist', 'skipOnError' => true, 'targetClass' => QuestionLevel::class, 'targetAttribute' => ['level_id' => 'id']],
            [['test_id'], 'exist', 'skipOnError' => true, 'targetClass' => Test::class, 'targetAttribute' => ['test_id' => 'id']],
            [['type_id'], 'exist', 'skipOnError' => true, 'targetClass' => QuestionType::class, 'targetAttribute' => ['type_id' => 'id']],
            [['imageFile'], 'file', 'skipOnEmpty' => true, 'extensions' => 'png, jpg'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'text' => 'Текст',
            'points_per_question' => 'Points Per Question',
            'image' => 'Image',
            'imageFile' => 'Изображение',
            'level_id' => 'Сложность вопроса',
            'test_id' => 'Test ID',
            'type_id' => 'тип вопроса',
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

    /**
     * Gets query for [[Type]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getType()
    {
        return $this->hasOne(QuestionType::class, ['id' => 'type_id']);
    }
    // public static function getQuestionsOfTest($test_id)
    // {
    //     return self::findOne($test_id);
    // }
    public static function getQuestionsOfTest($test_id)
    {
        $qa = [];
        $questions = static::find()->where(['test_id' => $test_id])->asArray()->all();

        foreach ($questions as $question) {
            $question_id = $question['id'];
            $question_text = $question['text'];
            $answer = Answer::getAnswersOfQuestion($question_id);
            for ($i = 0; $i < count($answer); $i++) {
                // VarDumper::dump($answer[$i], 10, true);
                // die;
                $qa[$question_text][$i] = $answer[$i]['title'];
            }
        }
        return $qa;
    }

    public function upload()
    {
        if ($this->validate()) {
            $fileName = Yii::$app->user->identity->id . '_' . time() . '_' . Yii::$app->security->generateRandomString(10)  . '.' . $this->imageFile->extension;
            $this->imageFile->saveAs(Yii::getAlias('@app') . '/web/question-img/' . $fileName);
            $this->image = '/web/question-img/' . $fileName;
            return true;
        } else {
            return false;
        }
    }
}
