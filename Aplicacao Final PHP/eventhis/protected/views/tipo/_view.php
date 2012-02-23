<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('idtipo')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idtipo), array('view', 'id'=>$data->idtipo)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nome')); ?>:</b>
	<?php echo CHtml::encode($data->nome); ?>
	<br />


</div>