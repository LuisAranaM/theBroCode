<?php

/**
 * Created by Reliese Model.
 * Date: Sun, 30 Sep 2018 22:12:14 +0000.
 */

namespace App\Models;

use Reliese\Database\Eloquent\Model as Eloquent;
use DB;
use Log;
use Jenssegers\Date\Date as Carbon;


/**
 * Class So
 * 
 * @property int $ID_SOS
 * @property int $ID_ESPECIALIDAD
 * @property int $ID_SEMESTRE
 * @property string $DESCRIPCION
 * @property \Carbon\Carbon $FECHA_REGISTRO
 * @property \Carbon\Carbon $FECHA_ACTUALIZACION
 * @property int $USUARIO_MODIF
 * @property int $ESTADO
 * 
 * @property \App\Models\Especialidade $especialidade
 * @property \App\Models\Semestre $semestre
 * @property \Illuminate\Database\Eloquent\Collection $eos
 *
 * @package App\Models
 */
class Sos extends Eloquent
{
	public $timestamps = false;

	protected $casts = [
		'ID_ESPECIALIDAD' => 'int',
		'ID_SEMESTRE' => 'int',
		'USUARIO_MODIF' => 'int',
		'ESTADO' => 'int'
	];

	protected $dates = [
		'FECHA_REGISTRO',
		'FECHA_ACTUALIZACION'
	];

	protected $fillable = [
		'NOMBRE',
		'FECHA_REGISTRO',
		'FECHA_ACTUALIZACION',
		'USUARIO_MODIF',
		'ESTADO'
	];

	public function especialidad()
	{
		return $this->belongsTo(\App\Models\Especialidad::class, 'ID_ESPECIALIDAD');
	}

	public function semestre()
	{
		return $this->belongsTo(\App\Models\Semestre::class, 'ID_SEMESTRE');
	}

	public function eos()
	{
		return $this->belongsToMany(\App\Models\Eo::class, 'sos_has_eos', 'ID_SOS', 'ID_EOS')
		->withPivot('ID_ESPECIALIDAD', 'ID_SEMESTRE', 'FECHA_REGISTRO', 'FECHA_ACTUALIZACION', 'USUARIO_MODIF', 'ESTADO');
	}

	static function getObjetivosEstudiante($idSemestre,$idEspecialidad){
		$objetivosEstudiante = DB::table('SOS')
		->select()
		->where('ID_SEMESTRE','=',$idSemestre)
		->where('ID_ESPECIALIDAD','=',$idEspecialidad)
		->where('ESTADO','=',1);
		return $objetivosEstudiante;
	}

	static function getObjetivosTotales($idSem,$idEsp) {
		//dd($idSem);
		$sql = DB::table('SOS')
		->select('ID_SOS', 'NOMBRE')
		->where('ESTADO','=',1)
		->where('ID_SEMESTRE','=',$idSem)
		->where('ID_ESPECIALIDAD','=',$idEsp);

        //dd($sql->get());
		return $sql;

	}
	static function getinformacionObj($idSemestre,$idEspecialidad){
	
		$first = DB::table('SOS')
		->select('ID_SOS', 'NOMBRE',DB::Raw('1 AS TIPO'))
		->where('ESTADO','=',1)
		->where('ID_SEMESTRE','=',$idSemestre)
		->where('ID_ESPECIALIDAD','=',$idEspecialidad);
		
		$second= DB::table('EOS')
		->select('ID_EOS', 'NOMBRE',DB::Raw('0 AS TIPO'))
		->where('ESTADO','=',1)
		->where('ID_SEMESTRE','=',$idSemestre)
		->where('ID_ESPECIALIDAD','=',$idEspecialidad)
		->union($first)
		->get();
		
		return   $second;

	}

	function copiarObj($idSemestre,$idEspecialidad,$objetivos,$idUsuario){
		DB::beginTransaction();
		$status=true;
		$estado=1;

    	try {
			foreach ($objetivos as $obj) {
    			if($obj.TIPO==1){
					DB::table('SOS')
				->insert(['NOMBRE'=>$obj.NOMBRE,'ID_SEMESTRE'=>$idSemestre,'ID_ESPECIALIDAD'=>$idEspecialidad,'FECHA_REGISTRO'=>Carbon::now(),'FECHA_ACTUALIZACION'=>Carbon::now(),'USUARIO_MODIF'=>$idUsuario,'ESTADO'=>$estado]);
				}
				if($obj.TIPO==0){
					DB::table('EOS')
				->insert(['NOMBRE'=>$obj.NOMBRE,'ID_SEMESTRE'=>$idSemestre,'ID_ESPECIALIDAD'=>$idEspecialidad,'FECHA_REGISTRO'=>Carbon::now(),'FECHA_ACTUALIZACION'=>Carbon::now(),'USUARIO_MODIF'=>$idUsuario,'ESTADO'=>$estado]);
				}
				

			}

			DB::commit();
		} catch (\Exception $e) {
			dd($e->getMessage());
			$status=false;
			Log::error('BASE_DE_DATOS|' . $e->getMessage());
			DB::rollback();
		}	

		return $status;
	}

	function eliminarSos($registro){
        //dd($registro);    
		DB::beginTransaction();
		$status = true;

		try {
			DB::table('SOS')
			->where('ID_SOS','=',$registro['ID_SOS'])
			->where('NOMBRE','=',$registro['NOMBRESOS'])
			->where('ID_SEMESTRE','=',$registro['ID_SEMESTRE'])
			->where('ID_ESPECIALIDAD','=',$registro['ID_ESPECIALIDAD'])
			->update(['ESTADO'=>0,'FECHA_ACTUALIZACION'=>$registro['FECHA_ACTUALIZACION']]);

			DB::commit();
		} catch (\Exception $e) {
			Log::error('BASE_DE_DATOS|' . $e->getMessage());
			$status = false;
			DB::rollback();
		}
    	return $status;
        
	}

	
	function editarSos($registro){
        DB::beginTransaction();
		$status = true;
		
		try {
			DB::table('SOS')
			->where('ID_SOS','=',$registro['ID_SOS'])
			->where('ID_SEMESTRE','=',$registro['ID_SEMESTRE'])
			->where('ID_ESPECIALIDAD','=',$registro['ID_ESPECIALIDAD'])
			->update(['NOMBRE'=>$registro['NOMBRE'],'FECHA_ACTUALIZACION'=>$registro['FECHA_ACTUALIZACION']]);

			DB::commit();
		} catch (\Exception $e) {
			Log::error('BASE_DE_DATOS|' . $e->getMessage());
			$status = false;
			DB::rollback();
		}
        
        return $status;
        
	}

	function agregarSos($registro){
        //dd($registro);    
		DB::beginTransaction();
		$status = true;

		try {
			DB::table('SOS')
			->insert(['NOMBRE'=>$registro['NOMBRESOS'],'ID_SEMESTRE'=>$registro['ID_SEMESTRE'],'ID_ESPECIALIDAD'=>$registro['ID_ESPECIALIDAD'],'FECHA_REGISTRO'=>$registro['FECHA_REGISTRO'],'FECHA_ACTUALIZACION'=>$registro['FECHA_ACTUALIZACION'],'USUARIO_MODIF'=>$registro['USUARIO_MODIF'],'ESTADO'=>$registro['ESTADO']]);

			DB::commit();
		} catch (\Exception $e) {
			Log::error('BASE_DE_DATOS|' . $e->getMessage());
			$status = false;
			DB::rollback();
		}
    	return $status;
    }

}
