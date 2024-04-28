<?php

namespace app\models;

use Yii;
use yii\db\Query;
use yii\helpers\VarDumper;

/**
 * This is the model class for table "student_test".
 *
 * @property int $id
 * @property int $points
 * @property int $mark
 * @property int $test_id
 * @property int $user_id
 * @property int $group_test_id
 * @property int $cheked
 * @property string|null $date
 * @property int $attempt
 * @property string|null $ip
 *
 * @property GroupTest $groupTest
 * @property Test $test
 * @property User $user
 */
class StudentTest extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'student_test';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['points', 'mark', 'test_id', 'user_id', 'group_test_id', 'cheked', 'attempt'], 'required'],
            [['points', 'mark', 'test_id', 'user_id', 'group_test_id', 'cheked', 'attempt'], 'integer'],
            [['date'], 'safe'],
            [['ip'], 'string', 'max' => 255],
            [['group_test_id'], 'exist', 'skipOnError' => true, 'targetClass' => GroupTest::class, 'targetAttribute' => ['group_test_id' => 'id']],
            [['test_id'], 'exist', 'skipOnError' => true, 'targetClass' => Test::class, 'targetAttribute' => ['test_id' => 'id']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::class, 'targetAttribute' => ['user_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'points' => 'Points',
            'mark' => 'Mark',
            'test_id' => 'Test ID',
            'user_id' => 'User ID',
            'group_test_id' => 'Group Test ID',
            'cheked' => 'Cheked',
            'date' => 'Date',
            'attempt' => 'Attempt',
            'ip' => 'Ip',
        ];
    }

    /**
     * Gets query for [[GroupTest]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getGroupTest()
    {
        return $this->hasOne(GroupTest::class, ['id' => 'group_test_id']);
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
     * Gets query for [[User]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::class, ['id' => 'user_id']);
    }
    public static function getAllUserIdMark()
    {
        return (new Query())
            ->select(['user_id', 'mark'])
            ->from('student_test')
            ->all();
    }
    public static function getTestsCount()
    {
        return count(array_unique(self::find()
            ->select('test_id')
            ->where(['user_id' => Yii::$app->user->id])
            ->column()));
    }
    public static function getPassedTests()
    {
        return (new Query())
            ->from('student_test')
            ->where(['user_id' => Yii::$app->user->id])
            ->all();
        // ->select()
        // $res = static::find()
        //     ->where(['user_id' => $user_id])
        //     ->indexBy('id')
        //     ->column();
        // $res = array_unique($res);
        // return $res;
    }
    public static function getTestResults($test_id)
    {
        return (new Query())
            ->select('mark')
            ->from('student_test')
            ->where(['test_id' => $test_id])
            ->indexBy('id')
            ->column();
    }
    public static function getStudentsResults($user_id)
    {
        return (new Query())
            ->select('mark')
            ->from('student_test')
            ->where(['user_id' => $user_id])
            ->indexBy('id')
            ->column();
    }
    public static function createStudentTest($test_id, $group_test_id, $attempt, $user_id)
    {
        $modelStudentTest = new StudentTest();
        $modelStudentTest->points = static::getStudentTestPoints($test_id, $group_test_id, $attempt, $user_id);
        $modelStudentTest->mark = static::getStudentTestMark($test_id, $group_test_id, $attempt, $user_id);
        $modelStudentTest->test_id = $test_id;
        $modelStudentTest->user_id = Yii::$app->user->identity->id;
        $modelStudentTest->group_test_id = $group_test_id->id;
        $modelStudentTest->cheked = 0;
        $modelStudentTest->attempt = $attempt;
        $modelStudentTest->date = date('Y-m-d');

        $test_questions = Test::getTestQuestionsList($group_test_id);

        $res = false;
        if ($modelStudentTest->save()) {
            // $deny = Deny::find()->where(['user_id' => Yii::$app->user->identity->id, 'group_test_id' => $group_test_id])->one();
            // // VarDumper::dump($deny->attributes, 10, true);
            // // die;
            // if (Deny::find()->where(['user_id' => Yii::$app->user->identity->id, 'group_test_id' => $group_test_id])->one()) {
            //     $deny = Deny::find()->where(['user_id' => Yii::$app->user->identity->id, 'group_test_id' => $group_test_id])->one();
            // }
            // else {
            //     $deny = new Deny();
            //     // $deny
            // }
            // $deny->is_true = 0;
            $res = true;
        }

        return $res;
    }
    public static function getStudentTestPoints($test_id, $group_test_id, $attempt, $user_id)
    {
        // VarDumper::dump($attempt, 10, true);
        // die;
        // $user = User::findOne(Yii::$app->user->identity->id);
        $test = Test::findOne($test_id);
        $points = 0;
        $questions = Question::find()->where(['test_id' => $test_id])->all();
        $answers = [];
        foreach ($questions as $question) {
            $student_answers = StudentAnswer::find()
                ->where(['user_id' => $user_id, 'attempt' => $attempt, 'question_id' => $question['id']])
                ->all();
            $i = 0;
            foreach ($student_answers  as $answer) {
                $answers[$answer['question_id']][$i] = $answer['answer_id'];
                $i++;
            }
        }
        foreach ($answers as $question_id => $answer) {
            if (Question::findOne($question_id)->type_id == QuestionType::getTypeId('Ввод ответа от студента')) {
                $student_answer = StudentAnswer::findOne(['question_id' => $question_id, 'user_id' => $user_id, 'attempt' => $attempt]);
                $res = $student_answer->is_true;
            } else {
                $res = StudentAnswer::getIsCorrectAnswer($question_id, $answer);
            }
            if ($res) {
                $question_level_id = Question::findOne($question_id)->level_id;
                if ($question_level_id == QuestionLevel::getLevelId('Лёгкий')) {
                    $points += 1;
                } elseif ($question_level_id == QuestionLevel::getLevelId('Средний')) {
                    $points += 2;
                } elseif ($question_level_id == QuestionLevel::getLevelId('Сложный')) {
                    $points += 3;
                }
            }
        }
        return $points;
    }
    public static function getStudentTestMark($test_id, $group_test_id, $attempt, $user_id)
    {
        $student_points = static::getStudentTestPoints($test_id, $group_test_id, $attempt, $user_id);
        // VarDumper::dump($test_id, 10, true);
        // die;
        $point_count = Test::findOne($test_id)->point_count;

        $percent =  $student_points * 100 / $point_count;
        if ($percent >= 80) {
            $mark = 5;
        } elseif ($percent < 80 && $percent >= 60) {
            $mark = 4;
        } elseif ($percent < 60 && $percent >= 40) {
            $mark = 3;
        } else {
            $mark = 2;
        }
        return $mark;
    }
    public static function getIsChecked($student_id, $group_test_id, $attempt)
    {
        $current_student_test = static::findOne(['user_id' => $student_id, 'group_test_id' => $group_test_id, 'attempt' => $attempt]);
        $test_id = GroupTest::findOne($group_test_id)->test_id;
        $questions = Question::find()->where(['test_id' => $test_id])->all();
        $counter = 0;
        foreach ($questions as $question) {
            $student_answer = StudentAnswer::findOne(['question_id' => $question['id'], 'user_id' => $student_id, 'attempt' => $attempt]);
            if ($student_answer) {
                if ($student_answer->cheked === 0) {
                    $counter++;
                }
            }
        }
        if ($counter != 0) {
            $current_student_test->cheked = 0;
        } else {
            $current_student_test->cheked = 1;
        }
        if ($current_student_test->save()) {
            return $current_student_test->cheked;
        }
    }
}
