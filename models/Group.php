<?php

namespace app\models;

use Yii;
use yii\db\Query;

/**
 * This is the model class for table "group".
 *
 * @property int $id
 * @property string $title
 *
 * @property GroupConnector[] $groupConnectors
 * @property User[] $users
 */
class Group extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'group';
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
            'title' => 'навание',
        ];
    }

    /**
     * Gets query for [[Users]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUsers()
    {
        return $this->hasMany(User::class, ['group_id' => 'id']);
    }
    public static function getAllGroupTitle()
    {
        return (new Query())
            ->select('title')
            ->from('group')
            ->indexBy('id')
            ->column();
    }

    public static function getGroupTitle($group_id)
    {
        return self::findOne(['id' => $group_id])->title;
    }

    public static function getCurrentGroup($first_group_id)
    {
        $next_groups = [];
        $next_group = Group::findOne(['previous_group_id' => $first_group_id]);
        if ($next_group) {
            $next_group_id = $next_group->id;
            for ($i = 1; $i < 5; $i++) {
                if ($next_group = Group::findOne(['previous_group_id' => $next_group_id])) {
                    if ($next_group_id = $next_group->id) {
                        array_push($next_groups, $next_group_id);
                    }
                } else {
                    return $next_group_id;
                }
            }
            return end($next_groups);
        } else {
            return $first_group_id;
        }
    }
    public static function getUserGroup()
    {
        
    }
}
