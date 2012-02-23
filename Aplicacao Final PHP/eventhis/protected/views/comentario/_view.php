<div class="view">
	<b><?php echo CHtml::encode($data->getAttributeLabel('idcomentario')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idcomentario), array('view', 'id'=>$data->idcomentario)); ?>
	<br />
	<b><?php echo CHtml::encode($data->getAttributeLabel('titulo')); ?>:</b>
	<?php echo CHtml::encode($data->titulo); ?>
	<br />
	<b><?php echo CHtml::encode($data->getAttributeLabel('texto')); ?>:</b>
	<?php echo CHtml::encode($data->texto); ?>
	<br />
	<b><?php echo CHtml::encode($data->getAttributeLabel('dtcom')); ?>:</b>
	<?php echo CHtml::encode($data->dtcom); ?>
	<br />
	<b><?php echo CHtml::encode($data->getAttributeLabel('utilizador_oid')); ?>:</b>
	<?php echo CHtml::encode($data->utilizador_oid); ?>
	<br />
	<b><?php echo CHtml::encode($data->getAttributeLabel('evento_idevento')); ?>:</b>
	<?php echo CHtml::encode($data->evento_idevento); ?>
	<br />
</div>