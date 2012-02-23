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
        <b>Seleccione a localização do Evento:</b>
        <div style="height : 360px;width: 100%">
                <div class="row">
                        <?php 
                        $idMap = "map_canvas";
                        $map = "map";
                        $functionInit = 'toInit';
                        $this->renderPartial('//utils/googlemap',
                                                   array(
                                                            'width'=>'80%',
                                                            'height'=>'360px',
                                                            'id'=>$idMap,
                                                            'varnamemap'=>$map,
                                                            'functioncall'=>$functionInit
                                                   )); 
                        ?>
                </div>
        </div>     
        <?php echo $form->hiddenField($model,'lat'); ?>
        <?php echo $form->hiddenField($model,'lon'); ?>
        <script type="text/javascript">
                function <?php echo $functionInit; ?>(){
                        <?php if(!isset($model->idevento)){ ?>
                                var center = map.getCenter();
                                $('#Evento_lat').val(center.lat());
                                $('#Evento_lon').val(center.lng());
                        <?php } else { ?>
                                var center = new google.maps.LatLng(
                                                                      $('#Evento_lat').val(),
                                                                      $('#Evento_lon').val()
                                                                     );
                                <?php echo $map; ?>.setCenter(center);
                        <?php } ?>
                        marca = new google.maps.Marker({
                                position: center, 
                                map: <?php echo $map; ?>,
                                title: "Local",
                                icon: "http://dl.dropbox.com/u/42818496/tipos/1.png" 
                        });
                        marca.setDraggable(true);	
                        google.maps.event.addListener(marca,'dragend',
                                                              function(){
                                                                      cen = <?php echo $map; ?>.getCenter();
                                                                      $('#Evento_lat').val(cen.lat());
                                                                      $('#Evento_lon').val(cen.lng());
                                                              }
                        );      
                }
        </script>
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