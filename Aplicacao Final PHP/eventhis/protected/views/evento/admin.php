<?php
$this->breadcrumbs=array(
	'Eventos'=>array('index'),
	'Manage',
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('evento-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Gestão de Eventos</h1>

<p>
Podem ser usados operadores de comparação no início do valor de uma pesquisa 
(<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>).
</p>


<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'evento-grid',
	'dataProvider'=>$model->searchAdmin(),
	'filter'=>$model,
	'columns'=>array(
		'idevento',
		'dtfim',
		'dtinicio',
		'titulo',
		'descricao',
		'lat',
		/*
		'lon',
		'proxnewsletter',
		'tipo_idtipo',
		'utilizador_oid',
		*/
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
