package com.mycompany.webclinica.modeloDAO;

import com.mycompany.webclinica.config.Conexion;
import com.mycompany.webclinica.modelo.*;
import java.sql.*;
import java.util.*;


public class MedicoDAO {

    private Connection cn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ArrayList<Medico> ListarMedicos() {
        ArrayList<Medico> lista = new ArrayList<>();
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select e.codigoEspecialidad, IF(e.eliminado = 1 , '' ,e.nombre), m.codigoMedico,nombres,"
                    + "apellidos,telefono,correo,fechaIngreso,e.precio "
                    + "from Medico m inner join Especialidad e "
                    + "on e.codigoEspecialidad = m.codigoEspecialidad "
                    + "where m.eliminado = 0";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Medico c = new Medico();
                c.setCodigoEspecialidad(rs.getInt(1));
                c.setNombre(rs.getString(2));
                c.setCodigoMedico(rs.getInt(3));
                c.setNombresMed(rs.getString(4));
                c.setApellidosMed(rs.getString(5));
                c.setTelefono(rs.getString(6));
                c.setCorreo(rs.getString(7));
                c.setFechaIngreso(rs.getString(8));
                c.setPrecio(rs.getDouble(9));
                lista.add(c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public Medico BuscarPorId(int id) {
        Medico c = null;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select e.codigoEspecialidad, IF(e.eliminado = 1 , '' ,e.nombre), m.codigoMedico,nombres,"
                    + "apellidos,telefono,correo,fechaIngreso "
                    + "from Medico m inner join Especialidad e "
                    + "on e.codigoEspecialidad = m.codigoEspecialidad "
                    + "where m.eliminado = 0 and m.codigoMedico=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Medico();
                c.setCodigoEspecialidad(rs.getInt(1));
                c.setNombre(rs.getString(2));
                c.setCodigoMedico(rs.getInt(3));
                c.setNombresMed(rs.getString(4));
                c.setApellidosMed(rs.getString(5));
                c.setTelefono(rs.getString(6));
                c.setCorreo(rs.getString(7));
                c.setFechaIngreso(rs.getString(8));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return c;
    }

    public int Guardar(Medico p) {
        int res = 0;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "insert into Medico values (null,?,?,?,?,?,now(),0)";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, p.getCodigoEspecialidad());
            ps.setString(2, p.getNombresMed());
            ps.setString(3, p.getApellidosMed());
            ps.setString(4, p.getTelefono());
            ps.setString(5, p.getCorreo());
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
                    + "FROM Medico WHERE eliminado = 0 "
                    + "and (codigoMedico != ? or ?=0) "
                    + "and correo=?";
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

    public int Editar(Medico p) {
        int res = 0;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "update Medico set codigoEspecialidad=?, nombres=? , apellidos=?,telefono=?,correo=?"
                    + " where codigoMedico=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, p.getCodigoEspecialidad());
            ps.setString(2, p.getNombresMed());
            ps.setString(3, p.getApellidosMed());
            ps.setString(4, p.getTelefono());
            ps.setString(5, p.getCorreo());
            ps.setInt(6, p.getCodigoMedico());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }

    public int Eliminar(Medico m) {
        int res = 0;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "update Medico set eliminado=1 where codigoMedico=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, m.getCodigoMedico());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }
}
