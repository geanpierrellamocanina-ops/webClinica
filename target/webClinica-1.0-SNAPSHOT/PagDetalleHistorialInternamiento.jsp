<%@page import="java.util.ArrayList"%>
<%@page import="webclinica.modelo.*"%>
<%@page import="webclinica.modeloDAO.*"%>
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
            InternamientoDAO daoInt = new InternamientoDAO();
            int idInter = Integer.parseInt(request.getParameter("id"));
            Internamiento p = daoInt.BuscarPorId("Salida", idInter);
        %>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form id="form" method="get" action="ControlInternamiento">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label >Paciente</label>
                                    <label class="form-control"><%=p.getNomPac() == null ? "" : p.getNomPac()%> </label>
                                </div>

                                <div class="form-group col-md-6">
                                    <label >Médico</label>
                                    <label class="form-control"><%=p.getNomMed() == null ? "" : p.getNomMed()%> </label>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label >Fecha Ingreso</label>
                                    <label class="form-control"><%=p.getFechaIngreso() == null ? "" : p.getFechaIngreso()%> </label>
                                </div>

                                <div class="form-group col-md-6">
                                    <label >Hora Ingreso</label>
                                    <label class="form-control"><%=p.getHoraIngreso() == null ? "" : p.getHoraIngreso()%> </label>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label >Fecha Salida</label>
                                    <label class="form-control"><%=p.getFechaSalida() == null ? "" : p.getFechaSalida()%> </label>
                                </div>
                                <div class="form-group col-md-6">
                                    <label >Hora Salida</label>
                                    <label class="form-control"><%=p.getHoraSalida() == null ? "" : p.getHoraSalida()%> </label>
                                </div>
                            </div>


                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <label >Observación</label>
                                    <textarea class="form-control" rows="3" name="observacion" id="observacion" required="" disabled=""><%=p.getObservacion() == null ? "" : p.getObservacion()%></textarea>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
