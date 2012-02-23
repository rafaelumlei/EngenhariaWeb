<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'evento-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>
        
	<div class="row">
		<?php echo $form->labelEx($model,'titulo'); ?>
		<?php echo $form->textField($model,'titulo',array('size'=>50,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'titulo'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'descricao'); ?>
		<?php echo $form->textArea(     
                                                $model,'descricao',
                                                array('size'=>60,'maxlength'=>255,'cols'=>40,'rows'=>8)
                                           ); 
                ?>
		<?php echo $form->error($model,'descricao'); ?>
	</div>        

	<div class="row">
                
		<?php echo $form->labelEx($model,'dtfim'); ?>
                <?php $this->widget('application.widgets.timepicker.timepicker',
                                    array(
                                        'model'=>$model,
                                        'name'=>'dtfim',
                                    ));
                ?>
		<?php echo $form->error($model,'dtfim'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'dtinicio'); ?>
                <?php $this->widget('application.widgets.timepicker.timepicker',
                                    array(
                                        'model'=>$model,
                                        'name'=>'dtinicio',
                                    ));
                ?>
		<?php echo $form->error($model,'dtinicio'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'lat'); ?>
		<?php echo $form->textField($model,'lat'); ?>
		<?php echo $form->error($model,'lat'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'lon'); ?>
		<?php echo $form->textField($model,'lon'); ?>
		<?php echo $form->error($model,'lon'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'proxnewsletter'); ?>
		<?php echo $form->checkBox($model,'proxnewsletter',array()); ?>
		<?php echo $form->error($model,'proxnewsletter'); ?>
	</div>
        <!-- aqui meter os tipos depois -->
	<div class="row">
		<?php echo $form->labelEx($model,'tipo_idtipo'); ?>
		<?php
                        echo $form->dropDownList(
                                                 $model,'tipo_idtipo',
                                                 Tipo::getTipos()
                                                )
                ?>
		<?php echo $form->error($model,'tipo_idtipo'); ?>
        </div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>
        
</div><!-- form -->