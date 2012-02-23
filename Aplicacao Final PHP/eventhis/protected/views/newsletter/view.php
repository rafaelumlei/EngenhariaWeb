<?php
$this->breadcrumbs=array(
	'Newsletters'=>array('index'),
	$model->nr,
);

$this->menu=array(
	array('label'=>'List Newsletter', 'url'=>array('index')),
	array('label'=>'Create Newsletter', 'url'=>array('create')),
	array('label'=>'Update Newsletter', 'url'=>array('update', 'id'=>$model->nr)),
	array('label'=>'Delete Newsletter', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->nr),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Newsletter', 'url'=>array('admin')),
);
?>

<h1>View Newsletter #<?php echo $model->nr; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'nr',
		'titulo',
		'dtenvio',
	),
)); ?>
