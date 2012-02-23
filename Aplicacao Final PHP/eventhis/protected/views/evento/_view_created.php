<div class="view">
	<b><?php echo CHtml::encode($data->getAttributeLabel('titulo')); ?>:</b>
	<?php echo CHtml::encode($data->titulo); ?>
	<br />
	<b><?php echo CHtml::encode($data->getAttributeLabel('descricao')); ?>:</b>
	<?php echo CHtml::encode($data->descricao); ?>
	<br />        
	<b><?php echo CHtml::encode($data->getAttributeLabel('dtinicio')); ?>:</b>
	<?php echo CHtml::encode($data->dtinicio); ?>
	<br />
	<b><?php echo CHtml::encode($data->getAttributeLabel('dtfim')); ?>:</b>
	<?php echo CHtml::encode($data->dtfim); ?>
	<br />  
        <b>Localização: </b><br />
        <div style="display: block;margin-left: auto;margin-right: auto;">
                <table>
                        <tr>
                                <td style="width: 50%"></td>
                                <td>
                                        <?php $this->renderPartial('//utils/imgmap',
                                                array('latitude'=>$data->lat,
                                                      'longitude'=>$data->lon,
                                                      'zoom'=>14,
                                                      'linkMarca'=>Tipo::linkImgTipo($data->tipo_idtipo))
                                          );
                                        ?>
                                </td>
                                <td style="width: 50%"></td>
                        </tr>
                </table>
        </div>
        <?php 
                echo CHtml::link('Página do Evento',
                                 array('//pagevento/index&id='.$data->idevento)
                     );
        ?>
</div>