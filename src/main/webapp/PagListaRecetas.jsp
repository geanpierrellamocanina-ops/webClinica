<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <%@include file="./include/RecursoCss.jsp" %>
    <body>
        <div class="form-row" >
            <div class="form-group col-md-12">
                <button type="button" id="btnAgregar" class="btn btn-success" onclick="HabilitarCampos(true)">
                    <i class="fa fa-plus"></i> Agregar receta
                </button>
            </div>
        </div>

        <div class="form-row">
            <form id="frmGuardar">
                <table class="table table-striped table-bordered table-hover" id="dataTable">
                    <thead class="bg-primary">
                        <tr>
                            <th>#</th>
                            <th style="width: 30%">Medicina</th>
                            <th style="width: 10%">Cantidad</th>
                            <th>Comentario</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="tablaCampos">
                        <%
                            HttpSession sesion = request.getSession();
                            ArrayList<Receta> listRecetas = sesion.getAttribute("data") == null ? new ArrayList<Receta>() : (ArrayList<Receta>) sesion.getAttribute("data");
                            int indice = 0;
                            for (Receta r : listRecetas) {
                                indice++;
                        %>
                        <tr>
                            <td><%=indice%></td>
                            <td><%=r.getNombre()%></td>
                            <td><%=r.getCantidad()%></td>
                            <td><%=r.getComentario()%></td>
                            <td>
                                <a href="javascript:void(0)" onclick="QuitarMedicina(<%=indice - 1%>)" class="btn btn-xs  btn-danger">
                                    <i class="fa fa-trash"></i>
                                </a>
                            </td>
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
                    <tfoot id="crearCampos">
                        <tr>
                            <td></td>
                            <td>
                                <select name="idMedicina" id="idMedicina" class="form-control">
                                    <%
                                        MedicinaDAO dao = new MedicinaDAO();
                                        ArrayList<Medicina> lista = dao.ListarMedicina();

                                        for (Medicina p : lista) {
                                    %>
                                    <option value="<%=p.getCodigoMedicina()%>"><%=p.getNombre()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <td>
                                <input type="number" class="form-control" name="cantidad" id="cantidad" min="1" value="1">
                            </td>
                            <td>
                                <input type="text" class="form-control" name="comentario" id="comentario">
                            </td>
                            <td>
                                <input type="hidden" name="accion" id="accion" value="agregar">
                                <a href="javascript:void(0)" onclick="AgregarMedicina()"  class="btn btn-xs btn-success">
                                    <i class="fa fa-check"></i>
                                </a>
                                <a href="javascript:void(0)" onclick="HabilitarCampos(false)" class="btn btn-xs btn-default">
                                    <i class="fa fa-undo"></i>
                                </a>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </form>
        </div>



    </body>

    <script>
        $(document).ready(function () {
            HabilitarCampos(false);
        });
        function HabilitarCampos(valor) {
            if (valor === false) {
                $("#tablaCampos").show();
                $("#crearCampos").hide();
                $("#btnAgregar").prop("disabled", false);
            } else {
                $("#tablaCampos").hide();
                $("#crearCampos").show();
                $("#btnAgregar").prop("disabled", true);
            }
        }
    </script>
</html>
