package com.mycompany.webclinica.modelo;

public class Medico extends Especialidad {

    private int codigoMedico;
    private String nombresMed;
    private String apellidosMed;
    private String telefono;
    private String correo;
    private String fechaIngreso;

    @Override
    public String toString() {
        return "Medico{" + "codigoMedico=" + codigoMedico + ", nombresMed=" + nombresMed + 
                ", apellidosMed=" + apellidosMed + ", telefono=" + telefono + ", correo=" + correo 
                + ", fechaIngreso=" + fechaIngreso +
                " , codigo especialidad: "+getCodigoEspecialidad()+" , especialidad: "+getNombre()+ '}';
    }

    public String nomCompletos() {
        return nombresMed + " " + apellidosMed;
    }

    public int getCodigoMedico() {
        return codigoMedico;
    }

    public void setCodigoMedico(int codigoMedico) {
        this.codigoMedico = codigoMedico;
    }

    public String getNombresMed() {
        return nombresMed;
    }

    public void setNombresMed(String nombresMed) {
        this.nombresMed = nombresMed;
    }

    public String getApellidosMed() {
        return apellidosMed;
    }

    public void setApellidosMed(String apellidosMed) {
        this.apellidosMed = apellidosMed;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

}
