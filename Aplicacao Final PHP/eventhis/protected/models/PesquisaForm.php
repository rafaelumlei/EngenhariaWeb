<?php

class PesquisaForm extends CFormModel
{
        public $texto;
        public $tipo;
        
	public function rules()
	{
		return array(
			array('texto', 'required'),
		);
	}
        
	public function attributeLabels()
	{
		return array(
			'texto'=>'Texto',
                        'tipo'=>'Tipo'
		);
	}        
        
}

?>
