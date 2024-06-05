<?php

namespace app\modules\teacher\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\StudentTest;

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
        $query = StudentTest::find()->where(['cheked' => 0]);

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => [
                'pageSize' => 12
            ],
            'sort' => [
                'defaultOrder' => [
                    'id' => SORT_DESC,
                ]
            ],
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
            'user_id' => $this->user_id,
            'group_test_id' => $this->group_test_id,
            'cheked' => $this->cheked,
            'date' => $this->date,
            'attempt' => $this->attempt,
        ]);

        $query->andFilterWhere(['like', 'ip', $this->ip]);

        return $dataProvider;
    }
}
