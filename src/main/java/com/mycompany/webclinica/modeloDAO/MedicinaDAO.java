package com.mycompany.webclinica.modeloDAO;

import com.mycompany.webclinica.config.Conexion;
import com.mycompany.webclinica.modelo.*;
import java.sql.*;
import java.util.*;


public class MedicinaDAO {

    private Connection cn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ArrayList<Medicina> ListarMedicina() {
        ArrayList<Medicina> lista = new ArrayList<>();
        Connection cn = null;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select codigoMedicina,nombre,laboratorio "
                    + " from Medicina "
                    + "where eliminado = 0";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Medicina c = new Medicina();
                c.setCodigoMedicina(rs.getInt(1));
                c.setNombre(rs.getString(2));
                c.setLabotario(rs.getString(3));
                lista.add(c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public Medicina BuscarPorId(int id) {
        Medicina p = null;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select codigoMedicina,nombre,laboratorio "
                    + " from Medicina "
                    + "where eliminado = 0 and codigoMedicina=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Medicina();
                p.setCodigoMedicina(rs.getInt(1));
                p.setNombre(rs.getString(2));
                p.setLabotario(rs.getString(3));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return p;
    }

    public int Guardar(Medicina p) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "insert into Medicina values (null,?,?,0)";
            ps = cn.prepareStatement(sql);
            ps.setString(1, p.getLabotario());
            ps.setString(2, p.getNombre());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }

    public int ValidarExistencia(int id, String nom) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "SELECT count(1) "
                    + "FROM Medicina WHERE eliminado = 0 "
                    + "and (codigoMedicina != ? or ?=0) "
                    + "and nombre=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, id);
            ps.setString(3, nom);
            rs = ps.executeQuery();

            if (rs.next()) {
                res = rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }

    public int Editar(Medicina p) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "UPDATE Medicina SET nombre=? , laboratorio= ?"
                    + " WHERE codigoMedicina=?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getLabotario());
            ps.setInt(3, p.getCodigoMedicina());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return res;
    }

    public int Eliminar(Medicina p) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "UPDATE Medicina SET eliminado=1 WHERE codigoMedicina=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, p.getCodigoMedicina());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return res;
    }
}
