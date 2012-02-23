<?php
Yii::app()->clientScript->registerScriptFile(
                            "http://maps.googleapis.com/maps/api/js?sensor=true"
                        );
Yii::app()->clientScript->registerCoreScript('jquery');
Yii::app()->clientScript->registerScript(
                                        'inializemap','$("body").onload = initialize()',
                                         CClientScript::POS_READY
                                        );
if( !isset ($float) ) 
        $float = 'left';
if( !isset ($id) ) 
        $id = 'map_canvas';
if( !isset ($width))
        $width = '400px';
if( !isset ($height))
        $height = '400px';
if( !isset ($lat))
        $lat ='41.13968';
if( !isset ($lon))
        $lon = '-8.559176';
if( !isset ($zoom))
        $zoom = '10';
if( !isset ($varnamemap))
        $varnamemap = 'map';
if( !isset ($events))
        $events = array();
echo '<div id="'.$id.'" style="width:'.$width.'; height:'.
     $height.'; text-align: center; float:'.$float.';"></div>';
?>
<script type="text/javascript">
// variável javascript que possibilitará o acesso ao mapa
var <?php echo $varnamemap;?>;
function initialize() {
        // inicialização do centro do mapa
        var latlng = new google.maps.LatLng(<?php echo $lat;?>,<?php echo $lon; ?>);
        // construção das opções iniciais do mapa
        var myOptions = {
                // zoom
                zoom: <?php echo $zoom; ?>,
                // centro
                center: latlng,
                // tipo de mapa
                mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        // inicialização do mapa usando a API da google
        <?php echo $varnamemap;?> = new google.maps.Map(
                                document.getElementById("<?php echo $id; ?>"),
                                myOptions
                                );
        // registo dos eventos que se pretendem registar e do nome da
        // função javascript que os vai tratar
        <?php foreach ($events as $event) {
                echo 'google.maps.event.addListener('.$varnamemap.',"'.$event[0]
                                                            .'",'.$event[1].');';
        } 
        // Opcional: quem incializar esta API pode definir um função javascript
        // que só deva ser chamada no final da inicialização do mapa
        if(isset($functioncall))
        {
                echo $functioncall.'();';
        }
        ?>
}
</script>