<?php

/**
 * This is the model class for table "evento".
 *
 * The followings are the available columns in table 'evento':
 * @property integer $idevento
 * @property string $dtfim
 * @property string $dtinicio
 * @property string $titulo
 * @property string $descricao
 * @property double $lat
 * @property double $lon
 * @property integer $proxnewsletter
 * @property integer $tipo_idtipo
 * @property integer $utilizador_oid
 *
 * The followings are the available model relations:
 * @property Comentario[] $comentarios
 * @property Tipo $tipoIdtipo
 * @property Utilizador $utilizadorO
 * @property Utilizador[] $utilizadors
 * @property Newsletter[] $newsletters
 */
class Evento extends CActiveRecord
{
        
        public $nomeTipo;
        
	/**
	 * Returns the static model of the specified AR class.
	 * @return Evento the static model class
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
		return 'evento';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			//array('idevento', 'required'),
			array('idevento, proxnewsletter, tipo_idtipo, utilizador_oid', 'numerical', 'integerOnly'=>true),
			array('lat, lon', 'numerical'),
			array('titulo, descricao', 'length', 'max'=>255),
			array('dtfim, dtinicio', 'safe'),
                        array('nomeTipo','safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('idevento, dtfim, dtinicio, titulo, descricao, lat, lon, proxnewsletter, tipo_idtipo, utilizador_oid', 'safe', 'on'=>'search'),
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
			'comentarios' => array(self::HAS_MANY, 'Comentario', 'evento_idevento'),
			'tipoIdtipo' => array(self::BELONGS_TO, 'Tipo', 'tipo_idtipo'),
			'utilizadorO' => array(self::BELONGS_TO, 'Utilizador', 'utilizador_oid'),
			'utilizadors' => array(self::MANY_MANY, 'Utilizador', 'favoritos(evento_idevento, utilizador_oid)'),
			'newsletters' => array(self::HAS_MANY, 'Newsletter', 'evento_idevento'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idevento' => 'Idevento',
			'titulo' => 'Título do Evento',
			'descricao' => 'Descricão do Evento',
			'dtinicio' => 'Data de Ínicio',                    
			'dtfim' => 'Data de Fim',
			'lat' => 'Latitude',
			'lon' => 'Longitude',
			'proxnewsletter' => 'Próxima Newsletter',
			'tipo_idtipo' => 'Tipo',
			'utilizador_oid' => 'Utilizador Oid',
                        'nomeTipo'=> 'Tipo'
		);
	}

        public function search($elsPag = '5')
        {
                $criteria = new CDbCriteria();
                $criteria->condition = 'dtfim < NOW()';
                $criteria->compare('descricao',$this->descricao,true,'OR');
                $criteria->compare('titulo',$this->titulo,true,'OR');
		return new CActiveDataProvider($this, array(
			 'criteria'=>$criteria,
                         'pagination'=>array(
                                                'pageSize'=>$elsPag,
                                           ),
		));
        }
        
        public function searchSimples($elsPag = '5')
        {
                $criteria = new CDbCriteria();
                $criteria->condition = 'dtfim < NOW()';
                $criteria->compare('descricao',$this->descricao,true,'OR');
                $criteria->compare('titulo',$this->titulo,true,'OR');
                $criteria->compare('tipo_idtipo',$this->tipo_idtipo,false,'AND');
		return new CActiveDataProvider($this, array(
			 'criteria'=>$criteria,
                         'pagination'=>array(
                                                'pageSize'=>$elsPag,
                                           ),
		));
        }
        
        public function searchComplexa()
        {
                $criteria = new CDbCriteria();
                $criteria->condition = 'dtfim < NOW()';
                $criteria->compare('descricao',$this->descricao,true,'OR');
                $criteria->compare('titulo',$this->titulo,true,'OR');
                $criteria->compare('tipo_idtipo',$this->tipo_idtipo,false,'AND');
                return $this->findAll($criteria);
        }
        
        /**
         * @param type $iduser id of the user which favorite events are required
         * @param type $pgs number of elements for page to specify pagination attribute of CListView
         * @return CActiveDataProvider with the favorite events of the given user, which can be used to show the events using a 
         */
        public static function getEventosFavoritosUser($iduser,$elsPag)
        {
            $modelE = self::model();
            $favRule = array('idevento',Favoritos::getFavoritosUser($iduser));
            $criterio = new CDbCriteria();
            // Passa-se o nome do atributo e os valores in (val1,val2,val3,...)
            $criterio->addInCondition($favRule[0],$favRule[1]);
            $criterio->select = array(
                                        'idevento',
                                        'titulo',
                                        'dtinicio',
                                        'dtfim',
                                        'lat',
                                        'lon'
                                );
            $criterio->addCondition('dtfim > '.(new CDbExpression('NOW()')));
            $criterio->order = 'dtinicio DESC';
            return new CActiveDataProvider($modelE,
                                                array(
                                                    'criteria'=>$criterio,
                                                    'pagination'=>
                                                            array(
                                                               'pageSize'=>$elsPag
                                                            )
                                                )
                       );
        }
        
        public function updateNomeTipo()
        {
                $this->nomeTipo = $this->tipoIdtipo->nome;
        }
        
        /**
         * @param uma lista de active records.
         */
        public static function xmlEventos($eventos)
        {
                $xmlEventos = '<eventos>';
                //print_r($eventos);
                foreach( $eventos as $val )
                {
                     $xmlEventos .= '<evento>';
                     $xmlEventos .= '<id>'.$val["idevento"].'</id>';
                     $xmlEventos .= '<titulo>'.$val["titulo"].'</titulo>';
                     $xmlEventos .= '<tipo>'.$val["tipo_idtipo"].'</tipo>';
                     $xmlEventos .= '</evento>';
                }
                $xmlEventos .= '</eventos>';
                // estipula que a resposta será dada em XML
                header("Content-type: text/xml");
                echo $xmlEventos;                
        }    
        
        /**
         * 
         */
        public function getEventosProxNewsletter($elsPag = 5)
        {
                $criteria = new CDbCriteria();
                $criteria->condition = 'dtfim > NOW()';
                $criteria->compare('proxnewsletter',false,$this->proxnewsletter,'AND');
		return new CActiveDataProvider($this, array(
			 'criteria'=>$criteria,
                         'pagination'=>array(
                                                'pageSize'=>$elsPag,
                                           ),
		));                
        }

        public function getEventosProxNewsletterIt()
        {
                $criteria = new CDbCriteria();
                $criteria->condition = 'dtfim > NOW()';
                $criteria->compare('proxnewsletter',false,$this->proxnewsletter,'AND');
		return $this->findAll($criteria);
        }        
        
	public function searchAdmin()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('idevento',$this->idevento);
		$criteria->compare('dtfim',$this->dtfim,true);
		$criteria->compare('dtinicio',$this->dtinicio,true);
		$criteria->compare('titulo',$this->titulo,true);
		$criteria->compare('descricao',$this->descricao,true);
		$criteria->compare('lat',$this->lat);
		$criteria->compare('lon',$this->lon);
		$criteria->compare('proxnewsletter',$this->proxnewsletter);
		$criteria->compare('tipo_idtipo',$this->tipo_idtipo);
		$criteria->compare('utilizador_oid',$this->utilizador_oid);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
        }        
        
}