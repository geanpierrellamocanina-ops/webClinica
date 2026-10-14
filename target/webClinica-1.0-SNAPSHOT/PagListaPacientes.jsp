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
                                <span>Lista de Pacientes</span>
                            </h3>

                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <a href="ControlPaciente?accion=nuevo" title="Nuevo" class="btn btn-success">
                                        <i class="fa fa-plus"></i> Nuevo
                                    </a>
                                    <br><br>

                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTable">
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Cod. Pac</th>
                                                    <th>Nombres</th>
                                                    <th>Apellidos</th>
                                                    <th>Teléfono</th>
                                                    <th>Tipo Documento</th>
                                                    <th># Documento</th>
                                                    <th>Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    PacienteDAO dao = new PacienteDAO();
                                                    ArrayList<Paciente> lista = dao.ListarPacientes();

                                                    for (Paciente p : lista) {
                                                %>
                                                <tr class="odd gradeX">
                                                    <td><%=p.getCodigoPaciente()%></td>
                                                    <td><%=p.getNombres()%></td>
                                                    <td><%=p.getApellidos()%></td>
                                                    <td><%=p.getTelefono()%></td>
                                                    <td><%=p.getTipoDocumento()%></td>
                                                    <td><%=p.getDocumentoIdentidad()%></td>
                                                    <td>
                                                        <a href="ControlPaciente?accion=editar&id=<%=p.getCodigoPaciente()%>" class="btn btn-info" title="Editar">
                                                            <i class="fa fa-edit" ></i>
                                                        </a>
                                                        <a href="ControlPaciente?accion=eliminar&id=<%=p.getCodigoPaciente()%>"  class="btn btn-danger" title="Eliminar"
                                                                onclick="return confirm('¿Está seguro que desea eliminar al paciente: <%=p.nomCompletos()%>?') ">
                                                            <i class="fa fa-trash" ></i>
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
</html>
