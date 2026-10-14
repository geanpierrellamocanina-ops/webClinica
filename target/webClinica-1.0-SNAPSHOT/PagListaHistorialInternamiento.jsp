<%@page import="java.util.ArrayList"%>
<%@page import="webclinica.modelo.*"%>
<%@page import="webclinica.modeloDAO.*"%>
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
        <%   int idPac = request.getParameter("id") == null ? 0 : Integer.parseInt(request.getParameter("id"));

            InternamientoDAO daoCons = new InternamientoDAO();
        %> 

        <div class="container-fluid ">
            <br>
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover" id="dataTable">
                    <thead class="bg-primary">
                        <tr>
                            <th>Codigo Intern.</th>
                            <th>Especialidad</th>
                            <th>Médico</th>
                            <th>Ingreso</th>
                            <th>Salida</th>
                            <th>Costo</th>
                            <th>Detalle</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Internamiento> lista = daoCons.ListarPorEstado("Salida", idPac);

                            for (Internamiento c : lista) {
                        %>
                        <tr>
                            <td><%=c.getCodigoInternamiento()%></td>
                            <td><%=c.getNomEsp()%></td>
                            <td><%=c.getNomMed()%></td>
                            <td><%=c.getFechaIngreso() + " " + c.getHoraIngreso()%></td>
                            <td><%=c.getFechaSalida() + " " + c.getHoraSalida()%></td>
                            <td><%=c.getTotalPagar()%></td>
                            <td>
                                <a href="javascript:void(0)" onclick="CargarDetalleInternamiento(<%=c.getCodigoInternamiento() %>)" 
                                    data-toggle="modal" data-target="#modalDetalleInternamiento"
                                   class="btn btn-success" title="Ver detalle">
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
    </body>
</html>
