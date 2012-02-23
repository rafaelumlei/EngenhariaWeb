<?php

/**
 * This is the model class for table "favoritos".
 *
 * The followings are the available columns in table 'favoritos':
 * @property integer $utilizador_oid
 * @property integer $evento_idevento
 */
class Favoritos extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @return Favoritos the static model class
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
		return 'favoritos';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('utilizador_oid, evento_idevento', 'required'),
			array('utilizador_oid, evento_idevento', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('utilizador_oid, evento_idevento', 'safe', 'on'=>'search'),
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
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
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

		$criteria->compare('utilizador_oid',$this->utilizador_oid);
		$criteria->compare('evento_idevento',$this->evento_idevento);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        /**
         * @return array with ids of favourite events
         */
        public static function getFavoritosUser($idusr)
        {
                $modelF = self::model();
                $fav = $modelF->findAllByAttributes(array('utilizador_oid'=>$idusr));
                $favoritos = array();
                foreach ($fav as $fa) 
                        array_push($favoritos,$fa->evento_idevento);
                return $favoritos;
        }
        
        /**
         *
         * @param type $iduser
         * @param type $idevento
         * @return type 
         */
        public static function isFavoriteUsrEv($iduser,$idevento)
        {
                 /**
                 * Modelo que vai permitir saber se o modelo é favorito do 
                 * utilizador que está a visualizar a página ou não.
                 */
                $modelF = self::model();
                $fav = $modelF->findByAttributes(
                                array(
                                    'utilizador_oid'=>$iduser,
                                    'evento_idevento'=>$idevento
                                )
                );       
                /**
                 * true se é favorito,
                 * false senão é
                 */
                return ($fav)?true:false;                    
        }
        
        /**
         * @param type $idusr
         * @param type $idev 
         */
        public static function deleteFavorito($idusr,$idev)
        {
                $modelF = self::model();
                $modelF->evento_idevento = $idev;
                $modelF->utilizador_oid = $idusr;
                $modelF->delete(); 
        }
        
        /**
         * @param type $idusr
         * @param type $idev 
         */
        public static function insertFavorito($idusr,$idev)
        {
                $modelF = new Favoritos;
                $modelF->evento_idevento = $idev;
                $modelF->utilizador_oid = $idusr;
                $modelF->save();
        }
        
}