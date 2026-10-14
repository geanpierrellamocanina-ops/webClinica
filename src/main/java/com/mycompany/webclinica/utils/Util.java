package  com.mycompany.webclinica.utils;

import jakarta.servlet.http.HttpServletRequest;

public class Util {

    public String[] ListTipoDoc() {
        String data[] = {"DNI", "Carnet de Extranjeria", "Pasaporte" };

        return data;
    }
    
       public String[] ListEstadoConsulta() {
        String data[] = {"Atendido" , "No Atendido"};

        return data;
    }

    public String requestStr(HttpServletRequest request, String nombre) {
        if (request.getParameter(nombre) != null) {
            return request.getParameter(nombre).trim();
        } else {
            return "";
        }
    }

    public int requestInt(HttpServletRequest request, String nombre) {
        try {
            return Integer.parseInt(request.getParameter(nombre));
        } catch (Exception ex) {
            return 0;
        }
    }
    
     public double requestDouble(HttpServletRequest request, String nombre) {
        try {
            return Double.parseDouble(request.getParameter(nombre));
        } catch (Exception ex) {
            return 0;
        }
    }
}
