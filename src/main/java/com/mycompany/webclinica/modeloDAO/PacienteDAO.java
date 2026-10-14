package com.mycompany.webclinica.modeloDAO;

import com.mycompany.webclinica.config.Conexion;
import com.mycompany.webclinica.modelo.*;
import java.sql.*;
import java.util.*;


public class PacienteDAO {

    private Connection cn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ArrayList<Paciente> ListarPacientes() {
        ArrayList<Paciente> lista = new ArrayList<>();
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "SELECT codigoPaciente,nombres,apellidos,telefono,"
                    + "tipoDocumento,documentoIdentidad ,  "
                    + "(select count(1) from consulta c where c.codigoPaciente = p.codigoPaciente and c.estadoConsulta='Atendido' ),"
                    + "(select count(1) from internamiento i where i.codigoPaciente = p.codigoPaciente and i.estado='Salida') "
                    + "FROM Paciente p WHERE eliminado = 0";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Paciente p = new Paciente();
                p.setCodigoPaciente(rs.getInt(1));
                p.setNombres(rs.getString(2));
                p.setApellidos(rs.getString(3));
                p.setTelefono(rs.getString(4));
                p.setTipoDocumento(rs.getString(5));
                p.setDocumentoIdentidad(rs.getString(6));
                p.setCantConsultas(rs.getInt(7));
                p.setCantInternamiento(rs.getInt(8));
                lista.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return lista;
    }

    public Paciente BuscarPorId(int id) {
        Paciente p = null;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "SELECT codigoPaciente,nombres,apellidos,telefono,"
                    + "tipoDocumento,documentoIdentidad "
                    + "FROM Paciente WHERE eliminado = 0 and codigoPaciente = ?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                p = new Paciente();
                p.setCodigoPaciente(rs.getInt(1));
                p.setNombres(rs.getString(2));
                p.setApellidos(rs.getString(3));
                p.setTelefono(rs.getString(4));
                p.setTipoDocumento(rs.getString(5));
                p.setDocumentoIdentidad(rs.getString(6));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return p;
    }

    public int Guardar(Paciente p) {
        int res = 0;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "insert into Paciente values (null,?,?,?,?,?,0)";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, p.getNombres());
            ps.setString(2, p.getApellidos());
            ps.setString(3, p.getTelefono());
            ps.setString(4, p.getTipoDocumento());
            ps.setString(5, p.getDocumentoIdentidad());

            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }

    public int ValidarDocumento(int id, String doc) {
        int res = 0;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "SELECT count(1) "
                    + "FROM Paciente WHERE eliminado = 0 "
                    + "and (codigoPaciente != ? or ?=0) "
                    + "and documentoIdentidad=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, id);
            ps.setString(3, doc);
            rs = ps.executeQuery();

            if (rs.next()) {
                res = rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return res;
    }

    public int Editar(Paciente p) {
        int res = 0;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "UPDATE Paciente SET nombres=? , apellidos=?,telefono=?,"
                    + "tipoDocumento=?,documentoIdentidad=? WHERE codigoPaciente=?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, p.getNombres());
            ps.setString(2, p.getApellidos());
            ps.setString(3, p.getTelefono());
            ps.setString(4, p.getTipoDocumento());
            ps.setString(5, p.getDocumentoIdentidad());
            ps.setInt(6, p.getCodigoPaciente());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }

    public int Eliminar(Paciente p) {
        int res = 0;
        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "UPDATE Paciente SET eliminado=1 WHERE codigoPaciente=?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, p.getCodigoPaciente());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }

}
