<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Medicos</title>

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
                                <span>Lista de Medicos</span>
                            </h3>
                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <a href="ControlMedico?accion=nuevo" title="Nuevo" class="btn btn-success">
                                        <i class="fa fa-plus"></i> Nuevo
                                    </a>
                                    <br><br>

                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTable">
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Especialidad</th>
                                                    <th>Medico</th>
                                                    <th>Teléfono</th>
                                                    <th>Correo</th>
                                                    <th>Fecha Ingreso</th>
                                                    <th>Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    MedicoDAO dao = new MedicoDAO();
                                                    ArrayList<Medico> lista = dao.ListarMedicos();
                                         
                                                    for (Medico p : lista) {
                                                %>
                                                <tr class="odd gradeX">
                                                    <td>
                                                        <%
                                                            if (p.getNombre().equals("")) {
                                                        %>
                                                        <button type="button" class="btn btn-danger disabled">Sin Especialidad</button>
                                                        <%
                                                        } else {
                                                        %>
                                                        <span><%=p.getNombre()%></span>
                                                        <%
                                                            }
                                                        %>
                                                    </td>
                                                    <td><%=p.nomCompletos()%></td>
                                                    <td><%=p.getTelefono()%></td>
                                                    <td><%=p.getCorreo()%></td>
                                                    <td><%=p.getFechaIngreso()%></td>
                                                    <td>
                                                        <a href="ControlMedico?accion=editar&id=<%=p.getCodigoMedico()%>" class="btn btn-info" title="Editar">
                                                            <i class="fa fa-edit" ></i>
                                                        </a>
                                                        <a href="ControlMedico?accion=eliminar&id=<%=p.getCodigoMedico()%>"  class="btn btn-danger" title="Eliminar" 
                                                           onclick="return confirm('¿Está seguro que desea eliminar al medico <%=p.nomCompletos()%>?')">
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
