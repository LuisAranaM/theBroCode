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
        $categorias=[];
        $indicadores=[];

        $resultados = eResultado::getResultados()->toArray();
        $categorias = eCategoria::getCategoriasId($resultados[0]->ID_RESULTADO)->toArray();
        $indicadores = eIndicador::getIndicadoresId($categorias[0]->ID_CATEGORIA)->toArray();
        $descripciones = eDescripcion::getDescripcionesId($indicadores[0]->ID_INDICADOR)->toArray();
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
        $indicador = $request->get('_descInd', null);
        $idCat = $request->get('_idCat',null);
        $idInd = eIndicador::insertIndicador($idCat,1,1,$indicador, null,null,null,null);
        return $idInd;
    }
    public function insertarDescripcion(Request $request){
        $descripcion = $request->get('_descDesc', null);
        $idInd = $request->get('_idInd',null);
        $idDesc = eDescripcion::insertDescripcion($idInd,$descripcion);

        return $idDesc;
    }
    
    public function refrescarResultados(Request $request){

        $resultados = eResultado::getCriterios()->toArray();

        return $resultados;
    }
    public function refrescarCategorias(Request $request){

        $idRes = $request->get('_idRes',null);
        $categorias = eCategoria::getCategoriasId($idRes)->toArray();

        return $categorias;
    }
    public function refrescarIndicadores(Request $request){

        $idCat = $request->get('_idCat',null);
        $indicadores = eIndicador::getSubCriteriosId($idCat)->toArray();

        return $indicadores;
    }

    public function refrescarDescripciones(Request $request){

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
            $indicadoresTodos[$categoria->ID_CATEGORIA]=$indicadores;
        }

        return view('rubricas.categorias')
        ->with('categorias',$categorias)
        ->with('resultado',$resultado)
        ->with('indicadoresTodos',$indicadoresTodos);
    }
}
