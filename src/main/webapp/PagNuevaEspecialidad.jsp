<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Especialidad</title>

        <%@include file="./include/RecursoCss.jsp" %>
    </head>
    <body>
        <div id="wrapper">

            <%@include file="./include/Navegacion.jsp" %>
            <%                String titulo = (String) request.getAttribute("titulo");
                Especialidad p = (Especialidad) request.getAttribute("especialidad");
            %>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <a href="ControlEspecialidad?accion=listar" title="Volver atras" class="btn btn-success btn-sm btn-circle">
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
                                    <form id="form" method="post" action="ControlEspecialidad">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Nombre <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="nombre" onkeypress="return soloLetras(event)" value="<%=p.getNombre() == null ? "" : p.getNombre()%>">      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Precio <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="number" class="form-control" name="precio"  onkeypress="return soloNumeros(event)" value="<%=p.getPrecio()%>" maxlength="15">  
                                            </div>
                                        </div>
                                        <input type="hidden" name="codigo" value="<%=p.getCodigoEspecialidad()%>">
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
                    precio: {
                        required: true,
                        number: true
                    }
                },
                messages: {
                    nombre: {
                        required: "El campo es requerido.",
                        maxlength: "Debe contener como máximo 40 caracteres."
                    },
                    precio: {
                        required: "El campo es requerido.",
                        number: "Debe ser un valor numérico."
                    }
                }, submitHandler: function (form) {
                    form.submit();
                }
            });
        });

    </script>
</html>
