<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.webclinica.modelo.*"%>
<%@page import="com.mycompany.webclinica.modeloDAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pacientes</title>

        <%@include file="./include/RecursoCss.jsp" %>
    </head>
    <body>
        <div id="wrapper">

            <%@include file="./include/Navegacion.jsp" %>
            <%
                String titulo = (String) request.getAttribute("titulo");
                Paciente p =(Paciente)request.getAttribute("paciente");
                 String tipo_documentos[] = (String[]) request.getAttribute("tipo_documentos");
            %>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="page-header">
                                <a href="ControlPaciente?accion=listar" title="Volver atras" class="btn btn-success btn-sm btn-circle">
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
                                    <form id="form" method="post" action="ControlPaciente">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Nombres <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="nombres" onkeypress="return soloLetras(event)" value="<%=p.getNombres() == null ? "" : p.getNombres()%>">      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Apellidos <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="apellidos" onkeypress="return soloLetras(event)" value="<%=p.getApellidos() == null ? "" : p.getApellidos()%>" >      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Teléfono</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="telefono" onkeypress="return soloNumeros(event)" maxlength="9" value="<%=p.getTelefono() == null ? "" : p.getTelefono()%>">      
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Tipo Documento <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <select class="form-control" name="tipo_documento">
                                                    <%
                                                        for (String tipo : tipo_documentos) {
                                                            if (tipo.equals(p.getTipoDocumento())) {
                                                                out.print("<option value='" + tipo + "' selected>" + tipo + "</option>");
                                                            } else {
                                                                out.print("<option value='" + tipo + "'>" + tipo + "</option>");
                                                            }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label"># Documento <span style="color:red;">(*)</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="documento"  onkeypress="return soloNumeros(event)" value="<%=p.getDocumentoIdentidad() == null ? "" : p.getDocumentoIdentidad()%>" maxlength="15">  
                                            </div>
                                        </div>
                                        <input type="hidden" name="codigo" value="<%=p.getCodigoPaciente()%>">
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
                    documento: {
                        required: true,
                        number: true,
                        minlength: 8,
                        maxlength: 12
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
                    documento: {
                        required: "El campo es requerido.",
                        number: "Debe ser un valor numérico.",
                        minlength: "Debe contener como minimo 8 caracteres.",
                        maxlength: "Debe contener como máximo 12 caracteres."
                    }
                }, submitHandler: function (form) {
                   form.submit();
                }
            });
        });

    </script>
</html>
