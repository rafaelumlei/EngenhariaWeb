<?php $this->beginContent('//layouts/main'); ?>
<div>
<?php echo $content; ?>
</div>
<div class="sidebar tags" >
        <ul>
                <li><a href="#php">PHP</a></li>
                <li><a href="#yii">YII</a></li>
        </ul>
</div>
<div class="sidebar links">
        <ul>
                <li><a href="http://yiiframework.com/">Yiiframework</a></li> 
                <li><a href="http://php.net">PHP</a></li>
        </ul>  
</div>
<?php $this->endContent(); ?>