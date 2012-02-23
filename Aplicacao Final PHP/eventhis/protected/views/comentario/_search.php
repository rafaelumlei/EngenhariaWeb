<div class="wide form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model,'idcomentario'); ?>
		<?php echo $form->textField($model,'idcomentario'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'titulo'); ?>
		<?php echo $form->textField($model,'titulo',array('size'=>60,'maxlength'=>255)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'texto'); ?>
		<?php echo $form->textField($model,'texto',array('size'=>60,'maxlength'=>255)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'dtcom'); ?>
		<?php echo $form->textField($model,'dtcom'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'utilizador_oid'); ?>
		<?php echo $form->textField($model,'utilizador_oid'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'evento_idevento'); ?>
		<?php echo $form->textField($model,'evento_idevento'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton('Search'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->