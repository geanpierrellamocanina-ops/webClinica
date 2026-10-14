<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Medicina</title>

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
                                <span>Lista de Medicinas </span>
                            </h3>
                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <a href="ControlMedicina?accion=nuevo" title="Nuevo" class="btn btn-success">
                                        <i class="fa fa-plus"></i> Nuevo
                                    </a>
                                    <br><br>

                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTable">
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Cod. Medicina</th>
                                                    <th>Laboratorio</th>
                                                    <th>Medicina</th>
                                                    <th>Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    MedicinaDAO dao = new MedicinaDAO();
                                                    ArrayList<Medicina> lista = dao.ListarMedicina();

                                                    for (Medicina p : lista) {
                                                %>
                                                <tr class="odd gradeX">
                                                    <td><%=p.getCodigoMedicina()%></td>
                                                    <td><%=p.getLabotario()%></td>
                                                    <td><%=p.getNombre()%></td>
                                                    <td>
                                                        <a href="ControlMedicina?accion=editar&id=<%=p.getCodigoMedicina()%>" class="btn btn-info" title="Editar">
                                                            <i class="fa fa-edit" ></i>
                                                        </a>
                                                        <a href="ControlMedicina?accion=eliminar&id=<%=p.getCodigoMedicina()%>"  class="btn btn-danger" title="Eliminar" 
                                                           onclick="return confirm('¿Está seguro que desea eliminar la medicina <%=p.getNombre()%>?')">
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
