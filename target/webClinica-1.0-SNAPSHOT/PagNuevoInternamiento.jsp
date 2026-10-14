<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Internamiento</title>

        <%@include file="./include/RecursoCss.jsp" %>
    </head>
    <body>
        <div id="wrapper">

            <%@include file="./include/Navegacion.jsp" %>
            <%                Internamiento p = (Internamiento) request.getAttribute("internamiento");
            %>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <span>Nuevo Internamiento</span>
                            </h3>
                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form id="form" method="post" action="ControlInternamiento">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Paciente <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-6">
                                                <input type="text"  name="nomPac"  id="nomPac" class="form-control" readonly="" value="<%=p.getNomPac() == null ? "" : p.getNomPac()%>">
                                            </div>
                                            <div class="col-sm-3">
                                                <button type="button" class="btn btn-success"  data-toggle="modal" data-target="#modalSelPac" title="Consultar Pacientes"><i class="fa fa-search-plus"></i></button>    
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Medico <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-6">
                                                <input type="text"  name="nomMed"  id="nomMed" class="form-control" readonly="" value="<%=p.getNomMed() == null ? "" : p.getNomMed()%>">
                                            </div>
                                            <div class="col-sm-3">
                                                <button type="button" class="btn btn-success"  data-toggle="modal" data-target="#modalSelMed" title="Consultar Médicos"><i class="fa fa-search-plus"></i></button>    
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Cama <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-6">
                                                <input type="text"  name="nomCama"  id="nomCama" class="form-control" readonly="" value="<%=p.getNomCama() == null ? "" : p.getNomCama()%>">
                                            </div>
                                            <div class="col-sm-3">
                                                <button type="button" class="btn btn-success"  data-toggle="modal" data-target="#modalSelCama" title="Consultar Camas"><i class="fa fa-search-plus"></i></button>    
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Costo Cama por dia <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-6">
                                                <input type="text"  name="precio"  id="precio" class="form-control" readonly="" value="<%=p.getTotalPagar()%>">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Fecha Ingreso <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-6">
                                                <input type="date" class="form-control" name="fecha" value="<%=p.getFechaIngreso() == null ? "" : p.getFechaIngreso()%>">      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Hora Ingreso <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-6">
                                                <input type="time" class="form-control" name="hora" value="<%=p.getHoraIngreso() == null ? "" : p.getHoraIngreso()%>">      
                                            </div>
                                        </div>

                                        <input type="hidden" name="codigo" value="<%=p.getCodigoInternamiento()%>">
                                        <input type="hidden" name="codPaciente" id="codPaciente" value="">
                                        <input type="hidden" name="codMedico" id="codMedico" >
                                        <input type="hidden" name="codCama" id="codCama" >
                                        <input type="hidden" name="accion" value="guardar">
                                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Guardar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalSelPac" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Listado de Pacientes</h4>
                    </div>
                    <div class="modal-body" id="listaPacientes">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalSelMed" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Listado de Medicos</h4>
                    </div>
                    <div class="modal-body" id="listaMedicos">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalSelCama" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Listado de Camas</h4>
                    </div>
                    <div class="modal-body" id="listaCamas">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="./include/RecursoJs.jsp" %>
    </body>

    <script>
        $(document).ready(function () {
            $("#listaPacientes").load("PagFiltroListaPaciente.jsp");
            $("#listaMedicos").load("PagFiltroListaMedico.jsp");
            $("#listaCamas").load("PagFiltroListaCama.jsp");
        });

        $(document).ready(function () {
            $.validator.addMethod("formatoFecha", function (value, element) {
                return value.match(/^\d\d\d\d?-\d\d?-\d\d$/);
            });

            $.validator.addMethod("valFechaPasada", function (value, element) {
                var hoy = new Date();
                var fecha = new Date(value);
                fecha.setDate(fecha.getDate() + 1);
                hoy.setHours(0, 0, 0, 0);

                return (hoy <= fecha);
            });

            $("#form").validate({
                rules: {
                    nomPac: {
                        required: true
                    },
                    nomMed: {
                        required: true
                    },
                    nomCama: {
                        required: true
                    },
                    fecha: {
                        required: true,
                        formatoFecha: true,
                        valFechaPasada: true
                    },
                    hora: {
                        required: true
                    }
                },
                messages: {
                    nomPac: {
                        required: "Por favor seleccione un paciente."
                    },
                    nomMed: {
                        required: "Por favor seleccione un médico."
                    },
                    nomCama: {
                        required: "Por favor seleccione una cama."
                    },
                    fecha: {
                        required: "El campo es requerido.",
                        formatoFecha: "Formato no valido.",
                        valFechaPasada: "La fecha ingresada es pasada."
                    },
                    hora: {
                        required: "El campo es requerido."
                    }
                }, submitHandler: function (form) {
                    form.submit();
                }
            });
        });

        function SeleccionarPaciente(cod, nombres) {
            $("#codPaciente").val(cod);
            $("#nomPac").val(nombres);
            $("#nomPac").focus();

            $("#modalSelPac").modal("hide");
        }

        function SeleccionarMedico(cod, nombres, precio) {
            $("#codMedico").val(cod);
            $("#nomMed").val(nombres);
            $("#nomMed").focus();
            $("#modalSelMed").modal("hide");
        }

        function SeleccionarCama(cod, nombre, precio) {
            $("#codCama").val(cod);
            $("#nomCama").val(nombre);
            $("#precio").val(precio);
            $("#modalSelCama").modal("hide");
        }
    </script>
</html>
