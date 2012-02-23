<?php
$this->breadcrumbs=array(
	'Tipos'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List Tipo', 'url'=>array('index')),
	array('label'=>'Manage Tipo', 'url'=>array('admin')),
);
?>

<h1>Create Tipo</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>