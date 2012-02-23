<!-- Evento --> 
<h1>Evento 
<?php 
        if($criador)
        {
                $this->menu=array(
                        array('label'=>'Alterar Evento', 
                              'url'=>array('//evento/update&id='.$evento->idevento)),
                        array('label'=>'Apagar Evento', 
                              'url'=>array('//evento/delete&id='.$evento->idevento)),
                );
        }
        echo $evento->titulo; 
        if(!Yii::app()->user->isGuest){
?>        
        <span id="fav">
                <?php
                $src = null;
                if($favorito)
                {
                        $src = ".\./images/star_full.png";
                }
                else {
                        $src = ".\./images/star_empty.png";
                }
                echo CHtml::ajaxLink(CHtml::image($src,'',array('id'=>'imgfav')),
                                  array('mudaFavorito'),
                                  array(
                                      'type'=>'GET',
                                      'update'=>'#fav',
                                      'data'=>'idevento='.$evento->idevento.
                                            '&iduser='.$utilizador->oid,
                                      'success'=>
                                              "js:function(data){
                                                      $('#imgfav').attr('src',data);
                                              }"
                                  ),
                        array('id'=>'ajaxfav')
                        );                
                ?>
        </span>
        <?php } ?>        
</h1>
<?php $this->widget('zii.widgets.CDetailView', 
                array(
                    'data'=>$evento,
                    'attributes'=>array(
                                        'titulo',
                                        'descricao',
                                        'lat',
                                        'lon',
                                        'dtfim',
                                        'dtinicio',
                                        'nomeTipo',
                                        'Morada'
                                )
                    )
        ); 
?>
<table>
        <tr>
                <td style="width: 50%"> </td>
                <td>
                        <?php
                                $this->renderPartial('//utils/imgmap',
                                                     array('latitude'=>$evento->lat,
                                                           'longitude'=>$evento->lon,
                                                           'linkMarca'=>Tipo::linkImgTipo($evento->utilizador_oid)
                                                         )
                                        );
                        ?>
                </td>
                <td style="width: 50%"> </td>
        </tr>
</table>        
<h1>Comentários</h1>
<?php
$this->widget('zii.widgets.CListView',
              array(
                  'dataProvider'=>$comentarios,
                  'itemView'=>'//comentario/view'
              )
);
?>
<br />
<?php
        if( !Yii::app()->user->isGuest )
        {
                $mod = Comentario::model();
                $mod->isNewRecord = true;
                echo $this->renderPartial('_form_comment',
                                           array(
                                               'model'=>$mod,
                                               'idevento'=>$evento->idevento,
                                               'iduser'=>$utilizador->oid
                                           )
                );
        }
?>
<br />