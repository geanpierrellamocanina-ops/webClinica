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

public class ControlInternamiento extends HttpServlet {

    private Util util = new Util();
    private InternamientoDAO daoInt = new InternamientoDAO();
    private CamaDAO daoCama = new CamaDAO();

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
        } else if (accion.equalsIgnoreCase("internamiento_atender")) {
            InternamientoAtender(request, response);
        }

    }

    protected void InternamientoAtender(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int id = util.requestInt(request, "codigo");
        Internamiento c = daoInt.BuscarPorId("Entrada", id);
       c.setFechaSalida(util.requestStr(request, "fecha_salida"));
     c.setHoraSalida(util.requestStr(request, "hora_salida"));
        c.setObservacion(util.requestStr(request, "observacion"));
        c.setEstado("Salida");
        
        Internamiento aux = daoInt.ValidarSalida(c);

        request.setAttribute("internamiento", c);

        if (aux != null && aux.getCantidad() > 0) {
            System.out.println(c.toString());
            Cama objCama = daoCama.BuscarPorId(c.getCodigoCama());
            c.setTotalPagar((aux.getDiasInt() == 0 ? 1: aux.getDiasInt()) * objCama.getPrecioDia() );
            int res = daoInt.DarDeAlta(c);

            if (res > 0) {
                request.getSession().setAttribute("success", "Los datos del internamiento con id " + c.getCodigoInternamiento() + " se retiró correctamente.");

                response.sendRedirect("ControlInternamiento?accion=lista_atender");
            } else {
                request.getSession().setAttribute("error", "Lo sentimos!! Ha ocurrido un error interno al querer dar de alta al paciente.");
                request.getRequestDispatcher("PagAtenderInternamiento.jsp").forward(request, response);
            }
        } else {

            request.getSession().setAttribute("error", "Lo sentimos!! Verifique que la fecha y hora de salida sea superior a la fecha y hora de ingreso.");
            request.getRequestDispatcher("PagAtenderInternamiento.jsp").forward(request, response);
        }

    }

    protected void Atender(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = util.requestInt(request, "id");
        Internamiento c = daoInt.BuscarPorId("Entrada", id);
        if (c != null) {
            request.setAttribute("internamiento", c);
            request.getRequestDispatcher("PagAtenderInternamiento.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "No se encontró datos del internamiento por atender con el id " + id + ".");

            response.sendRedirect("ControlInternamiento?accion=lista_atender");
        }

    }

    protected void ListarAtender(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String inicio = util.requestStr(request, "inicio");
        String fin = util.requestStr(request, "fin");
        String estado = "Entrada";

        ArrayList<Internamiento> lista = daoInt.ListarFiltroPorEstado(estado, inicio, fin);

        request.setAttribute("inicio", inicio);
        request.setAttribute("fin", fin);
        request.setAttribute("lista", lista);

        request.getRequestDispatcher("PagListaAtenderInternamiento.jsp").forward(request, response);
    }

    protected void Guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Internamiento c = new Internamiento();
        c.setCodigoMedico(util.requestInt(request, "codMedico"));
        c.setCodigoPaciente(util.requestInt(request, "codPaciente"));
        c.setCodigoCama(util.requestInt(request, "codCama"));
        c.setFechaIngreso(util.requestStr(request, "fecha"));
        c.setHoraIngreso(util.requestStr(request, "hora"));
        c.setTotalPagar(util.requestDouble(request, "precio"));
        c.setEstado("Entrada");
        c.setNomMed(util.requestStr(request, "nomMed"));
        c.setNomPac(util.requestStr(request, "nomPac"));
        c.setNomCama(util.requestStr(request, "nomCama"));

        int res = daoInt.Guardar(c);

        if (res > 0) {
            request.getSession().setAttribute("success", "El registro del paciente " + c.getNomPac() + " para el internamiento se realizó correctamente.");

            response.sendRedirect("ControlInternamiento?accion=nuevo");
        } else {
            request.setAttribute("internamiento", c);
            request.getSession().setAttribute("error", "Lo sentimos!! Los datos no se guardaron.Por favor verifique que todos los campos sean correctos.");
            request.getRequestDispatcher("PagNuevoInternamiento.jsp").forward(request, response);
        }
    }

    protected void Nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.setAttribute("internamiento", new Internamiento());
        request.getRequestDispatcher("PagNuevoInternamiento.jsp").forward(request, response);
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
