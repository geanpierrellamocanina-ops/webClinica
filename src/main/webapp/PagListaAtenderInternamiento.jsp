<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Internamiento</title>

        <%@include file="./include/RecursoCss.jsp" %>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="./include/Navegacion.jsp" %>
            <%                String inicio = request.getAttribute("inicio") == null ? "" : (String) request.getAttribute("inicio");
                String fin = request.getAttribute("fin") == null ? "" : (String) request.getAttribute("fin");
       
            %>
            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <span>Internamiento por atender</span>
                            </h3>
                            <%@include file="include/MensajesControl.jsp" %>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form method="post" action="ControlInternamiento">
                                        <div class="row">
                                            <div class="form-row">
                                                <div class="form-group col-md-3">
                                                    <label >Fecha Inicio:</label>
                                                    <input type="date" class="form-control" name="inicio" id="inicio" >
                                                </div>
                                                <div class="form-group col-md-3">
                                                    <label >Fecha Fin: </label>
                                                    <input type="date" class="form-control" name="fin" id="fin" >
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <br>
                                                    <input type="hidden" name="accion" value="lista_atender">
                                                    <button type="submit" class="btn btn-primary" title="Consultar">
                                                        <i class="fa fa-search"></i> Consultar
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <hr>
                                    </form>

                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTable">
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Paciente</th>
                                                    <th>Especialidad</th>
                                                    <th>Médico</th>
                                                    <th>Fecha Ingreso</th>
                                                    <th>Hora Ingreso</th>
                                                    <th>Dar alta</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    ArrayList<Internamiento> lista = (ArrayList<Internamiento>) request.getAttribute("lista");

                                                    for (Internamiento c : lista) {
                                                %>
                                                <tr>
                                                    <td><%=c.getNomPac()%></td>
                                                    <td><%=c.getNomEsp()%></td>
                                                    <td><%=c.getNomMed()%></td>
                                                    <td><%=c.getFechaIngreso()%></td>
                                                    <td><%=c.getHoraIngreso()%></td>
                                                    <td>
                                                        <a href="ControlInternamiento?accion=atender&id=<%=c.getCodigoInternamiento()%>" class="btn btn-success" title="Atender Paciente">
                                                            <i class="fa fa-calendar-minus-o" ></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>

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
            $("#inicio").val(ObtFecActual('<%=inicio%>'));
            $("#fin").val(ObtFecActual('<%=fin%>'));
        });

        function ObtFecActual(data) {
            if (data === "" || data === undefined || data === 'null') {
                var fecha = new Date();
                return  fecha.toJSON().slice(0, 10);
            } else {
                return data;
            }
        }

    </script>
</html>
