<?php
if(!isset ($width)) $width = 350;
if(!isset ($height)) $height = 200;
if(!isset ($zoom)) $zoom = 10;
$src = 'http://maps.googleapis.com/maps/api/staticmap?center='.$latitude.','.
        $longitude.'&zoom='.$zoom.'&size='.$width.'x'.$height;
if( isset($linkMarca) )
{
        $src .= '&markers=icon:'.$linkMarca.'%7C'.$latitude.','.$longitude;
}
$src .= '&sensor=false';
echo CHtml::image($src);
?> 


