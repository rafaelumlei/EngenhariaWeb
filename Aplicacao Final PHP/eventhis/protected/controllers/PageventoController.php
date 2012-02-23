<?php
class PageventoController extends Controller 
{
        
        public $layout='//layouts/column2';        
        
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
		);
	}        
        
	public function accessRules()
	{
		return array(
                        // allow all users to perform 'index' and 'view' actions
			array('allow',  
				'actions'=>array('index'),
				'users'=>array('*'),
			),
                        // allow authenticated user to perform 'create' and 'update' actions
			array('allow', 
				'actions'=>array('mudaFavorito','comment'),
				'users'=>array('@'),
			),
                        // deny all users
			array('deny',  
				'users'=>array('*'),
			),
		);
	}       
        
        public function actionIndex($id)
        {       
                /**
                 * Modelo que permite aceder aos dados de um Evento
                 */
                $mod = Evento::model();
                // vai buscar o evento
                $model = $mod->findByPk($id);
                // poe o nome do tipo na variável de
                // instância tipo
                $model->updateNomeTipo();
                if(!isset($model))
                {
                        // TODO: Inserir redireccionamento e ID
                }
                // Se está um utilizador autenticado
                $user = null;
                $criador = null;
                $favorito = null;
                if(!Yii::app()->user->isGuest)
                {
                        /**
                         * Modelo do utilizador que está a visualizar a página 
                         * para se saber se o evento é favorito ou se foi ele 
                         * que o criou.
                         */
                        $username = Yii::app()->user->name;/*get username*/
                        $modelU = Utilizador::model();
                        $user = $modelU->findByAttributes(array('username'=>$username));
                        $favorito = Favoritos::isFavoriteUsrEv($user->oid,$model->idevento);
                        /**
                         * Verifica se utilizador autenticado a visualizar a 
                         * página é o criador.
                         */
                         if( $model->utilizador_oid == $user->oid )
                         {
                                 $criador = true; 
                         } else {
                                 $criador = false;
                         }                    
                }
                /**
                 * DataProvider que vai ser necessária para produzir a
                 * lista de comentários do evento em causa.
                 */
                $dataComments = new CActiveDataProvider('Comentario',
                                    array(
                                          'criteria'=>array(
                                                'condition'=>'evento_idevento='.$id,
                                                'order'=>'dtcom DESC',
                                                'select'=>array(
                                                       'titulo',
                                                       'texto',
                                                       'utilizador_oid'
                                                 ),
                                           ),
                                           'pagination'=>array(
                                                'pageSize'=>4,
                                           ),
                                          
                                     )
                );
                $model->setAttributeCriado('Morada',
                                            UtilGeocode::getMorada($model->getAttribute('lat'),
                                                                   $model->getAttribute('lon'))
                );
                $this->render('index',array(
                                'evento' => $model,
                                'comentarios' => $dataComments,
                                'utilizador' =>$user,
                                'criador' => $criador,
                                'favorito' => $favorito
                        )    
                );
        }
        
        public function actionMudaFavorito()
        {
                $idev = $_GET['idevento'];
                $idusr = $_GET['iduser'];
                $modelF = new Favoritos;
                $user = Utilizador::getUserById($idusr);
                if(Yii::app()->user->name != $user->username)
                        echo "Hello Hacker, your ip has been registed!";
                else if(Favoritos::isFavoriteUsrEv($idusr, $idev))
                {
                        Favoritos::deleteFavorito($idusr, $idev);
                        $label = ".\./images/star_empty.png";
                }
                else {
                        Favoritos::insertFavorito($idusr, $idev);
                        $label = ".\./images/star_full.png";
                }
                echo $label;
        }
        
        public function actionComment()
        {
		$model=new Comentario;
		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);
		if(isset($_POST['Comentario']))
		{
			$model->attributes=$_POST['Comentario'];
                        $model->dtcom = new CDbExpression('NOW()');
                        $model->idcomentario = 0;
                        echo $model->evento_idevento;
			if($model->save())
				$this->redirect(array(
                                                      '//pagevento/index',
                                                      'id'=>$model->evento_idevento
                                                      )
                                       );
		}
                $this->redirect(array(
                                      '//pageevento/index',
                                      'id'=>$model->evento_idevento
                               )
                );
           
        }
}
?>
