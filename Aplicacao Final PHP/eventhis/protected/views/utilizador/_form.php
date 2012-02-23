<div class="form">
        <?php $form=$this->beginWidget('CActiveForm', array(
                'id'=>'utilizador-form',
                'enableAjaxValidation'=>false,
                'htmlOptions'=>array('enctype'=>'multipart/form-data'),
        )); ?>
	<p class="note">Fields with <span class="required">*</span> are required.</p>
	<?php echo $form->errorSummary($model); ?>
	<div class="row">
		<?php echo $form->labelEx($model,'email'); ?>
		<?php echo $form->textField($model,'email',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'email'); ?>
	</div>
	<div class="row">
		<?php echo $form->labelEx($model,'password'); ?>
		<?php echo $form->passwordField($model,'password',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'password'); ?>
	</div>
	<div class="row">
		<?php echo $form->labelEx($model,'nome'); ?>
		<?php echo $form->textField($model,'nome',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'nome'); ?>
	</div>
        <?php echo $form->hiddenField($model,'lat'); ?>
        <?php echo $form->hiddenField($model,'lon'); ?>
        <?php echo $form->hiddenField($model,'lat2'); ?>
        <?php echo $form->hiddenField($model,'lon2'); ?>
        <b>Seleccione a sua àrea de interesse:</b>
        <div style="height : 360px;width: 100%">
                <div class="row">
                        <?php 
                        $idMap = "map_canvas";
                        $map = "map";
                        $funcao = "acertarFronteiras";
                        $this->renderPartial('//utils/googlemap',
                                                   array(
                                                            'width'=>'80%',
                                                            'height'=>'360px',
                                                            'id'=>$idMap,
                                                            'varnamemap'=>$map,
                                                            'events'=>array(
                                                                array('bounds_changed','changeFronteiras'),
                                                            ),
                                                            'functioncall'=>$funcao
                                                   )); 
                        ?>
                </div>
        </div>          
        <script type="text/javascript" >
                
        function <?php echo $funcao; ?>()
        {
                <?php if(isset($model->oid)){?>
                        var sw = new google.maps.LatLng(<?php echo $model->lat;?>,
                                                        <?php echo $model->lon; ?>);
                        var ne = new google.maps.LatLng(<?php echo $model->lat2;?>,
                                                        <?php echo $model->lon2; ?>);
                        var bounds = new google.maps.LatLngBounds(sw,ne);
                        map.fitBounds(bounds);
                <?php } ?>            
        }     
        
                function changeFronteiras()
                {
                        var ne = <?php echo $map; ?>.getBounds().getNorthEast();
                        var sw = <?php echo $map; ?>.getBounds().getSouthWest();
                        var lat1 = sw.lat();
                        var lat2 = ne.lat();
                        var lon1 = sw.lng();
                        var lon2 = ne.lng();
                        $('#Utilizador_lat').val(lat1);
                        $('#Utilizador_lon').val(lon1);
                        $('#Utilizador_lat2').val(lat2);
                        $('#Utilizador_lon2').val(lon2);                        
                }
        </script>
        <div class="row" >
		<?php echo $form->labelEx($model,'username'); ?>
		<?php echo $form->textField($model,'username',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'username'); ?>
	</div>
	<div class="row">
                <?php echo $form->label($model,'imagem')  ?>
		<?php echo CHtml::activeFileField($model,'imagem'); ?>
	</div>
	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>
        <?php $this->endWidget(); ?>
</div><!-- form -->