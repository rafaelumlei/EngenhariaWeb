<?php
class UtilGeocode 
{
        public static $geo = 
                'http://maps.googleapis.com/maps/api/geocode/json?latlng=%s,%s&sensor=false';
        
        public static function getMorada($lat,$lon)
        {
               $url = sprintf(self::$geo,$lat,$lon);
               $returned = file_get_contents($url);
               $json = CJSON::decode($returned);
               $resultados = $json['results'];
               if($resultados[0]['formatted_address'])
               {
                       return $resultados[0]['formatted_address'];
               } else {
                       return 'Não definida.';
               }
        }
               
}
?>