<?php $this->beginContent('//layouts/main'); ?>
<div class="container">
	<div class="span-19">
		<div id="content">
			<?php echo $content; ?>
		</div><!-- content -->
	</div>
	<div class="span-5 last">
		<div id="sidebar">
		<?php
                        /*
                         * Começa o widget  
                         */
			$this->beginWidget('zii.widgets.CPortlet', array(
				'title'=>'Operations',
			));
                        /*
                         * Constoi o menu
                         */
			$this->widget('zii.widgets.CMenu', array(
				'items'=>$this->menu,
				'htmlOptions'=>array('class'=>'operations'),
			));
                        /*
                         * Termina o widget
                         */
			$this->endWidget();
		?>
		</div>
	</div>
</div>
<?php $this->endContent(); ?>