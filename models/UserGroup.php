<?php

namespace app\models;

use Yii;
use yii\db\Query;

/**
 * This is the model class for table "user_group".
 *
 * @property int $id
 * @property int $user_id
 * @property int $group_id
 *
 * @property Group $group
 * @property User $user
 */
class UserGroup extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'user_group';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['user_id', 'group_id'], 'required'],
            [['user_id', 'group_id'], 'integer'],
            [['group_id'], 'exist', 'skipOnError' => true, 'targetClass' => Group::class, 'targetAttribute' => ['group_id' => 'id']],
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
            'user_id' => 'User ID',
            'group_id' => 'Group ID',
        ];
    }

    /**
     * Gets query for [[Group]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getGroup()
    {
        return $this->hasOne(Group::class, ['id' => 'group_id']);
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
    public static function getStudentsGroups()
    {
        // $role_id = null
        return (new Query)
            ->select('group_id')
            ->from('user_group')
            // ->where(['role_id' => $role_id])
            ->indexBy('user_id')
            ->column();
    }
    public static function getGroupStudents($group_id)
    {
        return (new Query)
            ->select('user_id')
            ->from('user_group')
            ->where(['group_id' => $group_id])
            ->indexBy('id')
            ->column();
    }
}
