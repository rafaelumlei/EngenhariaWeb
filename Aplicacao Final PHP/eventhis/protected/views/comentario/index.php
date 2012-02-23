<?php
$this->breadcrumbs=array(
	'Comentarios',
);

$this->menu=array(
	array('label'=>'Create Comentario', 'url'=>array('create')),
	array('label'=>'Manage Comentario', 'url'=>array('admin')),
);
?>

<h1>Comentarios</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
