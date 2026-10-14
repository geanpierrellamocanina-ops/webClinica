package com.mycompany.webclinica.modeloDAO;

import com.mycompany.webclinica.config.Conexion;
import com.mycompany.webclinica.modelo.*;
import java.sql.*;
import java.util.*;


public class InternamientoDAO {

    private Connection cn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public int Guardar(Internamiento c) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "insert into Internamiento(codigoPaciente,codigoMedico,codigoCama,"
                    + "fechaIngreso,horaIngreso,estado) values(?,?,?,?,?,?)";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, c.getCodigoPaciente());
            ps.setInt(2, c.getCodigoMedico());
            ps.setInt(3, c.getCodigoCama());
            ps.setString(4, c.getFechaIngreso());
            ps.setString(5, c.getHoraIngreso());
            ps.setString(6, c.getEstado());
            res = ps.executeUpdate();

            if (res > 0) {
                sql = "update Cama set estado = ? where codigoCama=?";
                ps = cn.prepareStatement(sql);
                ps.setString(1, "Ocupado");
                ps.setInt(2, c.getCodigoCama());
                res = ps.executeUpdate();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return res;
    }

    public ArrayList<Internamiento> ListarFiltroPorEstado(String estado, String inicio, String fin) {
        ArrayList<Internamiento> lista = new ArrayList<>();

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select c.codigoInternamiento, p.codigoPaciente, CONCAT(p.nombres, CONCAT(' ', p.apellidos)), \n"
                    + "e.nombre, m.codigoMedico, CONCAT(m.nombres, CONCAT(' ', m.apellidos)), \n"
                    + "c.fechaIngreso,horaIngreso,fechaSalida,horaSalida,totalPagar,c.estado,observacion \n"
                    + "from Internamiento c \n"
                    + "inner join paciente p \n"
                    + "on c.codigoPaciente=p.codigoPaciente \n"
                    + "inner join Medico m \n"
                    + "on m.codigoMedico = c.codigoMedico \n"
                    + "inner join especialidad e \n"
                    + "on e.codigoEspecialidad = m.codigoEspecialidad \n"
                    + "where c.estado = ? and c.fechaIngreso between ? and ? \n"
                    + "order by c.fechaIngreso asc , horaIngreso asc";
            ps = cn.prepareStatement(sql);
            ps.setString(1, estado);
            ps.setString(2, inicio);
            ps.setString(3, fin);
            rs = ps.executeQuery();

            while (rs.next()) {
                Internamiento c = new Internamiento();
                c.setCodigoInternamiento(rs.getInt(1));
                c.setCodigoPaciente(rs.getInt(2));
                c.setNomPac(rs.getString(3));
                c.setNomEsp(rs.getString(4));
                c.setCodigoMedico(rs.getInt(5));
                c.setNomMed(rs.getString(6));
                c.setFechaIngreso(rs.getString(7));
                c.setHoraIngreso(rs.getString(8));
                c.setFechaSalida(rs.getString(9));
                c.setHoraSalida(rs.getString(10));
                c.setTotalPagar(rs.getDouble(11));
                c.setEstado(rs.getString(12));
                c.setObservacion(rs.getString(13));
                lista.add(c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return lista;
    }

    public ArrayList<Internamiento> ListarPorEstado(String estado, int idPac) {
        ArrayList<Internamiento> lista = new ArrayList<>();

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select c.codigoInternamiento, p.codigoPaciente, CONCAT(p.nombres, CONCAT(' ', p.apellidos)), \n"
                    + "e.nombre, m.codigoMedico, CONCAT(m.nombres, CONCAT(' ', m.apellidos)), \n"
                    + "c.fechaIngreso,horaIngreso,fechaSalida,horaSalida,totalPagar,c.estado,observacion \n"
                    + "from Internamiento c \n"
                    + "inner join paciente p \n"
                    + "on c.codigoPaciente=p.codigoPaciente \n"
                    + "inner join Medico m \n"
                    + "on m.codigoMedico = c.codigoMedico \n"
                    + "inner join especialidad e \n"
                    + "on e.codigoEspecialidad = m.codigoEspecialidad \n"
                    + "where c.estado = ? and p.codigoPaciente=? \n"
                    + "order by c.fechaSalida asc , horaSalida asc";
            ps = cn.prepareStatement(sql);
            ps.setString(1, estado);
            ps.setInt(2, idPac);
            rs = ps.executeQuery();

            while (rs.next()) {
                Internamiento c = new Internamiento();
                c.setCodigoInternamiento(rs.getInt(1));
                c.setCodigoPaciente(rs.getInt(2));
                c.setNomPac(rs.getString(3));
                c.setNomEsp(rs.getString(4));
                c.setCodigoMedico(rs.getInt(5));
                c.setNomMed(rs.getString(6));
                c.setFechaIngreso(rs.getString(7));
                c.setHoraIngreso(rs.getString(8));
                c.setFechaSalida(rs.getString(9));
                c.setHoraSalida(rs.getString(10));
                c.setTotalPagar(rs.getDouble(11));
                c.setEstado(rs.getString(12));
                c.setObservacion(rs.getString(13));
                lista.add(c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public Internamiento BuscarPorId(String estado, int id) {
        Internamiento c = null;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select c.codigoInternamiento, p.codigoPaciente, CONCAT(p.nombres, CONCAT(' ', p.apellidos)), \n"
                    + "e.nombre, m.codigoMedico, CONCAT(m.nombres, CONCAT(' ', m.apellidos)), \n"
                    + "c.fechaIngreso,horaIngreso,fechaSalida,horaSalida,totalPagar,c.estado,observacion, c.codigoCama \n"
                    + "from Internamiento c \n"
                    + "inner join paciente p \n"
                    + "on c.codigoPaciente=p.codigoPaciente \n"
                    + "inner join Medico m \n"
                    + "on m.codigoMedico = c.codigoMedico \n"
                    + "inner join especialidad e \n"
                    + "on e.codigoEspecialidad = m.codigoEspecialidad \n"
                    + "where c.estado = ? and c.codigoInternamiento=?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, estado);
            ps.setInt(2, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Internamiento();
                c.setCodigoInternamiento(rs.getInt(1));
                c.setCodigoPaciente(rs.getInt(2));
                c.setNomPac(rs.getString(3));
                c.setNomEsp(rs.getString(4));
                c.setCodigoMedico(rs.getInt(5));
                c.setNomMed(rs.getString(6));
                c.setFechaIngreso(rs.getString(7));
                c.setHoraIngreso(rs.getString(8));
                c.setFechaSalida(rs.getString(9));
                c.setHoraSalida(rs.getString(10));
                c.setTotalPagar(rs.getDouble(11));
                c.setEstado(rs.getString(12));
                c.setObservacion(rs.getString(13));
                c.setCodigoCama(rs.getInt(14));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return c;
    }

    public Internamiento ValidarSalida(Internamiento obj) {
        Internamiento c = null;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select count(1) , DATEDIFF(?, fechaIngreso)\n"
                    + "from Internamiento\n"
                    + "where (fechaIngreso =? and horaIngreso <=?) "
                    + "or fechaIngreso<? \n"
                    + "and codigoInternamiento= ?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, obj.getFechaSalida());
            ps.setString(2, obj.getFechaSalida());
            ps.setString(3, obj.getHoraSalida());
            ps.setString(4, obj.getFechaSalida());
            ps.setInt(5, obj.getCodigoInternamiento());
            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Internamiento();
                c.setCantidad(rs.getInt(1));
                c.setDiasInt(rs.getInt(2));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return c;
    }

    public int DarDeAlta(Internamiento c) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "update Internamiento set fechaSalida = ?,horaSalida=?,totalPagar=?, "
                    + "estado=?,observacion=? "
                    + "where codigoInternamiento=?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, c.getFechaSalida());
            ps.setString(2, c.getHoraSalida());
            ps.setDouble(3, c.getTotalPagar());
            ps.setString(4, c.getEstado());
            ps.setString(5, c.getObservacion());
            ps.setInt(6, c.getCodigoInternamiento());
            res = ps.executeUpdate();

            if (res > 0) {
                sql = "update Cama set estado = ? where codigoCama=?";
                ps = cn.prepareStatement(sql);
                ps.setString(1, "Disponible");
                ps.setInt(2, c.getCodigoCama());
                res = ps.executeUpdate();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }
}
