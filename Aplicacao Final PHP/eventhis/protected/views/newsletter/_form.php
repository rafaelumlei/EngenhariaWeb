<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'newsletter-form',
	'enableAjaxValidation'=>false,
)); ?>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'titulo'); ?>
		<?php echo $form->textField($model,'titulo',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'titulo'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton('Enviar Newsletter'); 
                ?>
	</div>

<?php $this->endWidget(); ?>

</div>