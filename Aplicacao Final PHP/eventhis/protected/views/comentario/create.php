<?php
$this->breadcrumbs=array(
	'Comentarios'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List Comentario', 'url'=>array('index')),
	array('label'=>'Manage Comentario', 'url'=>array('admin')),
);
?>

<h1>Create Comentario</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>