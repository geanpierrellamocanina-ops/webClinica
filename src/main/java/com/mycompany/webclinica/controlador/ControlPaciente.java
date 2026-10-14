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


public class ControlPaciente extends HttpServlet {

    private Util util = new Util();
    private PacienteDAO dao = new PacienteDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion") == null ? "" : request.getParameter("accion");

        if (accion.equalsIgnoreCase("nuevo")) {
            Nuevo(request, response);
        } else if (accion.equalsIgnoreCase("editar")) {
            Editar(request, response);
        } else if (accion.equalsIgnoreCase("guardar")) {
            Guardar(request, response);
        } else if (accion.equalsIgnoreCase("listar")) {
            Listar(request, response);
        } else if (accion.equalsIgnoreCase("eliminar")) {
            Eliminar(request, response);
        } else {
            response.sendRedirect("ControlPaciente?accion=listar");
        }
    }

    protected void Eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = util.requestInt(request, "id");

        Paciente p = dao.BuscarPorId(id);

        if (p != null) {
            int res = dao.Eliminar(p);

            if (res > 0) {
                request.getSession().setAttribute("success", "Los datos del paciente " + p.nomCompletos() + " se eliminaron correctamente.");
            } else {
                request.getSession().setAttribute("error", "No se ha podido eliminar datos con el  id " + id + ".");
            }

        } else {
            request.getSession().setAttribute("error", "No se ha encontraron datos a eliminar con el  id " + id + ".");
        }
        response.sendRedirect("ControlPaciente?accion=listar");
    }

    protected void Listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.getRequestDispatcher("PagListaPacientes.jsp").forward(request, response);
    }

    protected void Nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.setAttribute("titulo", "Nuevo Paciente");
        request.setAttribute("paciente", new Paciente());
        request.setAttribute("tipo_documentos", util.ListTipoDoc());

        request.getRequestDispatcher("PagNuevoPaciente.jsp").forward(request, response);
    }

    protected void Editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = util.requestInt(request, "id");

        Paciente p = dao.BuscarPorId(id);

        if (p != null) {
            request.setAttribute("titulo", "Editar Paciente");
            request.setAttribute("paciente", p);
            request.setAttribute("tipo_documentos", util.ListTipoDoc());

            request.getRequestDispatcher("PagNuevoPaciente.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "No se encontraron datos con el id " + id + ".");
            response.sendRedirect("ControlPaciente?accion=listar");
        }
    }

    protected void Guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Paciente p = new Paciente();
        p.setCodigoPaciente(util.requestInt(request, "codigo"));
        p.setNombres(util.requestStr(request, "nombres"));
        p.setApellidos(util.requestStr(request, "apellidos"));
        p.setTipoDocumento(util.requestStr(request, "tipo_documento"));
        p.setDocumentoIdentidad(util.requestStr(request, "documento"));
        p.setTelefono(util.requestStr(request, "telefono"));

        int res = dao.ValidarDocumento(p.getCodigoPaciente(), p.getDocumentoIdentidad());

        request.setAttribute("titulo", p.getCodigoPaciente() == 0 ? "Nuevo" : "Editar" + " Paciente");
        request.setAttribute("tipo_documentos", util.ListTipoDoc());
        request.setAttribute("paciente", p);

        if (res == 0) {
            if (p.getCodigoPaciente() == 0) {
                res = dao.Guardar(p);
            } else {
                res = dao.Editar(p);
            }

            if (res > 0) {
                request.getSession().setAttribute("success", "Los datos del paciente " + p.nomCompletos() + " se guardaron correctamente.");
                response.sendRedirect("ControlPaciente?accion=listar");
            } else {
                request.getSession().setAttribute("error", "Lo sentimos!! Los datos no se guardaron.Por favor verifique que todos los campos sean correctos.");
                request.getRequestDispatcher("PagNuevoPaciente.jsp").forward(request, response);
            }
        } else {

            request.getSession().setAttribute("error", "El # documento " + p.getDocumentoIdentidad() + " ya se encuentra en uso.");
            request.getRequestDispatcher("PagNuevoPaciente.jsp").forward(request, response);
        }
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
