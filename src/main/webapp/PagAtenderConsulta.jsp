<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta</title>

        <%@include file="./include/RecursoCss.jsp" %>
    </head>
    <body>
        <div id="wrapper">

            <%@include file="./include/Navegacion.jsp" %>
            <%                Consulta p = (Consulta) request.getAttribute("consulta");
            %>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <span>Atender Consulta</span>
                            </h3>
                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form id="form" method="post" action="ControlConsulta">
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label >Paciente</label>
                                                <label class="form-control"><%=p.getNomPac()%> </label>
                                            </div>

                                            <div class="form-group col-md-6">
                                                <label >Médico</label>
                                                <label class="form-control"><%=p.getNomMed()%> </label>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <label >Observación <span style="color:red;">(*)</span></label>
                                                <textarea class="form-control" rows="3" name="observacion" id="observacion" required=""></textarea>
                                            </div>
                                        </div>


                                        <div id="lista"></div>

                                        <div class="form-row">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fa fa-save"></i> Atender Consulta
                                            </button>
                                        </div>
                                        <input type="hidden" name="codigo" value="<%=p.getCodigoConsulta()%>">
                                        <input type="hidden" name="accion" value="consulta_atender">

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="./include/RecursoJs.jsp" %>
    </body>

    <script>
        $(document).ready(function () {
            ListarRecetas();
        });

        function ListarRecetas() {
            $("#lista").load("PagListaRecetas.jsp");
        }
        function AgregarMedicina() {
            $.ajax({
                type: "get",
                url: "ControlSesionReceta",
                data: $("#frmGuardar").serialize(),
                success: function (data) {
                    if (data) {
                        HabilitarCampos(false);
                        ListarRecetas();
                        toastr.success('Agregado correctamente.');
                    } else {
                        toastr.error("No se ha podido agregar datos.");
                    }
                },
                error: function (data) {
                    toastr.error("Error interno.!! No se ha podido agregar.");
                }
            });
        }

        function QuitarMedicina(indice) {
            $.ajax({
                type: "get",
                url: "ControlSesionReceta",
                data: {
                    indice: indice,
                    accion: "quitar"
                },
                success: function (data) {
                    if (data) {
                        ListarRecetas();
                        toastr.success('Quitado correctamente.');
                    } else {
                        toastr.error("No se ha podido quitar datos.");
                    }
                },
                error: function (data) {
                    toastr.error("Error interno.!! No se ha podido quitar.");
                }
            });
        }
    </script>
</html>
