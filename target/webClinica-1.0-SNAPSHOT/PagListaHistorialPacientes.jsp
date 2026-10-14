<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pacientes</title>

        <%@include file="./include/RecursoCss.jsp" %>
    </head>
    <body>
        <div id="wrapper">

            <%@include file="./include/Navegacion.jsp" %>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <span>Historial Paciente</span>
                            </h3>

                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTable">
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Cod. Pac</th>
                                                    <th>Nombres</th>
                                                    <th>Apellidos</th>
                                                    <th>Tipo Documento</th>
                                                    <th># Documento</th>
                                                    <th>Ver</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    ArrayList<Paciente> lista = (ArrayList<Paciente>) request.getAttribute("pacientes");

                                                    for (Paciente p : lista) {
                                                %>
                                                <tr class="odd gradeX">
                                                    <td><%=p.getCodigoPaciente()%></td>
                                                    <td><%=p.getNombres()%></td>
                                                    <td><%=p.getApellidos()%></td>
                                                    <td><%=p.getTipoDocumento()%></td>
                                                    <td><%=p.getDocumentoIdentidad()%></td>
                                                    <td>
                                                        <%
                                                            if (p.getCantConsultas() > 0 || p.getCantInternamiento() > 0) {
                                                        %>
                                                        <a href="javascript:void(0)" onclick="CargarDatos('<%=p.nomCompletos()%>', <%=p.getCodigoPaciente()%>,<%=p.getCantConsultas()%>,<%=p.getCantInternamiento()%>)" class="btn btn-success"  data-toggle="modal" data-target="#modalHistorial" title="Ver Historial">
                                                            <i class="fa fa-book"></i>
                                                        </a>
                                                        <%
                                                        } else {
                                                        %>
                                                        <a href="javascript:void(0)" style="cursor: not-allowed; opacity: 0.5"  class="btn btn-success">
                                                            <i class="fa fa-book"></i>
                                                        </a>
                                                        <%
                                                            }
                                                        %>

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


        <div class="modal fade" id="modalHistorial" tabindex="-1" role="dialog" data-backdrop="static"  aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Paciente: <span id="lbPaciente"></span></h4>
                    </div>
                    <div class="modal-body" >
                        <div>
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" id="lblConsulta"><a href="#divConsulta" aria-controls="home" role="tab" data-toggle="tab">Consulta</a></li>
                                <li role="presentation" id="lblInternamiento"><a href="#divInternamiento" aria-controls="profile" role="tab" data-toggle="tab">Internamiento</a></li>
                            </ul>


                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane active" id="divConsulta">

                                </div>
                                <div role="tabpanel" class="tab-pane" id="divInternamiento">

                                </div>
                            </div>

                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="modalDetalleConsulta" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Codigo Consulta: <span id="lbConsulta"></span></h4>
                    </div>
                    <div class="modal-body">
                        <div id="detalleConsulta"></div>
                    </div>
                </div>
            </div>
        </div>
        
             <div class="modal fade" id="modalDetalleInternamiento" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="tituloDetalleInt">Codigo Internamiento <span id="lbDetalle"></span></h4>
                    </div>
                    <div class="modal-body">
                        <div id="detalleInternamiento"></div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script>
        function CargarDatos(paciente, id, cantConsulta, cantInternamiento) {
            $("#lbPaciente").html(paciente);

            $('#lblConsulta').removeClass("active");
            $('#lblInternamiento').removeClass("active");

            $('#divConsulta').removeClass("active");
            $('#divInternamiento').removeClass("active");

            if (cantConsulta > 0) {
                $("#lblConsulta").addClass("active");
                $("#divConsulta").addClass("active");
            } else {
                $("#lblInternamiento").addClass("active");
                $("#divInternamiento").addClass("active");
            }

            if (cantConsulta === 0) {
                $("#lblConsulta").hide();
                $("#divConsulta").hide();
            } else {
                $("#lblConsulta").show();
                $("#divConsulta").show();
                $("#divConsulta").load("PagListaHistorialConsulta.jsp?id=" + id);
            }

            if (cantInternamiento === 0) {
                $("#lblInternamiento").hide();
                $("#divInternamiento").hide();
            } else {

                $("#lblInternamiento").show();
                $("#divInternamiento").show();
                $("#divInternamiento").load("PagListaHistorialInternamiento.jsp?id=" + id);
            }


        }

        function CargarDetalle(idConsulta) {
                $("#lbConsulta").html(idConsulta);
            $("#detalleConsulta").load("PagDetalleHistorialConsulta.jsp?id=" + idConsulta);
        }

        function CargarDetalleInternamiento(idInter) {
          $("#lbDetalle").html(idInter);
            $("#detalleInternamiento").load("PagDetalleHistorialInternamiento.jsp?id=" + idInter);

        }
    </script>
</html>
