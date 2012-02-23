<?php
$this->breadcrumbs=array(
	'Utilizadores'=>array('index'),
	$model->oid,
);

$this->menu=array(
	array('label'=>'List Utilizador', 'url'=>array('index')),
	array('label'=>'Create Utilizador', 'url'=>array('create')),
	array('label'=>'Update Utilizador', 'url'=>array('update', 'id'=>$model->oid)),
	array('label'=>'Delete Utilizador', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->oid),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Utilizador', 'url'=>array('admin')),
);
?>

<h1>View Utilizador #<?php echo $model->oid; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'oid',
		'email',
		'password',
		'nome',
		'lat',
		'lon',
		'lat2',
		'lon2',
		'username', 
	),
)); ?>
