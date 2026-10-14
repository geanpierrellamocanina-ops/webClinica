<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover" id="dataTableMed">
        <thead class="bg-primary">
            <tr>
                <th class="text-center" style="width: 10%">Seleccionar</th>
                <th style="width: 40%">Especialidad</th>
                <th style="width: 50%">Medico</th>
            </tr>
        </thead>
        <tbody>
            <%
                MedicoDAO dao = new MedicoDAO();
                ArrayList<Medico> lista = dao.ListarMedicos();
                for (Medico p : lista) {
                    if (!p.getNombre().equals("")) {
            %>
            <tr class="odd gradeX">
                <td class="text-center" style="width: 10%">
                    <a href="javascript:SeleccionarMedico(<%=p.getCodigoMedico()%> ,'<%=p.nomCompletos()%>' , <%=p.getPrecio() %> )" class="btn btn-success" title="Seleccionar">
                        <i class="fa fa-plus-circle" ></i>
                    </a>
                </td>
                <td style="width: 40%"><%=p.getNombre()%></td>
                <td style="width: 50%"><%=p.nomCompletos()%></td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var table = $('#dataTableMed').DataTable({
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

