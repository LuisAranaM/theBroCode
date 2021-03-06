<?php

namespace App\Http\Controllers;
use App\Entity\PlanesDeMejora as PlanesDeMejora;
use App\Entity\Semestre;
use App\Entity\Acta as Acta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Input;
use App\Entity\Base\Entity;
use DB;
use response;



class ReunionesController extends Controller
{
    //

    public function reunionesGestion() {    
        return view('reuniones.reuniones')
        ->with('tipos',['Acta de Reunión','Plan de Mejora'])
        ->with('semestres',Semestre::getSemestres())
        ->with('documentos',PlanesDeMejora::buscarDocumentos());
    }
    function resultadosFiltroDocs(Request $request){

        return PlanesDeMejora::resultadosFiltroDocs($request->get('anhoInicio'),$request->get('semIni'),$request->get('anhoFin'),$request->get('semFin'),$request->get('tipo'));
        
    }
    public function store(Request $request){
        try{
            $tipoDoc = $request->get('tipoDoc', null); //ver si es acta o plan el value
            $ciclo = $request->get('ciclo', null);
            $semestre = explode( '-', $ciclo );
            $file = $request->file('archivo');
            if($file==null){
                flash('No ha seleccionado un archivo, inténtelo nuevamente')->error();
                return back();
            }
            $semestreActual = Entity::getIdSemestre();
            $especialidad = Entity::getEspecialidadUsuario();
            $usuario = Auth::user();
            $idUsuario = Auth::id();
            $nameOfFile = pathinfo(Input::file('archivo')->getClientOriginalName(), PATHINFO_FILENAME);
            $extensionOfFile = pathinfo(Input::file('archivo')->getClientOriginalName(), PATHINFO_EXTENSION);  //Get extension of file
            $file->storePubliclyAs('upload', $nameOfFile.'.'.$extensionOfFile, 'public');
            $path = base_path() . '\public\upload' . '\\' . $nameOfFile.'.'.$extensionOfFile ;
            $fecha = date("Y-m-d H:i:s");

            #creationg array for data
            $data = array('RUTA'=>$path, 'FECHA_REGISTRO'=>$fecha, 'FECHA_ACTUALIZACION'=>$fecha, 'USUARIO_MODIF'=>$idUsuario,'ESTADO'=>1, 'NOMBRE'=>$nameOfFile.'.'.$extensionOfFile,'ID_SEMESTRE'=>$semestreActual,'ID_ESPECIALIDAD'=>$especialidad, 'DOCUMENTO_ANHO'=>$semestre[0], 'DOCUMENTO_SEMESTRE'=>$semestre[1],'TIPO_DOCUMENTO'=>$tipoDoc);
            $idProyecto = DB::table('DOCUMENTOS_REUNIONES')->insertGetId(
                $data
            );
            
            
            flash('Se ha subido el archivo de forma correcta.')->success();
            return back();
        }
        catch(Exception $e){
            flash('Ha ocurrido un error al intentar cargar el documento, favor intentar de nuevo.')->error();
        }
    }

    public function descargarDocumentosReuniones(Request $request){      
        $tipo=$request->get('botonSubmit',null);
        $checks=$request->get('checkDocs',null);

        if($checks!=NULL){
            //Funciones
            if($tipo=="Elim"){
                try{
                    $files = array();
                    $cant = 0;
                    foreach ($checks as $value) {
                        $arreglo=explode('@',$value);
                        $file= public_path(). "/upload//".$arreglo[0];
                        /*NO BORRAR esto es para eliminar fisicamente el archivo

                        $dirHandle = opendir(public_path(). "/upload/");
                        $dir = public_path(). "/upload/";
                        while ($file = readdir($dirHandle)) {
                            if($file==$value) {
                                unlink($dir.'/'.$file);
                            }
                        }
                        closedir($dirHandle);
                        */
                        //Esto es para cambiar el estado a cero
                        DB::table('DOCUMENTOS_REUNIONES')
                        ->where('ID_DOCUMENTO', '=',$arreglo[1])
                        ->update(['ESTADO' => 0]);
                        $cant = $cant + 1;
                    } 
                    flash('Se ha eliminado '.$cant.' archivo(s) de forma correcta.')->success();
                    return back();
                }
                catch(Exception $e){
                    flash('No se ha podido eliminar el(los) archivo(s) seleccionado(s), favor intentar de nuevo.')->error();
                }
            }else{
                try{
                    $dirHandle = opendir(public_path(). "/upload//");
                    $dir = public_path(). "/upload//";
                    $valueComprimido = public_path(). "/upload/comprimido.zip";
                    while ($file = readdir($dirHandle)) {
                        if($file=="comprimido.zip") {
                            unlink($dir.'//'.$file);
                        }
                    }
                    closedir($dirHandle);
                }catch(Exception $e){

                }

                $files = array();
                foreach ($checks as $value) {
                    $arreglo=explode('@',$value);
                    $file= public_path(). "/upload/".$arreglo[0];
                    array_push($files, $file);
                } 

                \Zipper::make(public_path('/upload/comprimido.zip'))->add($files)->close();
                return response()->download(public_path('/upload/comprimido.zip'));
            }
        }
        else{
            return back();
        }
       
    }
}
