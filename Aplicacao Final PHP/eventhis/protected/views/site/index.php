<?php

if(!Yii::app()->user->isGuest)
{
        $utilizador = Utilizador::getUserByUsername(Yii::app()->user->name);
}
$idMap = "map_canvas";
$map = "map";
$funcao = 'acertarFronteiras';
$this->renderPartial('//utils/googlemap',
                array(
                    'width'=>'100%',
                    'height'=>'360px',
                    'id'=>$idMap,
                    'varnamemap'=>$map,
                    'events'=>array(
                        array('bounds_changed','changeFronteiras'),
                    ),
                    'functioncall'=>$funcao
                )
        );
?>
<script type="text/javascript">
        var marcas = {};
        function <?php echo $funcao; ?>()
        {
                <?php if(isset($utilizador)){?>
                        var sw = new google.maps.LatLng(<?php echo $utilizador->lat;?>,
                                                        <?php echo $utilizador->lon; ?>);
                        var ne = new google.maps.LatLng(<?php echo $utilizador->lat2;?>,
                                                        <?php echo $utilizador->lon2; ?>);
                        var bounds = new google.maps.LatLngBounds(sw,ne);
                        map.fitBounds(bounds);
                <?php } ?>            
        }     
        
        function changeFronteiras(){
                var ne = <?php echo $map; ?>.getBounds().getNorthEast();
                var sw = <?php echo $map; ?>.getBounds().getSouthWest();
                var lat1 = sw.lat();
                var lat2 = ne.lat();
                var lon1 = sw.lng();
                var lon2 = ne.lng();
                <?php 
                        echo 'var url ="'.$this->createUrl('//evento/eventos').'&'.
                                              'lat1="+lat1+"&lat2="+lat2'.
                                              '+"&lon1="+lon1+"&lon2="+lon2;';
                ?>
                var data;
                $.ajax({
                        url : url,
                        dataType : 'json',
                        cache : false,
                        success:  function(data){
                                inserirMarcas(data);
                        }
                });
        } 
        
        function inserirMarcas(eventos)
        {
                var evento;
                for(var i = 0 ; i < eventos.length ; i++ )
                {
                        evento = eventos[i];
                        if(!marcas[evento.idevento])
                        {
                                var id = evento.idevento;
                                var pos = new google.maps.LatLng(evento.lat,evento.lon);
                                console.log('http://dl.dropbox.com/u/42818496/tipos/'+evento.tipo_idtipo+".png");
				marcas[id] = new google.maps.Marker({
					position : pos, 
					map : map,
					title : evento.titulo,
					icon : 'http://dl.dropbox.com/u/42818496/tipos/'+evento.tipo_idtipo+".png",
					conteudo : '<a href="<?php echo $this->createUrl('//pagevento/index').'&id='; ?>'
                                                   + evento.idevento + '">' + evento.titulo + '</a>'
				});
				marcas[id].setDraggable(false);
				marcas[id].setClickable(true);
				marcas[id].info = new google.maps.InfoWindow();
				marcas[id].idev = id;
				google.maps.event.addListener(marcas[id],"click",function(mouse){
					marcas[id].info.setContent(this.conteudo);
					marcas[id].info.open(map,this);
				}); 
                                
                        }
                }
        }
</script>