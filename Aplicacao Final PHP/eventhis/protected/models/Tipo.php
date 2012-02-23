<?php

/**
 * This is the model class for table "tipo".
 *
 * The followings are the available columns in table 'tipo':
 * @property integer $idtipo
 * @property string $nome
 *
 * The followings are the available model relations:
 * @property Evento[] $eventos
 */
class Tipo extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @return Tipo the static model class
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
		return 'tipo';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('idtipo', 'required'),
			array('idtipo', 'numerical', 'integerOnly'=>true),
			array('nome', 'length', 'max'=>255),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('idtipo, nome', 'safe', 'on'=>'search'),
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
			'eventos' => array(self::HAS_MANY, 'Evento', 'tipo_idtipo'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idtipo' => 'Idtipo',
			'nome' => 'Nome',
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

		$criteria->compare('idtipo',$this->idtipo);
		$criteria->compare('nome',$this->nome,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        /**
         * Retorna todos os tipos existentes na base 
         * para a construção de dropDownLists
         */
        public static function getTipos()
        {
                $ar = self::model()->findAll();
                $data = array();
                foreach($ar as $val)
                        $data[$val["idtipo"]] = $val["nome"];
                return $data;
        }
        
        /**
         * Retorna todos os tipos existentes na base 
         * para a construção de dropDownLists
         */
        public static function getTiposPesquisa()
        {
                $ar = self::model()->findAll();
                $data = array();                
                $data[0] = "todos";
                foreach($ar as $val)
                        $data[$val["idtipo"]] = $val["nome"];
                return $data;
        }
        
        public static function getTipo($id)
        {
                $model = self::model();
                $tipo = $model->findByPk($id);
                return $tipo;
        }
        
        public static function linkImgTipo($id)
        {
                $src = 'http://dl.dropbox.com/u/42818496/tipos/';
                $src .= $id.'.png';
                return $src;
        }
}