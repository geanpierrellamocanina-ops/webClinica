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
import java.io.PrintWriter;


public class ControlSesionReceta extends HttpServlet {

    private MedicinaDAO daoMedicina = new MedicinaDAO();
    private Util util = new Util();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion") == null ? "" : request.getParameter("accion");

        if (accion.equalsIgnoreCase("agregar")) {
            Agregar(request, response);
        } else if (accion.equalsIgnoreCase("quitar")) {
            Quitar(request, response);
        }
    }

    protected void Quitar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        boolean estatus = false;
        try {
            ArrayList<Receta> data = ObtenerMedicina(request);
            int indice = util.requestInt(request, "indice");

            if (data.size() >= 0 && indice<data.size()) {
                data.remove(indice);
                request.getSession().setAttribute("data", data);
                estatus = true;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        out.print(estatus);
    }

    protected void Agregar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        boolean estatus = false;
        try {
            ArrayList<Receta> data = ObtenerMedicina(request);

            Receta r = new Receta();
            r.setCodigoMedicina(util.requestInt(request, "idMedicina"));
            r.setCantidad(util.requestInt(request, "cantidad"));
            r.setComentario(util.requestStr(request, "comentario"));

            Medicina m = daoMedicina.BuscarPorId(r.getCodigoMedicina());

            r.setNombre(m.getNombre());
            data.add(r);

            estatus = true;

            request.getSession().setAttribute("data", data);
        } catch (Exception ex) {
        }

        out.print(estatus);
    }

    public ArrayList<Receta> ObtenerMedicina(HttpServletRequest request) {
        ArrayList<Receta> data;

        if (request.getSession().getAttribute("data") == null) {
            data = new ArrayList<>();
        } else {
            data = (ArrayList<Receta>) request.getSession().getAttribute("data");
        }
        return data;
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
