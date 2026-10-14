<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="./include/RecursoCss.jsp" %>
        <title></title>
    </head>
    <body>
        <%
            RecetaDAO daoReceta = new RecetaDAO();
            ConsultaDAO daoCons = new ConsultaDAO();
            int idConsulta =  Integer.parseInt(request.getParameter("id"));
            Consulta p = daoCons.BuscarPorId("Atendido",idConsulta);
        %>
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
                                    <label >Observación </label>
                                    <label class="form-control" rows="3" name="observacion" id="observacion" required=""><%=p.getObservacion()%></label>
                                </div>
                            </div>


                            <table class="table table-striped table-bordered table-hover" id="dataTable">
                                <thead class="bg-primary">
                                    <tr>
                                        <th>#</th>
                                        <th style="width: 30%">Medicina</th>
                                        <th style="width: 10%">Cantidad</th>
                                        <th>Comentario</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaCampos">
                                    <%
                                       
                                        ArrayList<Receta> listRecetas = daoReceta.ListarRecetaPorConsulta(idConsulta);
                                        int indice = 0;
                                        for (Receta r : listRecetas) {
                                            indice++;
                                    %>
                                    <tr>
                                        <td><%=indice%></td>
                                        <td><%=r.getNombre()%></td>
                                        <td><%=r.getCantidad()%></td>
                                        <td><%=r.getComentario()%></td>
                                    </tr>
                                    <%
                                        }

                                        if (listRecetas.size() == 0) {
                                    %>
                                    <tr>
                                        <td colspan ="4" class="text-center">No hay datos</td>
                                    </tr>
                                    <%
                                        }
                                    %>

                                </tbody>

                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
