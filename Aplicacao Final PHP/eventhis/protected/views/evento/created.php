<h1>Eventos</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$eventosUtilizador,
	'itemView'=>'_view_created',
)); ?>

