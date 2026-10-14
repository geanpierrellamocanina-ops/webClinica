<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover" id="dataTableCama">
        <thead class="bg-primary">
            <tr>
                <th   class="text-center" >Seleccionar</th>
                <th>Categoria</th>
                <th># Cama</th>
                <th>Precio por dia</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
            <%
                CamaDAO dao = new CamaDAO();
                ArrayList<Cama> lista = dao.ListarCamas();
                String clase = "";
                for (Cama p : lista) {
                    if (p.getEstado().equalsIgnoreCase("Disponible")) {
                        clase = "background-color: green;";
                    } else {
                        clase = "background-color: red;";
                    }
            %>
            <tr class="odd gradeX">
                <td class="text-center">
                    <%
                        if (p.getEstado().equalsIgnoreCase("Disponible")) {
                    %>
                    <a href="javascript:SeleccionarCama(<%=p.getCodigoCama()%> ,'<%=p.getNumeroCama()%>' , <%=p.getPrecioDia()%> )" class="btn btn-success" title="Seleccionar">
                        <i class="fa fa-plus-circle" ></i>
                    </a>
                    <%
                    } else {
                    %>
                    <a href="javascript:void(0)" class="btn btn-danger" style="cursor: not-allowed; opacity: 0.5" >
                        <i class="fa fa-minus-circle"></i>
                    </a>
                    <%
                        }
                    %>

                </td>
                <td><%=p.getCategoria()%></td>
                <td><%=p.getNumeroCama()%></td>
                <td><%=p.getPrecioDia()%></td>
                <td>
                    <span class="badge" style="<%=clase%>"><%=p.getEstado()%></span> 
                </td>
            </tr>
            <%

                }
            %>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var table = $('#dataTableCama').DataTable({
            language: {
                "lengthMenu": "Mostrar _MENU_ registros",
                "zeroRecords": "No se encontraron resultados",
                "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                "infoFiltered": "(filtrado de un total de _MAX_ registros)",
                "sSearch": "Buscar:",
                "oPaginate": {
                    "sFirst": "Primero",
                    "sLast": "Último",
                    "sNext": "Siguiente",
                    "sPrevious": "Anterior"
                },
                "sProcessing": "Procesando..."
            },
            //para usar los botones   

            responsive: "true"
        });
    });
</script>

