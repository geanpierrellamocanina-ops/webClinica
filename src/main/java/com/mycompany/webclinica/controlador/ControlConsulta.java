/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.webclinica.controlador;

import com.mycompany.webclinica.modelo.*;
import com.mycompany.webclinica.modeloDAO.*;
import com.mycompany.webclinica.utils.*;
import java.util.ArrayList;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ControlConsulta extends HttpServlet {

    private Util util = new Util();
    private ConsultaDAO daoCons = new ConsultaDAO();
    private PacienteDAO daoPac = new PacienteDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF8");

        String accion = request.getParameter("accion") == null ? "" : request.getParameter("accion");

        if (accion.equalsIgnoreCase("nuevo")) {
            Nuevo(request, response);
        } else if (accion.equalsIgnoreCase("guardar")) {
            Guardar(request, response);
        } else if (accion.equalsIgnoreCase("lista_atender")) {
            ListarAtender(request, response);
        } else if (accion.equalsIgnoreCase("atender")) {
            Atender(request, response);
        } else if (accion.equalsIgnoreCase("historial")) {
            ListarHistorial(request, response);
        } else if (accion.equalsIgnoreCase("consulta_atender")) {
            ConsultaAtender(request, response);
        } else {
            response.sendRedirect("ControlConsulta?accion=lista_atender");
        }
    }

    protected void ConsultaAtender(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ArrayList<Receta> listaRecetas = (ArrayList<Receta>) request.getSession().getAttribute("data");
        Consulta r = new Consulta();
        r.setCodigoConsulta(util.requestInt(request, "codigo"));
        r.setObservacion(util.requestStr(request, "observacion"));
        r.setEstadoConsulta("Atendido");

        String pagina = "";

        int res = daoCons.AtenderConsulta(r, listaRecetas);

        if (res > 0) {
            request.getSession().setAttribute("success", "La consulta con id " + r.getCodigoConsulta() + " se atendio correctamente.");
            request.getSession().setAttribute("data", new ArrayList<Receta>());
            pagina = "ControlConsulta?accion=lista_atender";
        } else {
            request.getSession().setAttribute("error", "No se encontró atender consulta.");
            pagina = "ControlConsulta?accion=atender&id=" + r.getCodigoConsulta();
        }

        response.sendRedirect(pagina);
    }

    protected void ListarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ArrayList<Paciente> lista = daoPac.ListarPacientes();

        request.setAttribute("pacientes", lista);

        request.getRequestDispatcher("PagListaHistorialPacientes.jsp").forward(request, response);
    }

    protected void ListarAtender(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String inicio = util.requestStr(request, "inicio");
        String fin = util.requestStr(request, "fin");
        String estado = "No Atendido";

        ArrayList<Consulta> lista = daoCons.ListarFiltroPorEstado(estado, inicio, fin);
        request.setAttribute("inicio", inicio);
        request.setAttribute("fin", fin);
        request.setAttribute("lista", lista);

        request.getRequestDispatcher("PagListaAtenderConsulta.jsp").forward(request, response);
    }

    protected void Atender(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = util.requestInt(request, "id");
        Consulta c = daoCons.BuscarPorId("No Atendido", id);
        if (c != null) {
            request.setAttribute("consulta", c);
            request.getRequestDispatcher("PagAtenderConsulta.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "No se encontró consulta por atender con el id " + id + ".");

            response.sendRedirect("ControlConsulta?accion=listar_atender");
        }

    }

    protected void Guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Consulta c = new Consulta();
        c.setCodigoMedico(util.requestInt(request, "codMedico"));
        c.setCodigoPaciente(util.requestInt(request, "codPaciente"));
        c.setFechaAtencion(util.requestStr(request, "fecha"));
        c.setHoraAtencion(util.requestStr(request, "hora"));
        c.setTotalPagar(util.requestDouble(request, "precio"));
        c.setEstadoConsulta(util.ListEstadoConsulta()[1]); //No atendido
        c.setNomMed(util.requestStr(request, "nomMed"));
        c.setNomPac(util.requestStr(request, "nomPac"));

        int res = daoCons.Guardar(c);

        if (res > 0) {
            request.getSession().setAttribute("success", "La consulta para el paciente " + c.getNomPac() + " fue registrada correctamente.");

            response.sendRedirect("ControlConsulta?accion=nuevo");
        } else {
            request.setAttribute("consulta", c);
            request.getSession().setAttribute("error", "Lo sentimos!! Los datos no se guardaron.Por favor verifique que todos los campos sean correctos.");
            request.getRequestDispatcher("PagNuevaConsulta.jsp").forward(request, response);
        }

    }

    protected void Nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.setAttribute("consulta", new Consulta());
        request.getRequestDispatcher("PagNuevaConsulta.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
