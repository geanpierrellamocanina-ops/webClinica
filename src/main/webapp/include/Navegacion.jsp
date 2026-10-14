<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String user = "admingmail.com";
    /*
    if (request.getSession().getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
    } else {
        user = (String) request.getSession().getAttribute("usuario");
    }
    */

    String URL = request.getRequestURL().toString();
%>


<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <a href="#" class="navbar-brand" ><i class="fa fa-home fa-fw"></i>Proyecto Clinica</a>
    </div>

    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>

    <ul class="nav navbar-right navbar-top-links">
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <i class="fa fa-user fa-fw"></i><%=user%><b class="caret"></b>
            </a>
            <ul class="dropdown-menu dropdown-user">
                <li>        
                    <a href="ControlLogin?accion=logout">Cerrar Sesión</a>
                </li>
            </ul>
        </li>
    </ul>

    <div class="navbar-default sidebar" role="navigation">
        <div class="sidebar-nav navbar-collapse">
            <ul class="nav" id="side-menu">

                <li>
                    <a href="#"><i class="fa fa-list"></i> Mantemiento<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li >
                            <a href="ControlEspecialidad?accion=listar" 
                               class=' <%= URL.contains("PagListaEspecialidad") || URL.contains("PagNuevaEspecialidad") ? "active" : ""%>'
                               >Especialidad</a>
                        </li>
                        <li>
                            <a href="ControlMedico?accion=listar"
                               class='<%= URL.contains("PagListaMedicos") || URL.contains("PagNuevoMedico") ? "active" : ""%>'
                               >Medicos</a>
                        </li>
                        <li>
                            <a href="ControlPaciente?accion=listar"
                               class='<%= URL.contains("PagListaPacientes") || URL.contains("PagNuevoPaciente") ? "active" : ""%>'
                               >Pacientes</a>
                        </li>
                        <li>
                            <a href="ControlMedicina?accion=listar"
                               class='<%= URL.contains("PagListaMedicina") || URL.contains("PagNuevaMedicina") ? "active" : ""%>'
                               >Medicina</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="#"><i class="fa fa-calendar-o"></i> Consulta<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="ControlConsulta?accion=nuevo">Registrar Consulta</a>
                        </li>
                        <li>
                            <a href="ControlConsulta?accion=lista_atender">Atender Consulta</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="#"><i class="fa fa-hospital-o"></i> Internamiento<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="ControlInternamiento?accion=nuevo">Registrar Internamiento</a>
                        </li>
                              <li>
                            <a href="ControlInternamiento?accion=lista_atender">Atender Internamiento</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="#"><i class="fa fa-calendar"></i> Historial<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="ControlConsulta?accion=historial">Historial Paciente</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>

</nav>