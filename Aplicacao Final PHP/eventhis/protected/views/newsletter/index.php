<h1>Newsletters</h1>

<b><p>Eventos Para Newsletter</p></b>
<?php $this->widget('zii.widgets.grid.CGridView', array(
	'dataProvider'=>$data,
	'columns'=>array(
            'titulo',
            'dtinicio',
            'dtfim'
        )
)); ?>

<?php

$this->renderPartial('_form',array('model'=>  Newsletter::model()));

?>
