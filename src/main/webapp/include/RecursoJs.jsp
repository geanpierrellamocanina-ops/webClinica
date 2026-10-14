<script src="./js/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/metisMenu.min.js"></script>
<script src="./js/dataTables/jquery.dataTables.min.js"></script>
<script src="./js/dataTables/dataTables.bootstrap.min.js"></script>
<script src="./js/startmin.js"></script>
<script src="./js/misFunciones/InputValidator.js" type="text/javascript"></script>
<script src="./alertify/toastr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js" type="text/javascript"></script>


<script type="text/javascript">
    $(document).ready(function () {
        var table = $('#dataTable').DataTable({
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