<?php
        
Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('utilizador-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Gerir Utilizadores</h1>

<p>
Podem ser usados operadores de comparação no início do valor de uma pesquisa 
(<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>).
</p>

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'utilizador-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
                'username',
		'oid',
		'email',
		'nome',
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
