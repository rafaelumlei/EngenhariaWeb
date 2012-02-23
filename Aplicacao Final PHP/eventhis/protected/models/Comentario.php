<?php

/**
 * This is the model class for table "comentario".
 *
 * The followings are the available columns in table 'comentario':
 * @property integer $idcomentario
 * @property string $titulo
 * @property string $texto
 * @property string $dtcom
 * @property integer $utilizador_oid
 * @property integer $evento_idevento
 *
 * The followings are the available model relations:
 * @property Evento $eventoIdevento
 * @property Utilizador $utilizadorO
 */
class Comentario extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @return Comentario the static model class
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
		return 'comentario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('idcomentario', 'required'),
			array('idcomentario, utilizador_oid, evento_idevento', 'numerical', 'integerOnly'=>true),
			array('titulo, texto', 'length', 'max'=>255),
			array('dtcom', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('idcomentario, titulo, texto, dtcom, utilizador_oid, evento_idevento', 'safe', 'on'=>'search'),
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
			'eventoIdevento' => array(self::BELONGS_TO, 'Evento', 'evento_idevento'),
			'utilizadorO' => array(self::BELONGS_TO, 'Utilizador', 'utilizador_oid'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idcomentario' => 'Idcomentario',
			'titulo' => 'Titulo',
			'texto' => 'Texto',
			'dtcom' => 'Dtcom',
			'utilizador_oid' => 'Utilizador Oid',
			'evento_idevento' => 'Evento Idevento',
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

		$criteria->compare('idcomentario',$this->idcomentario);
		$criteria->compare('titulo',$this->titulo,true);
		$criteria->compare('texto',$this->texto,true);
		$criteria->compare('dtcom',$this->dtcom,true);
		$criteria->compare('utilizador_oid',$this->utilizador_oid);
		$criteria->compare('evento_idevento',$this->evento_idevento);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}