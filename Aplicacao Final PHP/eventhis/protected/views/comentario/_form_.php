<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'comentario-form',
	'enableAjaxValidation'=>false,
        'action'=>array('comentario/create')
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>
	<div class="row">
		<?php echo $form->labelEx($model,'texto'); ?>
		<?php echo $form->textArea($model,'texto',
                        array(
                            'size'=>60,
                            'maxlength'=>255,
                            'cols'=> 30,
                            'rows'=> 7
                            )
                      ); 
                ?>
		<?php echo $form->error($model,'texto'); ?>
                <?php
                        /**
                         *  Valores escondidos que podem ser uteis. 
                         *  Para já estes valores não estão a ser usados. 
                         */
                        echo CHtml::hiddenField('Comentario[evento_idevento]',$idevento,array('id'=>'idevento'));
                        echo CHtml::hiddenField('Comentario[utilizador_oid]',$iduser,array('id'=>'iduser'));
                ?>                
	</div>
	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>
</div>