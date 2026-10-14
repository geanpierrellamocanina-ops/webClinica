package com.mycompany.webclinica.modeloDAO;

import com.mycompany.webclinica.config.Conexion;
import com.mycompany.webclinica.modelo.*;
import java.sql.*;
import java.util.*;


public class ConsultaDAO {

    private Connection cn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public int Guardar(Consulta c) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "insert into Consulta(codigoPaciente,codigoMedico,fechaRegistro,"
                    + "fechaAtencion,horaAtencion,totalPagar,estadoConsulta) "
                    + "values (?,?,now(),?,?,?,?)";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, c.getCodigoPaciente());
            ps.setInt(2, c.getCodigoMedico());
            ps.setString(3, c.getFechaAtencion());
            ps.setString(4, c.getHoraAtencion());
            ps.setDouble(5, c.getTotalPagar());
            ps.setString(6, c.getEstadoConsulta());
            res = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return res;
    }

    public ArrayList<Consulta> ListarFiltroPorEstado(String estado, String inicio, String fin) {
        ArrayList<Consulta> lista = new ArrayList<>();

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select c.codigoConsulta, p.codigoPaciente, CONCAT(p.nombres, CONCAT(' ', p.apellidos)), "
                    + "e.nombre, m.codigoMedico, CONCAT(m.nombres, CONCAT(' ', m.apellidos)), "
                    + "fechaRegistro,fechaAtencion,horaAtencion,totalPagar,estadoConsulta,observacion "
                    + "from Consulta c "
                    + "inner join paciente p "
                    + "on c.codigoPaciente=p.codigoPaciente "
                    + "inner join Medico m "
                    + "on m.codigoMedico = c.codigoMedico "
                    + "inner join especialidad e "
                    + "on e.codigoEspecialidad = m.codigoEspecialidad "
                    + "where estadoConsulta = ? and fechaAtencion between ? and ? "
                    + "order by fechaAtencion asc , horaAtencion asc";
            ps = cn.prepareStatement(sql);
            ps.setString(1, estado);
            ps.setString(2, inicio);
            ps.setString(3, fin);
            rs = ps.executeQuery();

            while (rs.next()) {
                Consulta c = new Consulta();
                c.setCodigoConsulta(rs.getInt(1));
                c.setCodigoPaciente(rs.getInt(2));
                c.setNomPac(rs.getString(3));
                c.setNomEsp(rs.getString(4));
                c.setCodigoMedico(rs.getInt(5));
                c.setNomMed(rs.getString(6));
                c.setFechaRegistro(rs.getString(7));
                c.setFechaAtencion(rs.getString(8));
                c.setHoraAtencion(rs.getString(9));
                c.setTotalPagar(rs.getDouble(10));
                c.setEstadoConsulta(rs.getString(11));
                c.setObservacion(rs.getString(12));
                lista.add(c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return lista;
    }

    public ArrayList<Consulta> ListarPorEstado(String estado, int codigoPac) {
        ArrayList<Consulta> lista = new ArrayList<>();

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select c.codigoConsulta, p.codigoPaciente, CONCAT(p.nombres, CONCAT(' ', p.apellidos)), "
                    + "e.nombre, m.codigoMedico, CONCAT(m.nombres, CONCAT(' ', m.apellidos)), "
                    + "fechaRegistro,fechaAtencion,horaAtencion,totalPagar,estadoConsulta,observacion "
                    + "from Consulta c "
                    + "inner join paciente p "
                    + "on c.codigoPaciente=p.codigoPaciente "
                    + "inner join Medico m "
                    + "on m.codigoMedico = c.codigoMedico "
                    + "inner join especialidad e "
                    + "on e.codigoEspecialidad = m.codigoEspecialidad "
                    + "where estadoConsulta = ? and p.codigoPaciente =? "
                    + "order by fechaAtencion asc , horaAtencion asc";
            ps = cn.prepareStatement(sql);
            ps.setString(1, estado);
            ps.setInt(2, codigoPac);
            rs = ps.executeQuery();

            while (rs.next()) {
                Consulta c = new Consulta();
                c.setCodigoConsulta(rs.getInt(1));
                c.setCodigoPaciente(rs.getInt(2));
                c.setNomPac(rs.getString(3));
                c.setNomEsp(rs.getString(4));
                c.setCodigoMedico(rs.getInt(5));
                c.setNomMed(rs.getString(6));
                c.setFechaRegistro(rs.getString(7));
                c.setFechaAtencion(rs.getString(8));
                c.setHoraAtencion(rs.getString(9));
                c.setTotalPagar(rs.getDouble(10));
                c.setEstadoConsulta(rs.getString(11));
                c.setObservacion(rs.getString(12));
                lista.add(c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public Consulta BuscarPorId(String estado, int id) {
        Consulta c = null;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "select c.codigoConsulta, p.codigoPaciente, CONCAT(p.nombres, CONCAT(' ', p.apellidos)), "
                    + "e.nombre, m.codigoMedico, CONCAT(m.nombres, CONCAT(' ', m.apellidos)), "
                    + "fechaRegistro,fechaAtencion,horaAtencion,totalPagar,estadoConsulta,observacion "
                    + "from Consulta c "
                    + "inner join paciente p "
                    + "on c.codigoPaciente=p.codigoPaciente "
                    + "inner join Medico m "
                    + "on m.codigoMedico = c.codigoMedico "
                    + "inner join especialidad e "
                    + "on e.codigoEspecialidad = m.codigoEspecialidad "
                    + "where estadoConsulta = ? and c.codigoConsulta=?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, estado);
            ps.setInt(2, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Consulta();
                c.setCodigoConsulta(rs.getInt(1));
                c.setCodigoPaciente(rs.getInt(2));
                c.setNomPac(rs.getString(3));
                c.setNomEsp(rs.getString(4));
                c.setCodigoMedico(rs.getInt(5));
                c.setNomMed(rs.getString(6));
                c.setFechaRegistro(rs.getString(7));
                c.setFechaAtencion(rs.getString(8));
                c.setHoraAtencion(rs.getString(9));
                c.setTotalPagar(rs.getDouble(10));
                c.setEstadoConsulta(rs.getString(11));
                c.setObservacion(rs.getString(12));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return c;
    }

    public int AtenderConsulta(Consulta c, ArrayList<Receta> listaRecetas) {
        int res = 0;

        try {
            cn = Conexion.getInstance().getConnection();
            String sql = "update consulta set observacion = ?, estadoConsulta =? "
                    + "where codigoConsulta =?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, c.getObservacion());
            ps.setString(2, c.getEstadoConsulta());
            ps.setInt(3, c.getCodigoConsulta());
            res = ps.executeUpdate();

            if (res > 0) {
                for (Receta r : listaRecetas) {
                    sql = "insert into Receta(codigoConsulta,codigoMedicina,cantidad,comentario)values(?,?,?,?)";
                    ps = cn.prepareStatement(sql);
                    ps.setInt(1, c.getCodigoConsulta());
                    ps.setInt(2, r.getCodigoMedicina());
                    ps.setInt(3, r.getCantidad());
                    ps.setString(4, r.getComentario());

                    res = ps.executeUpdate();
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        return res;
    }
}
