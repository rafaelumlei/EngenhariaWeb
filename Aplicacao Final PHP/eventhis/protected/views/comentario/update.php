<?php
$this->breadcrumbs=array(
	'Comentarios'=>array('index'),
	$model->idcomentario=>array('view','id'=>$model->idcomentario),
	'Update',
);

$this->menu=array(
	array('label'=>'List Comentario', 'url'=>array('index')),
	array('label'=>'Create Comentario', 'url'=>array('create')),
	array('label'=>'View Comentario', 'url'=>array('view', 'id'=>$model->idcomentario)),
	array('label'=>'Manage Comentario', 'url'=>array('admin')),
);
?>

<h1>Update Comentario <?php echo $model->idcomentario; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>