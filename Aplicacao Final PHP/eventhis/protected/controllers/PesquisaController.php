<?php

class PesquisaController extends Controller 
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
                    array(
                            'allow',
                            'actions'=>array('pesquisar','pesquisa'),
                            'users'=>array('*')
                        ),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
                );
                
        }
        
        public function actionIndex()
        {       
                echo 'index';
        }

        public function actionPesquisa()
        {
                $model = new PesquisaForm;
		$this->render('pesquisa_form',array('model'=>$model));                
        }
        
        public function actionPesquisar($texto,$tipo)
        {
                $model = Evento::model();
                $model->titulo = $texto;
                $model->descricao = $texto;
                $model->tipo_idtipo = $tipo;
                if ( $tipo == '0' ) $data = $model->search();
                else $data = $model->searchSimples();
                $this->renderPartial('resultados_pesquisa',array('data'=>$data));
        }
        
}
?>
