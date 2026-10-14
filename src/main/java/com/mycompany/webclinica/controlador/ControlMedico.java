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


public class ControlMedico extends HttpServlet {

    private Util util = new Util();
    private MedicoDAO daoMedico = new MedicoDAO();

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
            response.sendRedirect("ControlMedico?accion=listar");
        }
    }

    protected void Eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = util.requestInt(request, "id");

        Medico p = daoMedico.BuscarPorId(id);

        if (p != null) {
            int res = daoMedico.Eliminar(p);

            if (res > 0) {
                request.getSession().setAttribute("success", "Los datos del medico " + p.getNombre() + " se eliminaron correctamente.");
            } else {
                request.getSession().setAttribute("error", "No se ha podido eliminar datos con el  id " + id + ".");
            }

        } else {
            request.getSession().setAttribute("error", "No se ha encontraron datos a eliminar con el  id " + id + ".");
        }
        response.sendRedirect("ControlMedico?accion=listar");
    }

    protected void Listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.getRequestDispatcher("PagListaMedicos.jsp").forward(request, response);
    }

    protected void Nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.setAttribute("titulo", "Nuevo Medico");
        request.setAttribute("medico", new Medico());
        request.getRequestDispatcher("PagNuevoMedico.jsp").forward(request, response);
    }

    protected void Editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = util.requestInt(request, "id");

        Medico p = daoMedico.BuscarPorId(id);

        if (p != null) {
            request.setAttribute("titulo", "Editar Medico");
            request.setAttribute("medico", p);
            request.getRequestDispatcher("PagNuevoMedico.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "No se encontraron datos con el id " + id + ".");
            response.sendRedirect("ControlMedico?accion=listar");
        }
    }

    protected void Guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Medico p = new Medico();
        p.setCodigoMedico(util.requestInt(request, "codigo"));
        p.setNombresMed(util.requestStr(request, "nombres"));
        p.setApellidosMed(util.requestStr(request, "apellidos"));
        p.setTelefono(util.requestStr(request, "telefono"));
        p.setCorreo(util.requestStr(request, "correo"));
        p.setCodigoEspecialidad(util.requestInt(request, "especialidad"));

        System.out.println(p.toString());
        int res = daoMedico.ValidarExistencia(p.getCodigoMedico(), p.getCorreo());

        request.setAttribute("titulo", p.getCodigoMedico() == 0 ? "Nuevo" : "Editar" + " Medico");
        request.setAttribute("medico", p);

        if (res == 0) {
            if (p.getCodigoMedico() == 0) {
                res = daoMedico.Guardar(p);
            } else {
                res = daoMedico.Editar(p);
            }

            if (res > 0) {
                request.getSession().setAttribute("success", "Los datos del medico " + p.nomCompletos() + " se guardaron correctamente.");
                response.sendRedirect("ControlMedico?accion=listar");
            } else {
                request.getSession().setAttribute("error", "Lo sentimos!! Los datos no se guardaron.Por favor verifique que todos los campos sean correctos.");
                request.getRequestDispatcher("PagNuevoMedico.jsp").forward(request, response);
            }
        } else {
            request.getSession().setAttribute("error", "El correo " + p.getCorreo() + " no se encuentra disponible.");
            request.getRequestDispatcher("PagNuevoMedico.jsp").forward(request, response);
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
