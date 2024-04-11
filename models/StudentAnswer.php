<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "student_answer".
 *
 * @property int $student_test_id
 * @property int $ansuer_id
 * @property string|null $text
 *
 * @property int $cheked
 * @property Answer $ansuer
 * @property StudentTest $studentTest
 */
class StudentAnswer extends \yii\db\ActiveRecord
{
    public $question_id;
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
            [['student_test_id', 'ansuer_id', 'cheked'], 'required'],
            [['student_test_id', 'ansuer_id', 'cheked'], 'integer'],
            [['text'], 'string'],
            [['student_test_id'], 'exist', 'skipOnError' => true, 'targetClass' => StudentTest::class, 'targetAttribute' => ['student_test_id' => 'id']],
            [['ansuer_id'], 'exist', 'skipOnError' => true, 'targetClass' => Answer::class, 'targetAttribute' => ['ansuer_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'student_test_id' => 'Student Test ID',
            'ansuer_id' => 'Ansuer ID',
            'text' => 'Text',
        ];
    }

    /**
     * Gets query for [[Ansuer]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getAnsuer()
    {
        return $this->hasOne(Answer::class, ['id' => 'ansuer_id']);
    }

    /**
     * Gets query for [[StudentTest]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStudentTest()
    {
        return $this->hasOne(StudentTest::class, ['id' => 'student_test_id']);
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
            $correct_answers = Question::findOne($question_id)->getAnswers()->where(['true_false' => 1])->column();
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
}
