<?php

namespace App\Http\Controllers;
use App\Entity\Resultado as eResultado;
use App\Entity\Categoria as eCategoria;
use App\Entity\Indicador as eIndicador;
use App\Entity\Descripcion as eDescripcion;
use App\Entity\EscalaCalificacion as eEscala;


use Illuminate\Http\Request;

class ResultadoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    public function rubricasGestion(Request $request) {
        $resultados=[];
        $categorias=[];
        $indicadores=[];
        $descripciones=[];

        $resultados = eResultado::getResultados()->toArray();
        if($resultados!=NULL){
            $categorias = eCategoria::getCategoriasId($resultados[0]->ID_RESULTADO)->toArray();
            if($categorias!=NULL){
                $indicadores = eIndicador::getIndicadoresId($categorias[0]->ID_CATEGORIA)->toArray();
                if($indicadores!=NULL)
                    $descripciones = eDescripcion::getDescripcionesId($indicadores[0]->ID_INDICADOR)->toArray();
            }
        }
        //$escalas = eEscala::getEscalas()->toArray();
        //$first= array_shift($resultados);
        //dd($categorias);
        return view('rubricas.gestion')
        ->with('resultados',$resultados)
        ->with('categorias',$categorias)
        ->with('indicadores', $indicadores)
        //->with('escalas', $escalas)
        ->with('descripciones', $descripciones);
    }

    public function insertarResultado(Request $request){
        $codigoRes = $request->get('_codRes', null);
        $nombreRes = $request->get('_descRes', null);

        $idResultado = eResultado::insertResultado($codigoRes,$nombreRes);
        //dd("HOLI");
        //console.log($idResultado);
        return $idResultado;
    }
    public function insertarCategoria(Request $request){
        $categoria = $request->get('_descCat', null);
        $idRes = $request->get('resultado',null);
        $idCat = eCategoria::insertCategoria($categoria, $idRes);
        return $idCat;
    }
    public function insertarIndicador(Request $request){
        $indicador = $request->get('_ind', null);
        $idCat = $request->get('_idCat',null);
        $orden = $request->get('_orden',null);
        $ordenRepetido =0;
        $indicadores = eIndicador::getIndicadoresId($idCat)->toArray();
        foreach($indicadores as $indicador2){
            if($indicador2->VALORIZACION == $orden){
                $ordenRepetido=1;
            }
        }
        if($ordenRepetido==1) return -2;
        $idInd = eIndicador::insertIndicador($idCat, $indicador, $orden);
        return $idInd;
    }
    public function insertarDescripcion(Request $request){
        $descripcion = $request->get('_desc', null);
        $nombre = $request->get('_descNom',null);
        $orden = $request->get('_descOrd',null);
        $idInd = $request->get('_idInd',null);

        $idDesc = eDescripcion::insertDescripcion($idInd,$descripcion,$nombre,$orden);

        return $idDesc;
    }
    public function actualizarResultado(Request $request){
        $id = $request->get('_idRes',null);
        $nombre = $request->get('_codRes',null);
        $desc = $request->get('_descRes',null);
        eResultado::updateResultado($id, $nombre, $desc);
    }
    public function actualizarCategoria(Request $request){
        $id = $request->get('_idCat',null);
        $nombre = $request->get('_cat',null);
        eCategoria::updateCategoria($id, $nombre);
    }
    public function actualizarIndicador(Request $request){
        $id = $request->get('_id',null);
        $nombre = $request->get('_nombre',null);
        eIndicador::updateIndicador($id, $nombre);
    }
    public function actualizarDescripcion(Request $request){
        $id = $request->get('_id',null);
        $nombre = $request->get('_nombre',null);
        eDescripcion::updateDescripcion($id, $nombre);
    }
    public function refrescarIndicadores(Request $request){
        $idCat = $request->get('_idCat',null);
        $indicadores = eIndicador::getIndicadoresId($idCat)->toArray();
        $indicadoresOrdenados = self::ordenarIndicadores($indicadores);
        return $indicadoresOrdenados;
    }

    public function borrarResultado(Request $request){
        $id = $request->get('_id',null);
        eResultado::deleteResultado($id);
        $categorias = eCategoria::getCategoriasId($id)->toArray();
        foreach($categorias as $categoria){
            eCategoria::deleteCategoria($categoria->ID_CATEGORIA);
            $indicadores = eIndicador::getIndicadoresId($categoria->ID_CATEGORIA)->toArray();
            foreach($indicadores as $indicador){
                eIndicador::deleteIndicador($indicador->ID_INDICADOR);
                $descripciones = eDescripcion::getDescripcionesId($indicador->ID_INDICADOR)->toArray();
                foreach($descripciones as $descripcion){
                    eDescripcion::deleteDescripcion($descripcion->ID_DESCRIPCION);
                }                   
            }
        }

    }
    public function borrarCategoria(Request $request){
        $id = $request->get('_id',null);
        eCategoria::deleteCategoria($id);
        $indicadores = eIndicador::getIndicadoresId($id)->toArray();
        foreach($indicadores as $indicador){
            eIndicador::deleteIndicador($indicador->ID_INDICADOR);
            $descripciones = eDescripcion::getDescripcionesId($indicador->ID_INDICADOR)->toArray();
            foreach($descripciones as $descripcion){
                eDescripcion::deleteDescripcion($descripcion->ID_DESCRIPCION);
            }                   
        }   
    }
    public function borrarIndicador(Request $request){
        $id = $request->get('_id',null);
        eIndicador::deleteIndicador($id);
        $descripciones = eDescripcion::getDescripcionesId($id)->toArray();
        foreach($descripciones as $descripcion){
            eDescripcion::deleteDescripcion($descripcion->ID_DESCRIPCION);
        }  
    }
    public function borrarDescripcion(Request $request){
        $id = $request->get('_id',null);
        eDescripcion::deleteDescripcion($id);
    }

    public function obtenerResultados(Request $request){

        $resultados = eResultado::getResultados()->toArray();

        return $resultados;
    }
    public function obtenerCategorias(Request $request){

        $idRes = $request->get('_idRes',null);
        $categorias = eCategoria::getCategoriasId($idRes)->toArray();

        return $categorias;
    }
    public function obtenerIndicadores(Request $request){

        $idCat = $request->get('_idCat',null);
        $indicadores = eIndicador::getIndicadoresId($idCat)->toArray();

        return $indicadores;
    }

    public function obtenerDescripciones(Request $request){

        $idInd= $request->get('_idInd',null);
        $descripciones = eDescripcion::getDescripcionesId($idInd)->toArray();

        return $descripciones;
    }
   
    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
    public function categorias(Request $request) {
        $resultado = $request->get('resultado',null);
        $idRes = $request->get('idRes',null);
        $categorias = eCategoria::getCategoriasId($idRes)->toArray();

        $indicadoresTodos= [];
        $i=0;
        foreach($categorias as $categoria){
            $indicadores = eIndicador::getIndicadoresId($categoria->ID_CATEGORIA)->toArray();
            $indicadoresOrdenados = self::ordenarIndicadores($indicadores);
            $indicadoresTodos[$categoria->ID_CATEGORIA]=$indicadoresOrdenados;
        }

        return view('rubricas.categorias')
        ->with('categorias',$categorias)
        ->with('resultado',$resultado)
        ->with('indicadoresTodos',$indicadoresTodos);
    }
    public function ordenarIndicadores($indicadores){
        for($i=0;$i<count($indicadores);$i++){
            $val = $indicadores[$i]->VALORIZACION;
            $valReal = $indicadores[$i];
            $j = $i-1;
            while($j>=0 && $indicadores[$j]->VALORIZACION > $val){
                $indicadores[$j+1] = $indicadores[$j];
                $j--;
            }
            $indicadores[$j+1] = $valReal;
        }
        return $indicadores;
    }
}
