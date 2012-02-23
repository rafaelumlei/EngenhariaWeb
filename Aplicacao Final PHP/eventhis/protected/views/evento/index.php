<?php
$this->breadcrumbs=array(
	'Eventos',
);

$this->menu=array(
	array('label'=>'Create Evento', 'url'=>array('create')),
	array('label'=>'Manage Evento', 'url'=>array('admin')),
);
?>

<h1>Eventos</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
