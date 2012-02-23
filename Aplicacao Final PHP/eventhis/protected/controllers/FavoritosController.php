<?php

class FavoritosController extends Controller 
{
        
        public $layout='//layouts/column2';
        
        public function accessRules() {
                return array(
                    array('allow',
                        'actions'=>array('index','delete'),
                        'users'=>array('@')
                    ),
                    array('deny',  // deny all users
                        'users'=>array('*'),
                    ),                    
                );
        }
        
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
		);
	}        
        
        public function actionIndex()
        {
                $username = Yii::app()->user->name;
                $modelU = Utilizador::model();
                $oid = $modelU->findByAttributes(array('username'=>$username))->oid;
                $eventosFavoritos = Evento::getEventosFavoritosUser($oid,5);
                $this->render('index',array('data'=>$eventosFavoritos));
        }
        
        public function actionDelete($idevento)
        {
                $idusr = Utilizador::getIdByUsername(Yii::app()->user->name);
                Favoritos::deleteFavorito($idusr,$idevento);
                $this->redirect(array('//favoritos/index'));
        }
}

?>
