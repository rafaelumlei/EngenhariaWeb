<?php
$this->breadcrumbs=array(
	'Newsletters'=>array('index'),
	$model->nr=>array('view','id'=>$model->nr),
	'Update',
);

$this->menu=array(
	array('label'=>'List Newsletter', 'url'=>array('index')),
	array('label'=>'Create Newsletter', 'url'=>array('create')),
	array('label'=>'View Newsletter', 'url'=>array('view', 'id'=>$model->nr)),
	array('label'=>'Manage Newsletter', 'url'=>array('admin')),
);
?>

<h1>Update Newsletter <?php echo $model->nr; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>