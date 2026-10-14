package com.mycompany.webclinica.modeloDAO;

import com.mycompany.webclinica.config.Conexion;
import com.mycompany.webclinica.modelo.*;
import java.sql.*;
import java.util.*;


public class RecetaDAO {

    private Connection cn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ArrayList<Receta> ListarRecetaPorConsulta(int idConsulta) {
        ArrayList<Receta> lista = new ArrayList<>();
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select nombre , cantidad , comentario "
                    + "from receta r inner join Medicina m "
                    + "on m.codigoMedicina = r.codigoMedicina "
                    + "where codigoConsulta = ?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idConsulta);
            rs = ps.executeQuery();

            while (rs.next()) {
                Receta c = new Receta();
                c.setNombre(rs.getString(1));
                c.setCantidad(rs.getInt(2));
                c.setComentario(rs.getString(3));
                lista.add(c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return lista;
    }

}
