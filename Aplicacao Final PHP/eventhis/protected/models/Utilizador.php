<?php

/**
 * This is the model class for table "utilizador".
 *
 * The followings are the available columns in table 'utilizador':
 * @property integer $oid
 * @property string $email
 * @property string $password
 * @property string $nome
 * @property string $foto
 * @property double $lat
 * @property double $lon
 * @property double $lat2
 * @property double $lon2
 * @property string $username   
 * @property string $teste
 *
 * The followings are the available model relations:
 * @property Comentario[] $comentarios
 * @property Evento[] $eventos
 */
class Utilizador extends CActiveRecord
{
        // foi necessário incluir uma variável de instância para 
        // realizar o upload da imagem
        public $imagem;
	/**
	 * Returns the static model of the specified AR class.
	 * @return Utilizador the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'utilizador';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			/* Necessário retirar uma vez que o identificador é 
                         * auto incrementável.
                         * array('oid', 'required'),
                         */
			array('oid', 'numerical', 'integerOnly'=>true),
			array('lat, lon, lat2, lon2', 'numerical'),
			array('email, password, nome, foto, username, teste', 'length', 'max'=>255),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('oid, email, password, nome, foto, lat, lon, lat2, lon2, username, teste', 'safe', 'on'=>'search'),
                        // para o upload da imagem
                        array('imagem','file','types'=>'jpg, gif, png'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'comentarios' => array(self::HAS_MANY, 'Comentario', 'utilizador_oid'),
			'eventos' => array(self::MANY_MANY, 'Evento', 'favoritos(utilizador_oid, evento_idevento)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'oid' => 'Oid',
			'email' => 'Email',
			'password' => 'Password',
			'nome' => 'Nome',
			'foto' => 'Foto',
			'lat' => 'Latitude Menor',
			'lon' => 'Longitude Menor',
			'lat2' => 'Latitude Maior',
			'lon2' => 'Longitude Maior',
			'username' => 'Username',
			'teste' => 'Teste',
                        'imagem' => 'Fotografia',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('oid',$this->oid);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('password',$this->password,true);
		$criteria->compare('nome',$this->nome,true);
		$criteria->compare('foto',$this->foto,true);
		$criteria->compare('lat',$this->lat);
		$criteria->compare('lon',$this->lon);
		$criteria->compare('lat2',$this->lat2);
		$criteria->compare('lon2',$this->lon2);
		$criteria->compare('username',$this->username,true);
		$criteria->compare('teste',$this->teste,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public static function getUserByUsername($username)
        {
                return self::model()->findByAttributes(
                                                array(
                                                     'username'=>$username
                                                )
                );
        }        
        
        public static function getIdByUsername($username)
        {
                return self::model()->findByAttributes(
                                                array(
                                                     'username'=>$username
                                                )
                )->oid;
        }
        
        public static function getFotoUrlById($id)
        {
                $mod = self::model();
                $model = $mod->findByPk($id);
                return $model->teste;
        }
        
        public static function getUserById($id)
        {
                $mod = self::model();
                $model = $mod->findByPk($id);
                return $model;
        }
        
        public static  function getFotoUrlByUsername($username)
        {
                return self::model()->findByAttributes(
                                                array(
                                                     'username'=>$username
                                                )
                )->teste;                
        }
        
}