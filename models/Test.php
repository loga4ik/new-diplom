<?php

namespace app\models;

use Yii;
use yii\db\Query;
use yii\helpers\VarDumper;

/**
 * This is the model class for table "test".
 *
 * @property int $id
 * @property string $title
 * @property int $question_count
 * @property int $point_count
 * @property int $subject_id
 * @property int $is_active
 *
 * @property Question[] $questions
 * @property StudentTest[] $studentTests
 * @property Subject $subject-
 */
class Test extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'test';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['title', 'question_count', 'subject_id', 'is_active'], 'required'],
            [['title'], 'string'],
            [['question_count', 'point_count', 'subject_id', 'is_active'], 'integer'],
            [['subject_id'], 'exist', 'skipOnError' => true, 'targetClass' => Subject::class, 'targetAttribute' => ['subject_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'title' => 'Название',
            'question_count' => 'Количество вопросов',
            'point_count' => 'Количество баллов',
            'subject_id' => 'Предмет',
            'is_active' => 'Is Active',
        ];
    }

    /**
     * Gets query for [[Questions]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getQuestions()
    {
        return $this->hasMany(Question::class, ['test_id' => 'id']);
    }

    /**
     * Gets query for [[StudentTests]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStudentTests()
    {
        return $this->hasMany(StudentTest::class, ['test_id' => 'id']);
    }

    /**
     * Gets query for [[Subject-]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getSubject()
    {
        return $this->hasOne(Subject::class, ['id' => 'subject_id']);
    }

    public static function getTestMaxPoints($id)
    {
        $question_count = Test::findOne($id)->question_count;

        $mid_level_id = QuestionLevel::getLevelId('Средний');
        $hard_level_id = QuestionLevel::getLevelId('Сложный');

        $mid_questions = Question::find()
            ->where(['test_id' => $id, 'level_id' => $mid_level_id])
            ->count();
        $hard_questions = Question::find()
            ->where(['test_id' => $id, 'level_id' => $hard_level_id])
            ->count();

        if ($hard_questions >= $question_count - 2) {
            $max_points = $question_count * 3 - 2;
        } elseif ($hard_questions < $question_count - 2 && $mid_questions >= $question_count - $hard_questions) {
            $max_points = $question_count * 2 + $hard_questions;
        } elseif ($hard_questions < $question_count - 2 && $mid_questions < $question_count - $hard_questions) {
            $max_points = $hard_questions * 2 + $mid_questions + $question_count;
        }

        return $max_points;
    }
    public static function getTestTitle($id)
    {
        return self::findOne(['id' => $id])->title;
    }
    public static function getTestSubject($id)
    {
        return Subject::findOne(['test_id', self::findOne(['id' => $id])->subject_id])->title;
    }
    public static function getTestQuestionsList($group_test)
    {
        $questions_list = [];
        // $group_test = GroupTest::findOne($group_test_id)->test_id;
        // VarDumper::dump($group_test->test_id, 10, true);
        // die;
        $question = Test::findOne($group_test->test_id)->question_count;
        for ($i = 0; $i < $question; $i++) {
            $questions_list[$i + 1] = 'unpassed';
        }

        return $questions_list;
    }
    public static function getNextQuestion($passed_questions, $test_id)
    {
        if ($passed_questions) {
            if (Question::findOne(array_key_last($passed_questions))->type_id == QuestionType::getTypeId('Ввод ответа от студента')) {
                $answer = true;
            } else {
                $answer = StudentAnswer::getIsCorrectAnswer(array_key_last($passed_questions), end($passed_questions));
            }
        }
        // VarDumper::dump(Test::findOne($test_id), 10, true);
        // die;
        $question_count = Test::findOne($test_id)->question_count;

        if (count($passed_questions) == $question_count) {
            return false;
        }

        if ($passed_questions) {
            $current_question_level_id = Question::findOne(array_key_last($passed_questions))->level_id;
            $previous_question_id = array_keys(array_slice($passed_questions, -2, 1, true));
            $previous_question_level_id = Question::findOne($previous_question_id)->level_id;
        }

        foreach ($passed_questions as $question_id => $answers) {
            if ($question_id == (end($previous_question_id))) {
                $previous_answers = $answers;
            }
        }

        if (count($passed_questions) < 2) {
            $questions = static::getQuestionsByLevel($test_id, 'Средний');
            $res = true;
            while ($res) {
                // VarDumper::dump(Test::findOne($questions), 10, true);
                // die;
                $rand_question = $questions[array_rand($questions, 1)];
                $res = array_key_exists($rand_question, $passed_questions);
            }
            return $rand_question;
        }

        if (count($passed_questions) == 2) {
            $i = 0;
            foreach ($passed_questions as $question_id => $answers) {
                if ($i == 0) {
                    $first_question_id = $question_id;
                    $first_questions = $answers;
                }
                if ($i == 1) {
                    $second_question_id = $question_id;
                    $second_questions = $answers;
                }
                $i++;
            }
            if (StudentAnswer::getIsCorrectAnswer($first_question_id,  $first_questions) &&  StudentAnswer::getIsCorrectAnswer($second_question_id, $second_questions)) {

                return $res = static::getQuestionId('Сложный', 'Средний', 'Лёгкий', $test_id, $passed_questions);
            } else {

                return $res = static::getQuestionId('Лёгкий', 'Средний', 'Сложный', $test_id, $passed_questions);
            }
        } else {
            if ($answer) {
                if ($previous_question_level_id != $current_question_level_id) {
                    $title = QuestionLevel::findOne($current_question_level_id)->title;
                    if ($title == 'Сложный') {

                        $res = static::getQuestionId('Сложный', 'Средний', 'Лёгкий', $test_id, $passed_questions);
                    } elseif ($title == 'Средний') {

                        $res = static::getQuestionId('Средний', 'Лёгкий', 'Сложный', $test_id, $passed_questions);
                    } elseif ($title == 'Лёгкий') {
                        $res = static::getQuestionId('Лёгкий', 'Средний', 'Сложный', $test_id, $passed_questions);
                    }
                    return $res;
                } else {
                    if (StudentAnswer::getIsCorrectAnswer($previous_question_id, $previous_answers)) {
                        if ($current_question_level_id == QuestionLevel::getLevelId('Сложный') || $current_question_level_id == QuestionLevel::getLevelId('Средний')) {
                            return $res = static::getQuestionId('Сложный', 'Средний', 'Лёгкий', $test_id, $passed_questions);
                        } else {
                            return $res = static::getQuestionId('Средний', 'Сложный', 'Лёгкий', $test_id, $passed_questions);
                        }
                    } else {
                        return $res = static::getQuestionId('Лёгкий', 'Средний', 'Сложный', $test_id, $passed_questions);
                    }
                }
            } else {
                if ($current_question_level_id == QuestionLevel::getLevelId('Средний') || $current_question_level_id == QuestionLevel::getLevelId('Лёгкий')) {
                    return $res = static::getQuestionId('Лёгкий', 'Средний', 'Сложный', $test_id, $passed_questions);
                } else {
                    return $res = static::getQuestionId('Средний', 'Лёгкий', 'Сложный', $test_id, $passed_questions);
                }
            }
        }
    }
    public static function getQuestionId($first, $second, $third, $test_id, $passed_questions)
    {
        $res = static::getResault($test_id, $passed_questions, $first);
        if (!$res) {
            $res = static::getResault($test_id, $passed_questions, $second);
            if (!$res) {
                $res = static::getResault($test_id, $passed_questions, $third);
            };
        };
        return $res;
    }
    public static function getResault($test_id, $passed_questions, $title)
    {
        $questions = static::getQuestionsByLevel($test_id, $title);
        if ($questions) {
            foreach ($questions as $key => $question) {
                $res = array_key_exists($question, $passed_questions);
                if (!$res) { //res = false
                    return $questions[$key]; // question_id
                }
            };

            if ($res) { // res = true
                return !$res;  // false  
            }
        }
    }
    public static function getQuestionsByLevel($test_id, $level_title)
    {
        // VarDumper::dump(QuestionLevel::getLevelId($level_title), 10, true);
        // die;
        return static::findOne($test_id)->getQuestions()->where(['level_id' => QuestionLevel::getLevelId($level_title)])->column();
    }

    public static function getFindActiveTest()
    {
        return GroupTest::findOne(['group_id' => UserGroup::findOne(['user_id' => Yii::$app->user->identity->id])->group_id])->test_id;
    }
    public static function getActiveTestCount()
    {
        // return (int)(new Query())
        //     ->select('test_id')
        //     ->from('group_test')
        //     ->where(['group_id' => UserGroup::findOne(['user_id' => Yii::$app->user->identity->id])->group_id])
        //     ->indexBy('id')
        //     ->column();
        $testIdArr = (new Query())
            ->select('test_id')
            ->from('group_test')
            ->where(['group_id' => UserGroup::findOne(['user_id' => Yii::$app->user->identity->id])->group_id])
            ->indexBy('id')
            ->column();
        foreach ($testIdArr as $key => $value) {
            # code...
            $test = (new Query())
                ->select('id')
                ->from('test')
                ->where(['id' => $value, 'is_active' => true])
                ->count();
            if ($test) {
                return $test;
            }
        }
        // VarDumper::dump($testIdArr, 10, true);
        // die();
    }
    public static function getActiveTest($group_id)
    {
        // VarDumper::dump($group_id,10,true);die();
        $groupTests = (new Query())
            ->select('test_id')
            ->from('group_test')
            ->where(['group_id' => $group_id])
            ->indexBy('id')
            ->column();

        return (new Query())
            ->select('id')
            ->from('test')
            ->where(['is_active' => true])
            ->count();
    }
}
