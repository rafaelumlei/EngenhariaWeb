<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="language" content="en" />

	<!-- blueprint CSS framework -->
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/screen.css" media="screen, projection" />
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/print.css" media="print" />
	<!--[if lt IE 8]>
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/ie.css" media="screen, projection" />
	<![endif]-->

	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/main.css" />
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/form.css" />

	<title><?php echo CHtml::encode($this->pageTitle); ?></title>
</head>
<body>
        <div class="container" id="page">

                <div id="header" style="width: 100%; height: 100px;">
                        <div id="logo" style="width: 300px;float : left;" >
                                <?php
                                        echo CHtml::link(CHtml::image('./images/logo2.png')
                                                        ,array('//site/index'));
                                ?> 
                        </div>
                        <?php 
                                $modelFL = new LoginForm();
                                $this->renderPartial(
                                        '//utils/LoginUtil',
                                        array('action'=>'//site/login',
                                              'model'=>$modelFL
                                             )
                                );
                        ?>
                </div>
                <div id="mainmenu" style="width: 100%;clear:both;">
                        <?php
                        if(Yii::app()->user->isGuest)
                        {
                                $this->widget('zii.widgets.CMenu',array(
                                        'items'=>array(
                                                array('label'=>'Página Inicial', 'url'=>array('/site/index')),
                                                array('label'=>'Pesquisar Eventos', 'url'=>array('//pesquisa/pesquisa')),                                        ),
                                )); 
                        } else if(Yii::app()->user->name != 'admin'){
                                $this->widget('zii.widgets.CMenu',array(
                                        'items'=>array(
                                                        array('label'=>'Página Inicial', 'url'=>array('//site/index')),
                                                        array('label'=>'Pesquisar Eventos', 'url'=>array('//pesquisa/pesquisa')),
                                                        array('label'=>'Ver Favoritos', 'url'=>array('//favoritos/index')),
                                                        array('label'=>'Alterar Dados', 'url'=>array('//utilizador/update&id='.
                                                                                  Utilizador::getIdByUsername(Yii::app()->user->name))),
                                                        array('label'=>'Criar Evento','url'=>array('//evento/create')),
                                                        array('label'=>'Os Meus Eventos','url'=>array('//evento/created'))
                                                )
                                ));                                 
                        } else {
                                $this->widget('zii.widgets.CMenu',array(
                                        'items'=>array(
                                                        array('label'=>'Gerir Eventos', 'url'=>array('//evento/admin')),
                                                        array('label'=>'Gerir Comentários', 'url'=>array('//comentario/admin')),
                                                        array('label'=>'Gerir Utilizadores', 'url'=>array('//utilizador/admin')),
                                                        array('label'=>'Gerir Newsletters', 'url'=>array('//newsletter/index')),
                                                )
                                ));                                      
                        }
                        ?>
                </div>
                <?php if(isset($this->breadcrumbs)):?>
                        <?php $this->widget('zii.widgets.CBreadcrumbs', array(
                                'links'=>$this->breadcrumbs,
                        )); ?>
                <?php endif?>

                <?php echo $content; ?>

                <div id="footer">
                        Copyright &copy; <?php echo date('Y'); ?> by My Company.<br/>
                        All Rights Reserved.<br/>
                        <?php echo Yii::powered(); ?>
                </div>

        </div>
</body>
</html>