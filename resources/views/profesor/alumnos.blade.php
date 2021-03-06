@extends('Layouts.layout')
@section('pageTitle', 'Calificar Alumnos')
@section('content')
@section('js-libs')
<script type="text/javascript"  src="{{ URL::asset('js/alumnos/alumnos.js') }}"></script>
<script type="text/javascript"  src="{{ URL::asset('js/steps/jquery.steps.js') }}"></script>
<script type="text/javascript"  src="{{ URL::asset('js/steps/jquery.steps.min.js') }}"></script>

<style>
.ocultarTachito {
  display:none;

}

#ocultarTachito:hover .ocultarTachito {
  display:block;
}

.modalCargando {
  display:    none;
  position:   fixed;
  z-index:    1000;
  top:        0;
  left:       0;
  height:     100%;
  width:      100%;
  opacity: 0.7;
  background: #FFFFFF/*rgba( 255, 255, 255, .6 ) */
  url('http://i.stack.imgur.com/FhHRx.gif') 
  50% 50% 
  no-repeat;
}

/* When the body has the loading class, we turn
the scrollbar off with overflow:hidden */
body.loading .modalCargando {
  overflow: hidden;   
}

/* Anytime the body has the loading class, our
modal element will be visible */
body.loading .modalCargando {
  display: block;
}

</style>

@stop
<?php 
$modoSoloLectura=in_array(Auth::user()->ID_ROL,App\Entity\Usuario::getModoLectura());
?>
@php ($idInd = array())
@php ($i = 0)
@foreach($indicadores as $indicador)
@php ($idInd[$i] = $indicador->ID_INDICADOR)
@php ($i = $i + 1)
@endforeach

<div class="customBody">


	<div class="row">
		<div class="col-md-12 col-sm-12">
      @if($vistaProc=='calificar')
      <h1 class="mainTitle" ><a href="{{route('profesor.calificar')}}"> Calificar Alumnos </a> > <a href=""> {{$curso[0]->NOMBRE}} - {{$horario[0]->NOMBRE}}</a></h1>
      @elseif($vistaProc=='horarios')
      <h1 class="mainTitle" ><a href="{{route('cursos.gestion')}}"> Gestionar Cursos </a> > <a href="{{ route('cursos.horarios') }}?id={{$curso[0]->ID_CURSO}}&nombre={{$curso[0]->NOMBRE}}&codigo={{$curso[0]->CODIGO_CURSO}}">{{$curso[0]->CODIGO_CURSO}} -{{$curso[0]->NOMBRE}}</a> > <a href=""> {{$horario[0]->NOMBRE}}</a></h1>
      @endif
    </div>
  </div>
  @include('flash::message')
  @if(count($alumnos)>0)
  <div class="row">

    <!--BLOQUE IZQUIERDA-->
    <div class="x_panel tile coursesBox ">
     <div class="row rowFinal">
      <div class="row" style="padding-bottom: 10px">
       <div class="col-xs-9 col-md-8" >
        <h1 class="secondaryTitle mainTitle">Seleccione un alumno a calificar</h1>
      </div>
      <div class="col-md-4 col-sm-6 form-group top_search" >
        <div class="input-group">
          <input id="buscarAlumno" type="text" class="form-control searchText" placeholder="Alumno...">
          <span class="input-group-btn">
            <button class="btn btn-default searchButton" type="button">Buscar</button>
          </span>
        </div>
      </div>
    </div>

    <div class="row">
     <form action="{{ route('proyecto.store.masivo') }}" method="post" enctype="multipart/form-data">
      {{ csrf_field() }}
      <div class="table-responsive"  style="max-height:390px;overflow:auto; position: relative">
        <table class="table table-striped jambo_table bulk_action">
         <thead >
          <tr class="headings" style="background-color: #005b7f; color: white; font-family: Segoe UI">
           <th class="pText column-title" style="border:none;"> Código</th>
           <th class="pText column-title" style="border:none;">Nombre</th>
           @if(!$modoSoloLectura)
           <th class="pText column-title" style="border:none;">Proyecto</th>
           @endif
           @if(count($projects)>0)
           <td></td>  
           @endif
           <!--para cada resultado-->
           @foreach($resultados as $resultado)
           <th class="pText column-title" style="border:none;text-align:center;">{{$resultado->NOMBRE}}</th>
           @endforeach 
           @if(!$modoSoloLectura)
           <!--<th class="pText column-title" style="border:none;"> </th>-->
           <th class="pText column-title" style="border:none;">
            <label style="vertical-align: middle;">   
              <input class="selectAll" type="checkbox"> <span class="pText label-text "></span>
            </label><br>
            <i class="fas fa-trash eliminarVarios" idHorario='{{$horario[0]->ID_HORARIO}}' id="1" style="color: white; cursor: pointer;text-align:center;vertical-align: middle;"></i>
          </th>
          @endif

        </tr>
      </thead>
      <!--CargarCurso-->

      <tbody class="text-left" id="listaAlumnos">
        @foreach($alumnos as $alumno)

        <!--<tr class="even pointer" id="ocultarTachito">-->
          <tr class="even pointer" id="">
            <td class="pText" style="background-color: white; padding-top: 12px; color: #72777a;vertical-align: center;">{{$alumno->CODIGO}} </td>
            <td class="pText" id="" style="background-color: white; padding-top: 12px; color: #72777a;vertical-align: center;">{{$alumno->NOMBRES}} {{$alumno->APELLIDO_PATERNO}} {{$alumno->APELLIDO_MATERNO}}

            </td>
            <input type="text" name="codAlumnos[]" value="{{$alumno->CODIGO}}" hidden>
            <input type="text" name="horario" value="{{$horario[0]->ID_HORARIO}}" hidden>
            @if(!$modoSoloLectura)
            <td class="pText" style="background-color: white; padding-top: 12px; color: #72777a;text-align: center;vertical-align: center;"><input type="file" name="archivos[{{$alumno->ID_ALUMNO}}]" id = "file" class="fileToUpload"></td>    
            @endif

            @if(count($projects)>0)
            <td class="pText" style="background-color: white; padding-top: 12px; color: #72777a;text-align: center;vertical-align: center;">
              @foreach($projects as $project)                        

              @if($project->ID_PROYECTO == $alumno->ID_PROYECTO2)

              <a href="{{URL::asset('upload/'.$project->NOMBRE)}}" download="{{$project->NOMBRE}}" style="text-decoration: underline;">
                @if($project->ID_PROYECTO!=1){{$project->NOMBRE}}<i class="fa fa-download" style="padding-left: 5px"></i> @endif</a>
                @break

                @endif

                @endforeach
              </td>
              @endif


              @foreach($resultados as $resultado)

              <?php 
              $cuentaAlumno=0;
              $cuentaTotal=0;
              foreach($avanceCalificacion as $alumnoResultado){
                if($alumnoResultado->ID_ALUMNO==$alumno->ID_ALUMNO and $alumnoResultado->ID_RESULTADO==$resultado->ID_RESULTADO){
                  $cuentaTotal=$alumnoResultado->CUENTA_TOTAL;  
                  $cuentaAlumno=$alumnoResultado->CUENTA_ALUMNO;  
                  break;
                }
              }
              ?>
              @if($alumno->ID_PROYECTO2!=1)
              <td id="{{$resultado->ID_RESULTADO}}" nombreAlumno="{{$alumno->NOMBRES}} {{$alumno->APELLIDO_PATERNO}} {{$alumno->APELLIDO_MATERNO}}" idCurso="{{$curso[0]->ID_CURSO}}" idHorario="{{$horario[0]->ID_HORARIO}}" idResultado="{{$resultado->ID_RESULTADO}}" idAlumno="{{$alumno->ID_ALUMNO}}" codAlumno ="{{$alumno->CODIGO}}" class="pText AbrirCalificacion view" style="background-color: white; padding-top: 12px; color: #72777a;text-align: center;vertical-align: center;cursor: pointer;">
                @if($cuentaAlumno==0)
                <i class="fa fa-edit" style="font-size: 16px"></i>
                @elseif($cuentaAlumno>0 and $cuentaAlumno<$cuentaTotal)
                <i class="fas fa-spinner" style="font-size: 16px"></i>
                @elseif ($cuentaAlumno==$cuentaTotal)
                <i class="fas fa-check-circle" style="font-size: 16px;color: green"></i>
                @endif
              </td>
              @else
              <td nombreAlumno="{{$alumno->NOMBRES}} {{$alumno->APELLIDO_PATERNO}} {{$alumno->APELLIDO_MATERNO}}" class="noCalificar" style="background-color: white; padding-top: 12px; color: #72777a;text-align: center;vertical-align: center;cursor: pointer;"><i class="fa fa-edit" style="font-size: 16px"></i></td>
              @endif
              @endforeach
              @if(!$modoSoloLectura)
              <!--<td>  <center><div class="" style=""><i idAlumno="{{$alumno->ID_ALUMNO}}" idHorario="{{$horario[0]->ID_HORARIO}}" nombreAlumno="{{$alumno->NOMBRES}} {{$alumno->APELLIDO_PATERNO}} {{$alumno->APELLIDO_MATERNO}}" class="elimAlumno fas fa-trash" id="1" style="color: #005b7f; cursor: pointer;text-align:center;vertical-align: middle;"></i></div></center></td>-->
              <td  class="pText" style="background-color: white; padding-top: 12px; color: #72777a;text-align: center;vertical-align: center;"><label>
                <input type="checkbox" class="form-check-input checkAlumnos" 
                name="checkAlumnos[]" id="checkAlumnos"  value="{{$alumno->ID_ALUMNO}}" > <span class="pText label-text "></span></label></td>

                @endif
              </tr>


              @endforeach
            </tbody>
          </table>

        </div>
        @if(!$modoSoloLectura)
        <button type = "submit" class = "btn btn-success btn-lg pText customButton" style="width:140px !important;margin-top: 20px">Subir Proyectos<i class="fa fa-upload" style="padding-left: 5px"></i> </button>
        @endif
      </form>

    </div>
  </div>
</div>
</div>
@else
<div class=" x_panel tile coursesBox">
  <h1 class="messageText no-padding">No hay alumnos cargados</h1>
  <h1 class="messageText no-padding"><a href="{{ route('cursos.horarios') }}?id={{$curso[0]->ID_CURSO}}&nombre={{$curso[0]->NOMBRE}}&codigo={{$curso[0]->CODIGO_CURSO}}"><i class="fa fa-arrow-circle-left"></i> Regresar</a></h1>
</div> 
@endif
<!-- Modal Alumno a Evaluar-->

<div class="modal fade bs-example-modal-lg text-center" role="dialog" tabindex="-1"
id="modalCalificacion" data-keyboard="false" data-backdrop="static"
aria-labelledby="gdridfrmnuavaUO" data-focus-on="input:first" style="z-index: 2000;position: fixed;">
<div class="modalAlumnos modal-dialog modal-lg">
  <div class="modal-content">
    <div class="modal-header">
      <button id="closeCalificar" type="button" class="close" data-dismiss="modal"
      aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
    <h4 class="reportsTitle mainTitle modal-title" style="padding-top: 10px; text-align: center;" id="gridSystemModalLabel">  Alumno a Evaluar: </h4>
    <h4 id="alumnoACalificar" class="reportsTitle mainTitle modal-title" style="text-align: center;" id="gridSystemModalLabel"></h4>
  </div>
  <hr style="padding: 0px; margin-top: 0px; margin-bottom: 0px; width: 80%">
  
  <div class="modal-body" id="detalleModal">

  </div>
</div>

<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
<!-- /.modal -->


</div>




<div class="modalCargando"><!-- Place at bottom of page --></div>

@stop

@section('js-scripts')

<script type="text/javascript">
  PNotify.prototype.options.delay ? (function() {
    PNotify.prototype.options.delay -= 500;
    update_timer_display();
  }()) : (alert('Timer is already at zero.'))
</script>

@stop