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
public class ControlMedicina extends HttpServlet {

    private Util util = new Util();
    private MedicinaDAO dao = new MedicinaDAO();

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
            response.sendRedirect("ControlMedicina?accion=listar");
        }
    }

    protected void Eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = util.requestInt(request, "id");

        Medicina p = dao.BuscarPorId(id);

        if (p != null) {
            int res = dao.Eliminar(p);

            if (res > 0) {
                request.getSession().setAttribute("success", "Los datos de la medicina " + p.getNombre() + " se eliminaron correctamente.");
            } else {
                request.getSession().setAttribute("error", "No se ha podido eliminar datos con el  id " + id + ".");
            }

        } else {
            request.getSession().setAttribute("error", "No se ha encontraron datos a eliminar con el  id " + id + ".");
        }
        response.sendRedirect("ControlMedicina?accion=listar");
    }

    protected void Listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.getRequestDispatcher("PagListaMedicina.jsp").forward(request, response);
    }

    protected void Nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.setAttribute("titulo", "Nueva Medicina");
        request.setAttribute("medicina", new Medicina());
        request.getRequestDispatcher("PagNuevaMedicina.jsp").forward(request, response);
    }

    protected void Editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = util.requestInt(request, "id");

        Medicina p = dao.BuscarPorId(id);

        if (p != null) {
            request.setAttribute("titulo", "Editar Medicina");
            request.setAttribute("medicina", p);
            request.getRequestDispatcher("PagNuevaMedicina.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "No se encontraron datos con el id " + id + ".");
            response.sendRedirect("ControlMedicina?accion=listar");
        }
    }

    protected void Guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Medicina p = new Medicina();
        p.setCodigoMedicina(util.requestInt(request, "codigo"));
        p.setNombre(util.requestStr(request, "nombre"));
        p.setLabotario(util.requestStr(request, "laboratorio"));

        int res = dao.ValidarExistencia(p.getCodigoMedicina(), p.getNombre());

        request.setAttribute("titulo", p.getCodigoMedicina() == 0 ? "Nueva" : "Editar" + " Medicina");
        request.setAttribute("medicina", p);

        if (res == 0) {
            if (p.getCodigoMedicina() == 0) {
                res = dao.Guardar(p);
            } else {
                res = dao.Editar(p);
            }

            if (res > 0) {
                request.getSession().setAttribute("success", "Los datos de la medicina " + p.getNombre() + " se guardaron correctamente.");
                response.sendRedirect("ControlMedicina?accion=listar");
            } else {
                request.getSession().setAttribute("error", "Lo sentimos!! Los datos no se guardaron.Por favor verifique que todos los campos sean correctos.");
                request.getRequestDispatcher("PagNuevaMedicina.jsp").forward(request, response);
            }
        } else {

            request.getSession().setAttribute("error", "La medicina " + p.getNombre() + " ya se encuentra en uso.");
            request.getRequestDispatcher("PagNuevaMedicina.jsp").forward(request, response);
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
