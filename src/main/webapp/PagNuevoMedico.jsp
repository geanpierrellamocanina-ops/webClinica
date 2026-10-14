<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Medico</title>

        <%@include file="./include/RecursoCss.jsp" %>
    </head>
    <body>
        <div id="wrapper">

            <%@include file="./include/Navegacion.jsp" %>
            <%                String titulo = (String) request.getAttribute("titulo");
                Medico p = (Medico) request.getAttribute("medico");

            %>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <a href="ControlMedico?accion=listar" title="Volver atras" class="btn btn-success btn-sm btn-circle">
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
                                    <form id="form" method="post" action="ControlMedico">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Nombres <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="nombres" onkeypress="return soloLetras(event)" value="<%=p.getNombresMed() == null ? "" : p.getNombresMed()%>">      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Apellidos <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="apellidos" onkeypress="return soloLetras(event)" value="<%=p.getApellidosMed() == null ? "" : p.getApellidosMed()%>" >      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Teléfono</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="telefono" onkeypress="return soloNumeros(event)" maxlength="9" value="<%=p.getTelefono() == null ? "" : p.getTelefono()%>">      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Especialidad <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <select class="form-control" name="especialidad">
                                                    <option value="">:::Seleccione:::</option>
                                                    <%
                                                        EspecialidadDAO dao = new EspecialidadDAO();
                                                        ArrayList<Especialidad> lista = dao.ListarEspecialidad();

                                                        for (Especialidad e : lista) {
                                                            if (p.getCodigoEspecialidad() == e.getCodigoEspecialidad()) {
                                                                out.print("<option value='" + e.getCodigoEspecialidad() + "' selected>" + e.getNombre() + "</option>");
                                                            } else {
                                                                out.print("<option value='" + e.getCodigoEspecialidad() + "'>" + e.getNombre() + "</option>");
                                                            }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Correo <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="correo"  value="<%=p.getCorreo() == null ? "" : p.getCorreo()%>" maxlength="30">  
                                            </div>
                                        </div>
                                        <input type="hidden" name="codigo" value="<%=p.getCodigoMedico()%>">
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
                    nombres: {
                        required: true,
                        maxlength: 40
                    },
                    apellidos: {
                        required: true,
                        maxlength: 50
                    },
                    telefono: {
                        required: true,
                        number: true,
                        minlength: 9
                    },
                    correo: {
                        required: true,
                        email: true,
                        maxlength: 30
                    },
                    especialidad: {
                        required: true
                    }
                },
                messages: {
                    nombres: {
                        required: "El campo es requerido.",
                        maxlength: "Debe contener como máximo 40 caracteres."
                    },
                    apellidos: {
                        required: "El campo es requerido.",
                        maxlength: "Debe contener como máximo 50 caracteres."
                    },
                    telefono: {
                        required: "El campo es requerido.",
                        number: "Debe ser un valor numérico.",
                        minlength: "Debe contener como minimo 9 digitos."
                    },
                    correo: {
                        required: "El campo es requerido.",
                        email: "Formato no valido.",
                        maxlength: "Debe contener como maximo 30 caracteres."
                    },
                    especialidad: {
                        required: "La especialidad es requerida."
                    }
                }, submitHandler: function (form) {
                    form.submit();
                }
            });
        });

    </script>
</html>
