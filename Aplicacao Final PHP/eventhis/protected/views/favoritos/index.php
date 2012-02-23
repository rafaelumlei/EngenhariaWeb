<h2>Eventos Favoritos</h2>
<?php
$this->widget('zii.widgets.CListView',
              array(
                  'dataProvider'=>$data,
                  'itemView'=>'_view_fav'
              )
);
?>