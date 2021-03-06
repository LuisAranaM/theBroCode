<?php

/**
 * Created by Reliese Model.
 * Date: Sun, 30 Sep 2018 22:12:14 +0000.
 */

namespace App\Models;
use DB;
use Log;
use Reliese\Database\Eloquent\Model as Eloquent;
use Jenssegers\Date\Date as Carbon;

/**
 * Class Especialidade
 * 
 * @property int $ID_ESPECIALIDAD
 * @property string $NOMBRE
 * @property \Carbon\Carbon $FECHA_REGISTRO
 * @property \Carbon\Carbon $FECHA_ACTUALIZACION
 * @property int $USUARIO_MODIF
 * @property int $ESTADO
 * 
 * @property \Illuminate\Database\Eloquent\Collection $actas
 * @property \Illuminate\Database\Eloquent\Collection $criterios
 * @property \Illuminate\Database\Eloquent\Collection $cursos
 * @property \Illuminate\Database\Eloquent\Collection $eos
 * @property \Illuminate\Database\Eloquent\Collection $especialidades_has_profesores
 * @property \Illuminate\Database\Eloquent\Collection $planes_de_mejoras
 * @property \Illuminate\Database\Eloquent\Collection $sos
 *
 * @package App\Models
 */
class Especialidad extends Eloquent
{
	protected $primaryKey = 'ID_ESPECIALIDAD';
	public $timestamps = false;

	protected $casts = [
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

	static function fix($cad){
		$cad = lcfirst($cad);
		return ucwords($cad);
	}

	static function getNombreEspecialidad($idEspecialidad){
		$ans = DB::table('ESPECIALIDADES')
				->where('ID_ESPECIALIDAD','=',$idEspecialidad)
				->get()
				->toArray();
		$cad = $ans[0]->NOMBRE;
		return Especialidad::fix($cad);
	}

	public function getEspecialidadUsuario($id_usuario)
	{	
		$sql=DB::table('USUARIOS AS US')
				->select('ES.ID_ESPECIALIDAD','ESPE.NOMBRE AS NOMBRE_ESPECIALIDAD')
				->leftJoin('USUARIOS_HAS_ESPECIALIDADES AS ES',function($join){
					$join->on('US.ID_USUARIO','=','ES.ID_USUARIO');
				})
				->leftJoin('ESPECIALIDADES AS ESPE',function($join){
					$join->on('ES.ID_ESPECIALIDAD','=','ESPE.ID_ESPECIALIDAD');
				})
				->where('US.ID_USUARIO','=',$id_usuario);
		return $sql->first();
	}

	static function getEspecialidadess()
	{	
		$sql=DB::table('ESPECIALIDADES')
				->select()
				->where('ESTADO','=',1)
				->get();
		return $sql;
	}

	public function getEspecialidades()
	{	
		$sql=DB::table('ESPECIALIDADES')
				->select('ID_ESPECIALIDAD','NOMBRE',DB::Raw("CONVERT(FECHA_REGISTRO,DATE) AS FECHA_REGISTRO"))
				->where('ESTADO','=',1)
				->orderBy('NOMBRE','ASC');
		return $sql;
	}	

	public function buscarEspecialidad($nombEspecialidad,$idEspecialidad=null)
	{	
		$sql=DB::table('ESPECIALIDADES')
				->select()
				->where('NOMBRE','=',$nombEspecialidad)
				->where('ESTADO','=',1);
		
		if($idEspecialidad)
			$sql=$sql->where('ID_ESPECIALIDAD','<>',$idEspecialidad);
		
		return $sql->count();
	}	

	public function crearEspecialidad($especialidad){
		DB::beginTransaction();
        $id=-1;
        try {
            $id = DB::table('ESPECIALIDADES')->insertGetId($especialidad);
			DB::commit();
        } catch (\Exception $e) {
            Log::error('BASE_DE_DATOS|' . $e->getMessage());
            DB::rollback();
        }
		return $id;
	}

	public function editarEspecialidad($especialidad){
		DB::beginTransaction();
        $id=1;
        try {
            DB::table('ESPECIALIDADES')
            ->where('ID_ESPECIALIDAD','=',$especialidad['ID_ESPECIALIDAD'])
            ->update([
            'NOMBRE'=> $especialidad['NOMBRE'] ,  
            'FECHA_ACTUALIZACION'=>$especialidad['FECHA_ACTUALIZACION'],
            'USUARIO_MODIF'=>$especialidad['USUARIO_MODIF']]);
			DB::commit();
        } catch (\Exception $e) {
            Log::error('BASE_DE_DATOS|' . $e->getMessage());
            DB::rollback();
        }
		return $id;
	}

	public function eliminarEspecialidad($idEspecialidad,$idUsuario){
		DB::beginTransaction();
        $id=1;
        try {
            DB::table('ESPECIALIDADES')
            ->where('ID_ESPECIALIDAD','=',$idEspecialidad)
            ->update([
            'ESTADO'=> 0,  
            'FECHA_ACTUALIZACION'=>Carbon::now(),
            'USUARIO_MODIF'=>$idUsuario]);
			DB::commit();
        } catch (\Exception $e) {
            Log::error('BASE_DE_DATOS|' . $e->getMessage());
            $id=0;
            DB::rollback();
        }
		return $id;
	}

	public function actas()
	{
		return $this->hasMany(\App\Models\Acta::class, 'ID_ESPECIALIDAD', 'id_especialidad');
	}

	public function criterios()
	{
		return $this->hasMany(\App\Models\Criterio::class, 'ID_ESPECIALIDAD', 'id_especialidad');
	}

	public function cursos()
	{
		return $this->hasMany(\App\Models\Curso::class, 'ID_ESPECIALIDAD', 'id_especialidad');
	}

	public function eos()
	{
		return $this->hasMany(\App\Models\Eos::class, 'ID_ESPECIALIDAD', 'id_especialidad');
	}

	public function usuarios_has_especialidades()
	{
		return $this->hasMany(\App\Models\UsuariosHasEspecialidades::class, 'ID_ESPECIALIDAD');
	}

	public function planes_de_mejoras()
	{
		return $this->hasMany(\App\Models\PlanesDeMejoras::class, 'ID_ESPECIALIDAD');
	}

	public function sos()
	{
		return $this->hasMany(\App\Models\Sos::class, 'ID_ESPECIALIDAD');
	}
}
