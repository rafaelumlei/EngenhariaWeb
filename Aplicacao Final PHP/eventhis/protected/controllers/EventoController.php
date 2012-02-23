<?php

class EventoController extends Controller
{
	/**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout='//layouts/column2';

	/**
	 * @return array action filters
	 */
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
		);
	}

	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules()
	{
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array('index','view','admin','eventos'),
				'users'=>array('*'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update','created'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('admin'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView($id)
	{
		$this->render('view',array(
			'model'=>$this->loadModel($id),
		));
	}
        
        public function actionEventos($lat1,$lon1,$lat2,$lon2)
        {
                $model = new Evento;
                // construção do critério de pesquisa para eventos da area
                $criterio = new CDbCriteria;
                $criterio->condition = "lat > $lat1 and lat < $lat2 "
                        . "and lon > $lon1 and lon < $lon2 and dtfim > now()";
                $eventos = $model->findAll($criterio);
                echo CJSON::encode($eventos);
        }

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate()
	{
		$model=new Evento;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Evento']))
		{
			$model->attributes=$_POST['Evento'];
                        $model->utilizador_oid = Utilizador::getIdByUsername(
                                                        Yii::app()->user->name
                                                 );
			if($model->save())
				$this->redirect(array('//pagevento/index','id'=>$model->idevento));
		}

		$this->render('create',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id)
	{
		$model=$this->loadModel($id);       
                /**
                 * Verificar se este é mesmo o dono do evento 
                 * antes de deixar prosseguir
                 */
                $idUser = Utilizador::getIdByUsername(Yii::app()->user->name);
                if( $idUser != $model->utilizador_oid)
                {
                        $this->redirect('http://www.fbi.gov');
                }
                
		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Evento']))
		{
			$model->attributes=$_POST['Evento'];
			if($model->save())
				$this->redirect(array('//pagevento/index','id'=>$model->idevento));
		}

		$this->render('update',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDelete($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			$this->loadModel($id)->delete();
			if(!isset($_GET['ajax']))
				$this->redirect(Yii::app()->homeUrl);
		}
		else
			throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
		$dataProvider=new CActiveDataProvider('Evento');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new Evento('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Evento']))
			$model->attributes=$_GET['Evento'];

		$this->render('admin',array(
			'model'=>$model,
		));
	}
        
        public function actionCreated()
        {
                $criterio = new CDbCriteria();
                $criterio->select = 'titulo,idevento,'.'descricao,'.'dtinicio,'.
                                     'dtfim,tipo_idtipo,'.'lat,'.'lon';
                $criterio->condition = 'utilizador_oid = '.
                                Utilizador::getIdByUsername(Yii::app()->user->name);
                $eventosUtilizador = new CActiveDataProvider(
                                'Evento',
                                array(
                                        'criteria'=> $criterio,
                                        'pagination'=>array(
                                                 'pageSize'=>4,
                                         ), 
                                )
                );
                $this->render('created',array('eventosUtilizador'=>$eventosUtilizador));
        }

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadModel($id)
	{
		$model=Evento::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param CModel the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='evento-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
}
