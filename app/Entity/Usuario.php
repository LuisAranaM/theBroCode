<?php

namespace App\Entity;

use App\Model\Usuario as mUsuario;
use \Illuminate\Pagination\LengthAwarePaginator as Paginator;
use DB;

class Usuario extends \App\Entity\Base\Entity {

    const ROL_ADMINISTRADOR = 1;
    const ROL_COORDINADOR = 2;
    const ROL_ASISTENTE = 3;
    const ROL_PROFESOR = 4;
        
    const ITEMS_PER_PAGE = 15;

    protected $_usuario;
    protected $_rol;
    protected $_nombres;
    protected $_apellidoPaterno;
    protected $_apellidoMaterno;
    protected $_correo;
    protected $_fechaRegistro;
    protected $_fechaActualizacion;
    protected $_usuarioModif;
    protected $_estado;

    public function setFromAuth($user) {
        $this->setValue('_usuario',$user->USUARIO);
        $this->setValue('_rol',$user->ID_ROL);
        $this->setValue('_nombres',$user->NOMBRES);
        $this->setValue('_apellidoPaterno',$user->APELLIDO_PATERNO);
        $this->setValue('_apellidoMaterno',$user->APELLIDO_MATERNO);
        $this->setValue('_correo',$user->CORREO);
        $this->setValue('_fechaRegistro',$user->FECHA_REGISTRO);
        $this->setValue('_fechaActualizacion',$user->FECHA_ACTUALIZACION);
        $this->setValue('_usuarioModif',$user->USUARIO_MODIF);
        $this->setValue('_estado',$user->ESTADO);        
    }   

    static function getUsuario($usuario){
        $model = new mUsuario();      
        return $model->getUsuario($usuario)->first();
    }
    /*
        PODEMOS GENERAR MÉTODOS PARA LISTAR A LOS PROFESORES EN GENERAL O POR ESPECIALIDAD
     */

    static function redirectRol($rol) {
        //dd($rol);
        $url1 = 'administrador.principal';
        $url2 = 'coordinador.principal';
        $url3 = 'asistente.principal';
        $url4 = 'profesor.principal';
        
        switch ($rol) {
            case self::ROL_ADMINISTRADOR:
                return $url1;
            case self::ROL_COORDINADOR:
                return $url2;
            case self::ROL_ASISTENTE:
                return $url3;
            case self::ROL_PROFESOR:
                return $url4;
            default:
                return 'prueba';
        }
    }
   
    static function getUsuarios() {
        return [
            self::ROL_ADMINISTRADOR,
            self::ROL_COORDINADOR,
            self::ROL_ASISTENTE,
            self::ROL_PROFESOR
        ];
    }   

    static function getCoordinadorAsistente() {
        return [self::ROL_COORDINADOR, self::ROL_ASISTENTE];
    }

    static function getEjecutivosProductoBE() {
        return [self::ROL_EJECUTIVO_PRODUCTO];
    }

    public function changePassword($usuario,$apassword,$npassword){

        $model = new mUsuario();
        if (!($model->verifyPassword($registro,$apassword))){
            $this->setMessage('La contraseña ingresada no coincide con la original');
            return false;
        }
        else{
            $model->updateNewPassword($registro,$npassword);
            $this->setMessage('La contraseña fue cambiada exitosamente');
            return true;
        }

    }

    static function updateMasive(){
        $model = new mUsuario();
        $model->updateMasive();
    }

}