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
            <%                String titulo = (String) request.getAttribute("titulo");
                Medicina p = (Medicina) request.getAttribute("medicina");
            %>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <a href="ControlMedicina?accion=listar" title="Volver atras" class="btn btn-success btn-sm btn-circle">
                                    <i class="fa fa-arrow-left"></i>
                                </a>
                                <span><%=titulo%></span>
                            </h3>
                            <%@include file="include/MensajesControl.jsp" %>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form id="form" method="post" action="ControlMedicina">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Laboratorio <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="laboratorio"  value="<%=p.getLabotario() == null ? "" : p.getLabotario()%>" maxlength="50">      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Nombre <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="nombre"  value="<%=p.getNombre() == null ? "" : p.getNombre()%>" maxlength="50">      
                                            </div>
                                        </div>

                                        <input type="hidden" name="codigo" value="<%=p.getCodigoMedicina()%>">
                                        <input type="hidden" name="accion" value="guardar">
                                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Guardar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="./include/RecursoJs.jsp" %>
    </body>

    <script>
        $(document).ready(function () {
            $("#form").validate({
                rules: {
                    nombre: {
                        required: true,
                        maxlength: 40
                    },
                    laboratorio: {
                        required: true,
                        maxlength: 40
                    }
                },
                messages: {
                    nombre: {
                        required: "El campo es requerido.",
                        maxlength: "Debe contener como máximo 40 caracteres."
                    },
                    laboratorio: {
                        required: "El campo es requerido.",
                        maxlength: "Debe contener como máximo 40 caracteres."
                    }
                }, submitHandler: function (form) {
                    form.submit();
                }
            });
        });

    </script>
</html>
