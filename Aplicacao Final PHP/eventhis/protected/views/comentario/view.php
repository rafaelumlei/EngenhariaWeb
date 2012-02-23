<?php
$this->breadcrumbs=array(
	'Comentarios'=>array('index'),
	$model->idcomentario,
);

$this->menu=array(
	array('label'=>'List Comentario', 'url'=>array('index')),
	array('label'=>'Create Comentario', 'url'=>array('create')),
	array('label'=>'Update Comentario', 'url'=>array('update', 'id'=>$model->idcomentario)),
	array('label'=>'Delete Comentario', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->idcomentario),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Comentario', 'url'=>array('admin')),
);
?>

<h1>View Comentario #<?php echo $model->idcomentario; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'idcomentario',
		'texto',
		'dtcom',
		'utilizador_oid',
		'evento_idevento',
	),
)); ?>
