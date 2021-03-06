<?php

namespace App\Entity;

use \Illuminate\Pagination\LengthAwarePaginator as Paginator;
use App\Models\ProfesoresHasHorario as mProfesoresHasHorario;
use Jenssegers\Date\Date as Carbon;

class ProfesoresHasHorario extends \App\Entity\Base\Entity {

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

    static function getProfesorHorario($idHorario){
        $model=new mProfesoresHasHorario();
        $profesor=$model->getProfesorHorario($idHorario)->first();
        if($profesor!=NULL) return $profesor->NOMBRES_COMPLETOS;
        else return NULL;
    }

    
}