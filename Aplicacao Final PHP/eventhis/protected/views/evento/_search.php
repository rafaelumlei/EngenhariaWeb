<div class="wide form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model,'idevento'); ?>
		<?php echo $form->textField($model,'idevento'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'dtfim'); ?>
		<?php echo $form->textField($model,'dtfim'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'dtinicio'); ?>
		<?php echo $form->textField($model,'dtinicio'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'titulo'); ?>
		<?php echo $form->textField($model,'titulo',array('size'=>60,'maxlength'=>255)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'descricao'); ?>
		<?php echo $form->textField($model,'descricao',array('size'=>60,'maxlength'=>255)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'lat'); ?>
		<?php echo $form->textField($model,'lat'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'lon'); ?>
		<?php echo $form->textField($model,'lon'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'proxnewsletter'); ?>
		<?php echo $form->textField($model,'proxnewsletter'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'tipo_idtipo'); ?>
		<?php echo $form->textField($model,'tipo_idtipo'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'utilizador_oid'); ?>
		<?php echo $form->textField($model,'utilizador_oid'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton('Search'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->