<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Especialidad</title>

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
                                <span>Lista de Especialidad</span>
                            </h3>
                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <a href="ControlEspecialidad?accion=nuevo" title="Nuevo" class="btn btn-success">
                                        <i class="fa fa-plus"></i> Nuevo
                                    </a>
                                    <br><br>

                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTable">
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Cod. Esp</th>
                                                    <th>Nombre</th>
                                                    <th>Precio</th>
                                                    <th>Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    EspecialidadDAO dao = new EspecialidadDAO();
                                                    ArrayList<Especialidad> lista = dao.ListarEspecialidad();

                                                    for (Especialidad p : lista) {
                                                %>
                                                <tr class="odd gradeX">
                                                    <td><%=p.getCodigoEspecialidad()%></td>
                                                    <td><%=p.getNombre()%></td>
                                                    <td><%=p.getPrecio()%></td>
                                                    <td>
                                                        <a href="ControlEspecialidad?accion=editar&id=<%=p.getCodigoEspecialidad()%>" class="btn btn-info" title="Editar">
                                                            <i class="fa fa-edit" ></i>
                                                        </a>
                                                        <a href="ControlEspecialidad?accion=eliminar&id=<%=p.getCodigoEspecialidad()%>"  class="btn btn-danger" title="Eliminar" 
                                                           onclick="return confirm('¿Está seguro que desea eliminar la especialidad <%=p.getNombre()%>?')">
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
