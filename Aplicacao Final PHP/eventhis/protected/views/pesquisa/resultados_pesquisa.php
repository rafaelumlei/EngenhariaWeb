<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'evento-grid',
	'dataProvider'=>$data,
	'columns'=>array(
                        array(
                            'name'=>'Título',
                            'type' => 'raw',
                            'value' => 'CHtml::link(CHtml::encode($data->titulo),"'.$this->createUrl("//pagevento/index").'&id=$data->idevento")'
                        ), 
                        array(
                            'name' => 'Morada',
                            'value' => 'CHtml::encode(UtilGeocode::getMorada($data->lat,$data->lon))',
                        ),            
                        array(
                            'name' => 'Início',
                            'value' => 'CHtml::encode($data->dtinicio)',
                        ),            
                        array('name' => 'Fim',
                              'value' => 'CHtml::encode($data->dtfim)',
                        ),
                   ),
));
?>



