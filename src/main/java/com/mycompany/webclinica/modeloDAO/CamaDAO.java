package com.mycompany.webclinica.modeloDAO;

import com.mycompany.webclinica.config.Conexion;
import com.mycompany.webclinica.modelo.*;
import java.sql.*;
import java.util.*;


public class CamaDAO {

    private Connection cn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ArrayList<Cama> ListarCamas() {
        ArrayList<Cama> lista = new ArrayList<>();
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "SELECT codigoCama, categoria, numeroCama, precioDia, estado FROM cama";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Cama c = new Cama();
                c.setCodigoCama(rs.getInt(1));
                c.setCategoria(rs.getString(2));
                c.setNumeroCama(rs.getString(3));
                c.setPrecioDia(rs.getDouble(4));
                c.setEstado(rs.getString(5));
                lista.add(c);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public Cama BuscarPorId(int id) {
        Cama c = null;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "SELECT codigoCama, categoria, numeroCama, precioDia, estado FROM cama WHERE codigoCama=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Cama();
                c.setCodigoCama(rs.getInt(1));
                c.setCategoria(rs.getString(2));
                c.setNumeroCama(rs.getString(3));
                c.setPrecioDia(rs.getDouble(4));
                c.setEstado(rs.getString(5));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } 
        return c;
    }
}
