package com.mycompany.webclinica.modelo;

public class Internamiento {

    private int codigoInternamiento;
    private int codigoPaciente;
    private int codigoMedico;
    private int codigoCama;
    private String fechaIngreso;
    private String fechaSalida;
    private String horaIngreso;
    private String horaSalida;
    private double totalPagar;
    private String estado;
    private String observacion;
    private String nomPac;
    private String nomMed;
    private String nomEsp;
    private String nomCama;
    private int diasInt;
    private int cantidad;

    @Override
    public String toString() {
        return "Internamiento{" + "codigoInternamiento=" + codigoInternamiento + ", codigoPaciente=" + codigoPaciente + ", codigoMedico=" + codigoMedico + ", codigoCama=" + codigoCama + ", fechaIngreso=" + fechaIngreso + ", fechaSalida=" + fechaSalida + ", horaIngreso=" + horaIngreso + ", horaSalida=" + horaSalida + ", totalPagar=" + totalPagar + ", estado=" + estado + ", observacion=" + observacion + ", nomPac=" + nomPac + ", nomMed=" + nomMed + ", nomEsp=" + nomEsp + ", nomCama=" + nomCama + ", diasInt=" + diasInt + ", cantidad=" + cantidad + '}';
    }

    public int getCodigoInternamiento() {
        return codigoInternamiento;
    }

    public void setCodigoInternamiento(int codigoInternamiento) {
        this.codigoInternamiento = codigoInternamiento;
    }

    public int getCodigoPaciente() {
        return codigoPaciente;
    }

    public void setCodigoPaciente(int codigoPaciente) {
        this.codigoPaciente = codigoPaciente;
    }

    public int getCodigoMedico() {
        return codigoMedico;
    }

    public void setCodigoMedico(int codigoMedico) {
        this.codigoMedico = codigoMedico;
    }

    public int getCodigoCama() {
        return codigoCama;
    }

    public void setCodigoCama(int codigoCama) {
        this.codigoCama = codigoCama;
    }

    public String getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public String getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(String fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public String getHoraIngreso() {
        return horaIngreso;
    }

    public void setHoraIngreso(String horaIngreso) {
        this.horaIngreso = horaIngreso;
    }

    public String getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(String horaSalida) {
        this.horaSalida = horaSalida;
    }

    public double getTotalPagar() {
        return totalPagar;
    }

    public void setTotalPagar(double totalPagar) {
        this.totalPagar = totalPagar;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getNomPac() {
        return nomPac;
    }

    public void setNomPac(String nomPac) {
        this.nomPac = nomPac;
    }

    public String getNomMed() {
        return nomMed;
    }

    public void setNomMed(String nomMed) {
        this.nomMed = nomMed;
    }

    public String getNomEsp() {
        return nomEsp;
    }

    public void setNomEsp(String nomEsp) {
        this.nomEsp = nomEsp;
    }

    public String getNomCama() {
        return nomCama;
    }

    public void setNomCama(String nomCama) {
        this.nomCama = nomCama;
    }

    public int getDiasInt() {
        return diasInt;
    }

    public void setDiasInt(int diasInt) {
        this.diasInt = diasInt;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

}
