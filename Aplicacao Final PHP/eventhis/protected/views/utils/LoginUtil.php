
<?php Yii::app()->clientScript->registerCoreScript('jquery');
if(Yii::app()->user->isGuest){ ?>
<div class="form" style="float: right;">
        <?php
        $form=$this->beginWidget('CActiveForm', array(
                'id'=>'login-form',
                'enableClientValidation'=>false,
                'clientOptions'=>array(
                        'validateOnSubmit'=>false,
                ),
                'action'=>array($action)
        )); ?>
        <div >
                <?php echo $form->textField($model,'username',array(
                                                                    'text'=>'Username',
                                                                    'value'=>'Username',
                                                                    'onfocus'=>'
                                                                    if( $("#LoginForm_username").val() == "Username" )
                                                                    {
                                                                        $("#LoginForm_username").val("");
                                                                        $("#LoginForm_password").val("");
                                                                    }'
                                                                    )
                                            ); 
                ?>
                <?php echo $form->error($model,'username'); ?>
        </div>
        <div>
                <?php echo $form->passwordField($model,'password',array(
                                                                        'text'=>'Password',
                                                                        'value'=>'Password',
                                                                    'onfocus'=>'
                                                                    if( $("#LoginForm_username").val() == "Username" )
                                                                    {
                                                                        $("#LoginForm_username").val("");
                                                                        $("#LoginForm_password").val("");
                                                                    }'                    
                                                                        )
                                               ); 
                ?>
                <?php echo $form->error($model,'password'); ?>
        </div>
        <div class="row rememberMe">
                <?php echo $form->checkBox($model,'rememberMe'); ?>
                <?php echo $form->label($model,'rememberMe'); ?>
                <?php echo $form->error($model,'rememberMe'); ?>
        </div>
        <span style="clear:both;display: inline;">
                <?php 
                        echo CHtml::imageButton('./images/login.png',
                                                array('//site/login')
                             );
                ?>
                <?php 
                        echo CHtml::imageButton(
                                './images/signup.png',
                                //array('onclick' => 'window.location="'.$this->createUrl('//utilizador/create').'"')
                                array('id'=>'signup','onclick'=>'
                        $("#login-form").attr("action", "'.$this->createUrl("//utilizador/create").'");
                        $("#LoginForm_username").val("");
                        $("#LoginForm_password").val("");     
                        window.location="'.$this->createUrl("//utilizador/create").'"')
                            );
                ?>
        </span>                                        
        <?php $this->endWidget(); ?>                                       
</div>  
<?php } else { ?>
<div style="float:right;"><b> Bem vindo <?php echo Yii::app()->user->name; ?>! </b> 
 <?php 
        echo '<br />';
        echo CHtml::imageButton(
                                Utilizador::getFotoUrlByUsername(Yii::app()->user->name),
                                                                array(
                                                                        'width'=>65,
                                                                        'height'=>65
                                                                )
              );
        echo '<br/>';
        echo CHtml::link('Logout',array('//site/logout'));
?>     
</div>
<?php } ?>
<script type="text/javascript">
        function focus(){
                if( $("#LoginForm_username").val() == "Username" )
                {
                        $("#LoginForm_username").val("");
                        $('#LoginForm_password').val("");
                }
        }
        
        function signup()
        {
                if( $("#LoginForm_username").val() == 'Username' ){
                        $("#LoginForm_username").val('');
                        $('#LoginForm_password').val('');     
                        window.location = "<?php echo $this->createUrl('//utilizador/create'); ?>";
                }
        }
</script>