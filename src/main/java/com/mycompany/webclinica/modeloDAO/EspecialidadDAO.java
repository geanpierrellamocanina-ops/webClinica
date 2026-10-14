package com.mycompany.webclinica.modeloDAO;

import com.mycompany.webclinica.config.Conexion;
import com.mycompany.webclinica.modelo.*;
import java.sql.*;
import java.util.*;


public class EspecialidadDAO {

    private Connection cn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ArrayList<Especialidad> ListarEspecialidad() {
        ArrayList<Especialidad> lista = new ArrayList<>();

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "SELECT codigoEspecialidad , nombre,precio "
                    + "FROM Especialidad "
                    + "WHERE eliminado = 0 order by nombre";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Especialidad c = new Especialidad();
                c.setCodigoEspecialidad(rs.getInt(1));
                c.setNombre(rs.getString(2));
                c.setPrecio(rs.getDouble(3));
                lista.add(c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public Especialidad BuscarPorId(int id) {
        Especialidad p = null;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "SELECT codigoEspecialidad , nombre,precio "
                    + "FROM Especialidad "
                    + "WHERE eliminado = 0 and codigoEspecialidad =?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Especialidad();
                p.setCodigoEspecialidad(rs.getInt(1));
                p.setNombre(rs.getString(2));
                p.setPrecio(rs.getDouble(3));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return p;
    }

    public int Guardar(Especialidad p) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "insert into Especialidad values (null,?,?,0)";
            ps = cn.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setDouble(2, p.getPrecio());
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
                    + "FROM Especialidad WHERE eliminado = 0 "
                    + "and (codigoEspecialidad != ? or ?=0) "
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

    public int Editar(Especialidad p) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "UPDATE Especialidad SET nombre=? , precio= ?"
                    + " WHERE codigoEspecialidad=?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setDouble(2, p.getPrecio());
            ps.setInt(3, p.getCodigoEspecialidad());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }

    public int Eliminar(Especialidad p) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "UPDATE Especialidad SET eliminado=1 WHERE codigoEspecialidad=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, p.getCodigoEspecialidad());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }
}
