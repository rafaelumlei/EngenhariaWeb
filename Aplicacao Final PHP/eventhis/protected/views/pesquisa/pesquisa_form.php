<?php Yii::app()->clientScript->registerCoreScript('jquery'); ?>

<?php $form=$this->beginWidget('CActiveForm',
        array('id'=>'pesquisa-form',
              'enableAjaxValidation'=>false,
)); ?>

<?php echo $form->errorSummary($model); ?>

<?php echo $form->labelEx($model,'texto'); ?>

<?php 
        $identificador = 'res';
        echo CHtml::activeTextField($model,'texto',
                                    array('id'=>'texto')
                                   ); ?>

<?php echo $form->labelEx($model,'tipo'); ?>

<?php echo $form->error($model,'tipo'); ?>

<?php
        echo CHtml::activeDropDownList(
                                 $model,'tipo',
                                 Tipo::getTiposPesquisa(),
                                 array('id' => 'tipos',)
                                );
?>
<?php echo $form->error($model,'tipo'); ?>
<hr style="width:100%;"></hr>
<div id="<?php echo $identificador; ?>"></div>
<hr style="width:100%;"></hr>
<?php $this->endWidget(); ?>
<script type="text/javascript">
$('#tipos').change(actualizaPesquisa);
$('#texto').keypress(actualizaPesquisa);

function actualizaPesquisa()
{
        var url = '<?php echo $this->createUrl('pesquisar');?>';
        url += '&texto='+$('#texto').val();
        url += '&tipo='+$('#tipos').val();
        $.ajax({
                url : url,
                type : 'GET',
                success : function(data){
                        $('#<?php echo $identificador; ?>').html(data);
                }
        });
}
</script>