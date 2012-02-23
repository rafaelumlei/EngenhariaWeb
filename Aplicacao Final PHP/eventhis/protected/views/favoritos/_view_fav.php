<div class="view">
        <span>
                <b>
                <?php
                        echo CHtml::link($data->titulo,
                                         array('//pagevento/index','id'=>$data->idevento)
                                        ); 
                ?> 
                </b>
        <?php 
                echo CHtml::link(       CHtml::image(
                                                      '.\./images/star_full.png',
                                                      'Desmarcar Favorito',
                                                      array('width'=>'20px','height'=>'20px')),
                                        array('//favoritos/delete','idevento'=>$data->idevento)
                                );
                
        ?>
        </span>
</div>