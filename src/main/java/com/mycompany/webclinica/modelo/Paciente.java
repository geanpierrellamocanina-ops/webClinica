package com.mycompany.webclinica.modelo;

public class Paciente {

    private int codigoPaciente;
    private String nombres;
    private String apellidos;
    private String telefono;
    private String tipoDocumento;
    private String documentoIdentidad;
    private int eliminado;
    private int cantConsultas;
    private int cantInternamiento;
    
    public String nomCompletos(){
        return nombres + " "+apellidos;
    }

    @Override
    public String toString() {
        return "Paciente{" + "codigoPaciente=" + codigoPaciente + ", nombres=" + nombres + ", apellidos=" + apellidos + ", telefono=" + telefono + ", tipoDocumento=" + tipoDocumento + ", documentoIdentidad=" + documentoIdentidad + ", eliminado=" + eliminado + '}';
    }

    public int getCodigoPaciente() {
        return codigoPaciente;
    }

    public void setCodigoPaciente(int codigoPaciente) {
        this.codigoPaciente = codigoPaciente;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getTipoDocumento() {
        return tipoDocumento;
    }

    public void setTipoDocumento(String tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public String getDocumentoIdentidad() {
        return documentoIdentidad;
    }

    public void setDocumentoIdentidad(String documentoIdentidad) {
        this.documentoIdentidad = documentoIdentidad;
    }

    public int getEliminado() {
        return eliminado;
    }

    public void setEliminado(int eliminado) {
        this.eliminado = eliminado;
    }

    public int getCantConsultas() {
        return cantConsultas;
    }

    public void setCantConsultas(int cantConsultas) {
        this.cantConsultas = cantConsultas;
    }

    public int getCantInternamiento() {
        return cantInternamiento;
    }

    public void setCantInternamiento(int cantInternamiento) {
        this.cantInternamiento = cantInternamiento;
    }

    
}
