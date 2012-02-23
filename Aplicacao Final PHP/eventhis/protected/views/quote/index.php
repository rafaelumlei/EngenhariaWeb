<h2>Citações do Dia</h2>
<div id="citacoes">
        <?php $this->renderPartial('_quote',array('quote'=>$quote)); ?>
</div>
<?php echo CHtml::ajaxLink('Actualizar Citação',
                        array('getQuote'),
                        array('update'=>'#citacoes')
             ); 
?>