<?php

namespace app\models;

use Yii;
use yii\db\Query;
use yii\helpers\VarDumper;

/**
 * This is the model class for table "student_answer".
 *
 * @property int $id
 * @property int $question_id
 * @property int $user_id
 * @property int $answer_id
 * @property string|null $answer_title
 * @property int|null $cheked
 * @property int|null $is_true
 * @property int|null $attempt
 *
 * @property Answer $answer
 * @property Question $question
 * @property User $user
 */
class StudentAnswer extends \yii\db\ActiveRecord
{
    // public $question_id;

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'student_answer';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['question_id', 'user_id', 'answer_id'], 'required'],
            [['question_id', 'user_id', 'answer_id', 'cheked', 'is_true', 'attempt'], 'integer'],
            [['answer_title'], 'string', 'max' => 255],
            [['question_id'], 'exist', 'skipOnError' => true, 'targetClass' => Question::class, 'targetAttribute' => ['question_id' => 'id']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::class, 'targetAttribute' => ['user_id' => 'id']],
            [['answer_id'], 'exist', 'skipOnError' => true, 'targetClass' => Answer::class, 'targetAttribute' => ['answer_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'question_id' => 'Question ID',
            'user_id' => 'User ID',
            'answer_id' => 'Answer ID',
            'answer_title' => 'Answer Title',
            'cheked' => 'Cheked',
            'is_true' => 'Is True',
            'attempt' => 'Attempt',
        ];
    }

    /**
     * Gets query for [[Answer]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getAnswer()
    {
        return $this->hasOne(Answer::class, ['id' => 'answer_id']);
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
     * Gets query for [[User]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::class, ['id' => 'user_id']);
    }
    public static function getLastAttempt($group_test_id)
    {
        $student_tests = StudentTest::find()->where(['group_test_id' => $group_test_id, 'user_id' => Yii::$app->user->identity->id])->all();
        if (count($student_tests) > 0) {
            return end($student_tests)->attempt;
        } else {
            return 0;
        }
    }

    public static function getIsCorrectAnswer($question_id, $user_answers_id)
    {

        if (!is_array($user_answers_id)) {
            $answer = $user_answers_id;
            $user_answers_id = [];
            $user_answers_id[0] = $answer;
        } else {

            if (count($user_answers_id) == 1) {
                foreach ($user_answers_id as $val) {
                    if (is_array($val)) {
                        $user_answers_id = $val;
                    }
                }
            }
        }

        // sVarDumper::dump($user_answers_id, 10, true);die;

        if ($question_id) {
            $correct_answers = Question::findOne($question_id)->getAnswers()->where(['is_true' => 1])->column();
            $first_array_diff = array_diff($correct_answers, $user_answers_id);
            $second_array_diff = array_diff($user_answers_id, $correct_answers);
            $array_merge = array_merge($first_array_diff, $second_array_diff);
            if (empty($array_merge)) {
                return true;
            } else {
                return false;
            }
        }
    }
    public static function getstudentAnswerByIdAndUserId($answer_id, $user_id, $student_test_id)
    {
        // VarDumper::dump(["answer_id" => $answer_id, "user_id" => $user_id, 'attempt' => StudentTest::findOne(['id' => $student_test_id])->attempt], 10, true);
        // die;

        // VarDumper::dump((new Query())
        //     ->select('id')
        //     ->from('student_answer')
        //     ->where(['answer_id' => $answer_id, 'user_id' => $user_id, 'attempt' => StudentTest::findOne(['id' => $student_test_id])->attempt])
        //     ->column(), 10, true);
        // die;
        return (new Query())
            ->select('id')
            ->from('student_answer')
            ->where(['answer_id' => $answer_id, 'user_id' => $user_id, 'attempt' => StudentTest::findOne(['id' => $student_test_id])->attempt])
            ->count();
    }
    // public static function getQuestions($test_id)
    // {
    //     return $this->hasMany(Question::class, ['test_id' => $test_id]);
    // }
}
