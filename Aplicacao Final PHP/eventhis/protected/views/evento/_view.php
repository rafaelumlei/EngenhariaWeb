<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('idevento')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idevento), array('view', 'id'=>$data->idevento)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('dtfim')); ?>:</b>
	<?php echo CHtml::encode($data->dtfim); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('dtinicio')); ?>:</b>
	<?php echo CHtml::encode($data->dtinicio); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('titulo')); ?>:</b>
	<?php echo CHtml::encode($data->titulo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('descricao')); ?>:</b>
	<?php echo CHtml::encode($data->descricao); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('lat')); ?>:</b>
	<?php echo CHtml::encode($data->lat); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('lon')); ?>:</b>
	<?php echo CHtml::encode($data->lon); ?>
	<br />



</div>