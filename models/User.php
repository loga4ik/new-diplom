<?php

namespace app\models;

use Yii;
use yii\db\Query;
use yii\web\IdentityInterface;

/**
 * This is the model class for table "user".
 *
 * @property int $id
 * @property string $name
 * @property string $surname
 * @property string $patronimyc
 * @property string $password
 * @property string|null $email
 * @property string|null $phone
 * @property int $role_id
 * @property string $auth_key
 * @property string $login
 * @property string $group_id

 *
 * @property Group $group
 * @property Role $role
 */
class User extends \yii\db\ActiveRecord implements IdentityInterface
{
    public $fileInput;
    public $group_id;
    public static function tableName()
    {
        return 'user';
    }
    public static function findIdentity($id)
    {
        return static::findOne($id);
    }

    public static function findIdentityByAccessToken($token, $type = null)
    {
        return static::findOne(['access_token' => $token]);
    }

    public function getId()
    {
        return $this->id;
    }

    public function getAuthKey()
    {
        return $this->auth_key;
    }

    public function validateAuthKey($authKey)
    {
        return $this->auth_key === $authKey;
    }
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'surname', 'patronimyc', 'login', 'password', 'role_id', 'auth_key'], 'required'],
            [['role_id'], 'integer'],
            [['name', 'surname', 'patronimyc', 'group_id', 'password', 'email', 'phone', 'auth_key'], 'string', 'max' => 255],
            [['role_id'], 'exist', 'skipOnError' => true, 'targetClass' => Role::class, 'targetAttribute' => ['role_id' => 'id']],
            [['fileInput'], 'file', 'skipOnEmpty' => true, 'extensions' => 'txt'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Имя',
            'surname' => 'Фамилия',
            'patronimyc' => 'Отчество',
            'password' => 'Пароль',
            'password_repeat' => 'Повтор пароля',
            'email' => 'Email',
            'phone' => 'Телефон',
            'login' => 'Логин',
            'role_id' => 'Роль',
            'fileInput' => 'Список студентов',
            'group_id' => 'группа',
            'auth_key' => 'Auth Key',
        ];
    }

    /**
     * Gets query for [[Group]].
     *
     * @return \yii\db\ActiveQuery
     */

    /**
     * Gets query for [[Role]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getRole()
    {
        return $this->hasOne(Role::class, ['id' => 'role_id']);
    }
    public static function findByUsername($login)
    {
        return self::findOne(['login' => $login]);
    }
    public function validatePassword($password)
    {
        return Yii::$app->security->validatePassword($password, $this->password);
    }
    public static function getIsAdmin()
    {
        return Yii::$app->user->identity->role_id == Role::getRoleId('admin');
    }
    public static function getIsManager()
    {
        return Yii::$app->user->identity->role_id == Role::getRoleId('manager');
    }
    public static function getIsTeacher()
    {
        return Yii::$app->user->identity->role_id == Role::getRoleId('teacher');
    }
    public static function getIsStudent()
    {
        return Yii::$app->user->identity->role_id == Role::getRoleId('student');
    }
    public static function getUserGroup()
    {
        // return UserGroup::findOne(['user_id' => Yii::$app->user->id])->group_id;
        return (new Query())
            ->select('group_id')
            ->from('user_group')
            ->where(['user_id' => Yii::$app->user->id])
            ->column();
    }
}
