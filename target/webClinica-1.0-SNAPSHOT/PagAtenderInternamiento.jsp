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
            <%                Internamiento p = request.getAttribute("internamiento") == null ? new Internamiento() : (Internamiento) request.getAttribute("internamiento");
            %>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <span>Atender Internamiento</span>
                            </h3>
                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form id="form" method="get" action="ControlInternamiento">
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label >Paciente</label>
                                                <label class="form-control"><%=p.getNomPac() == null ? "" : p.getNomPac()%> </label>
                                            </div>

                                            <div class="form-group col-md-6">
                                                <label >Médico</label>
                                                <label class="form-control"><%=p.getNomMed() == null ? "" : p.getNomMed()%> </label>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label >Fecha Ingreso</label>
                                                <label class="form-control"><%=p.getFechaIngreso() == null ? "" : p.getFechaIngreso()%> </label>
                                            </div>

                                            <div class="form-group col-md-6">
                                                <label >Hora Ingreso</label>
                                                <label class="form-control"><%=p.getHoraIngreso() == null ? "" : p.getHoraIngreso()%> </label>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label >Fecha Salida <span style="color:red;">(*)</span></label>
                                                <input type="date" name="fecha_salida" id="fecha_salida" class="form-control" required="" >
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label >Hora Salida <span style="color:red;">(*)</span></label>
                                                <input type="time" name="hora_salida" id="hora_salida" class="form-control" required="" >
                                            </div>
                                        </div>


                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <label >Observación <span style="color:red;">(*)</span></label>
                                                <textarea class="form-control" rows="3" name="observacion" id="observacion" required=""><%=p.getObservacion() == null ? "" : p.getObservacion()%></textarea>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fa fa-save"></i> Atender Internamiento
                                            </button>
                                        </div>
                                        <input type="hidden" name="codigo" value="<%=p.getCodigoInternamiento()%>">
                                        <input type="hidden" name="accion" value="internamiento_atender">

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
            $("#fecha_salida").val(ObtFecActual('<%=p.getFechaSalida()%>'));
            $("#hora_salida").val(ObtHoraActual('<%=p.getHoraSalida()%>'));

        });

        function ObtFecActual(data) {
            if (data === "" || data === undefined || data === 'null') {
                var fecha = new Date();
                return  fecha.toJSON().slice(0, 10);
            } else {
                return data;
            }
        }

        function ObtHoraActual(data) {
            if (data === "" || data === undefined  || data === 'null') {
                var hoy = new Date();

                return (hoy.getHours() < 10 ? '0' + hoy.getHours() : hoy.getHours()) +
                        ':' + (hoy.getMinutes() < 10 ? '0' + hoy.getMinutes() : hoy.getMinutes());
            } else {
                return data;
            }
        }
    </script>
</html>
