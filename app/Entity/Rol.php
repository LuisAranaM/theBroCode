<?php

namespace App\Entity;

use \Illuminate\Pagination\LengthAwarePaginator as Paginator;
use App\Models\Rol as mRol;
use Jenssegers\Date\Date as Carbon;

class Rol extends \App\Entity\Base\Entity {

	protected $_fechaRegistro;
    
    function setProperties($data) {
        $this->setValues([
            '_fechaRegistro' => $data->FECHA_REGISTRO,
        ]);
    }

    function setValueToTable() {
        return $this->cleanArray([
            'FECHA_REGISTRO' => $this->_fechaRegistro,
        ]);
    }

    static function getRolUsuario(){
        $model = new mRol();
        return $model->getRolUsuario(self::getUsuarioCompleto()->ID_ROL);
    }
    
    static function getRoles(){
        $model = new mRol();
        return $model->getRoles()->get();
    }
}