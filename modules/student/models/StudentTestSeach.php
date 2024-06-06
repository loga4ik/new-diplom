<?php

namespace app\modules\student\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\StudentTest;
use Yii;

/**
 * StudentTestSeach represents the model behind the search form of `app\models\StudentTest`.
 */
class StudentTestSeach extends StudentTest
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'points', 'mark', 'test_id', 'user_id', 'group_test_id', 'cheked', 'attempt'], 'integer'],
            [['date', 'ip'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = StudentTest::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'points' => $this->points,
            'mark' => $this->mark,
            'test_id' => $this->test_id,
            'user_id' => Yii::$app->user->id,
            'group_test_id' => $this->group_test_id,
            'cheked' => $this->cheked,
            'date' => $this->date,
            'attempt' => $this->attempt,
        ]);

        $query->andFilterWhere(['like', 'ip', $this->ip]);

        return $dataProvider;
    }
}
