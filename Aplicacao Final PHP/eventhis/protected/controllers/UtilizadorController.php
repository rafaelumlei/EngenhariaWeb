<?php

class UtilizadorController extends Controller
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
				'actions'=>array('index','view','theme'),
				'users'=>array('*'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update'),
				'users'=>array('*'),
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

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate()
	{
		$model=new Utilizador;
		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);
		if(isset($_POST['Utilizador']))
		{
			$model->attributes=$_POST['Utilizador'];
                        // vai buscar a imagem
                        $model->imagem=CUploadedFile::getInstance($model,'imagem');
                        $ar = explode('.', $model->imagem->getName());
                        // a fotografia ficará com o nome username + extensão
                        $path = Yii::app()->getBasePath()."\\.."."\\images\\users\\".$model->username.'.'. $ar[1];
                        // fica guarda na coluna teste
                        $model->teste = "./images/users/".$model->username.'.'. $ar[1];
			if($model->save() && $model->imagem->getName() )
                        {
                               $model->imagem->saveAs($path);
                               $this->redirect(array('view','id'=>$model->oid));
                        }
		}
		$this->render('create',array(
                                                'model'=>$model,
                                       )
		);
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id)
	{
		$model=$this->loadModel($id);
                $userId = Utilizador::getIdByUsername(Yii::app()->user->name);
                /*
                 * Se alguém estiver a tentar actualizar um utilizador
                 * que não seja o próprio, é redireccionado para o 
                 * site do fbi!!!
                 */
                if( $id != $userId && Yii::app()->user->name != "admin")
                {
                        $this->redirect('http://www.fbi.gov');
                }
		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);
		if(isset($_POST['Utilizador']))
		{
			$model->attributes=$_POST['Utilizador'];
			if($model->save())
				$this->redirect(array('//site/index'));
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
			// we only allow deletion via POST request
			$this->loadModel($id)->delete();

			// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
			if(!isset($_GET['ajax']))
				$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
		}
		else
			throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
		$dataProvider=new CActiveDataProvider('Utilizador');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new Utilizador('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Utilizador']))
			$model->attributes=$_GET['Utilizador'];
		$this->render('admin',array(
			'model'=>$model,
		));
	}
        
        public function actionTheme()
        {
                if(Yii::app()->theme != null)
                        echo Yii::app()->theme;
                else echo "O tema aplicado e o por defeito";
        }

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadModel($id)
	{
		$model=Utilizador::model()->findByPk($id);
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
		if(isset($_POST['ajax']) && $_POST['ajax']==='utilizador-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
}
