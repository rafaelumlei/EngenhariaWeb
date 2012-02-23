<?php
$this->breadcrumbs=array(
	'Tipos'=>array('index'),
	$model->idtipo,
);

$this->menu=array(
	array('label'=>'List Tipo', 'url'=>array('index')),
	array('label'=>'Create Tipo', 'url'=>array('create')),
	array('label'=>'Update Tipo', 'url'=>array('update', 'id'=>$model->idtipo)),
	array('label'=>'Delete Tipo', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->idtipo),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Tipo', 'url'=>array('admin')),
);
?>

<h1>View Tipo #<?php echo $model->idtipo; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'idtipo',
		'nome',
	),
)); ?>
