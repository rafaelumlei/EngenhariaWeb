<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('nr')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->nr), array('view', 'id'=>$data->nr)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('titulo')); ?>:</b>
	<?php echo CHtml::encode($data->titulo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('dtenvio')); ?>:</b>
	<?php echo CHtml::encode($data->dtenvio); ?>
	<br />


</div>