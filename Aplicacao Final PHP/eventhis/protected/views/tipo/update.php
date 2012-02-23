<?php
$this->breadcrumbs=array(
	'Tipos'=>array('index'),
	$model->idtipo=>array('view','id'=>$model->idtipo),
	'Update',
);

$this->menu=array(
	array('label'=>'List Tipo', 'url'=>array('index')),
	array('label'=>'Create Tipo', 'url'=>array('create')),
	array('label'=>'View Tipo', 'url'=>array('view', 'id'=>$model->idtipo)),
	array('label'=>'Manage Tipo', 'url'=>array('admin')),
);
?>

<h1>Update Tipo <?php echo $model->idtipo; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>