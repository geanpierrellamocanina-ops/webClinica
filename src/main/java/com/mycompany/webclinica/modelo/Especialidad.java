package com.mycompany.webclinica.modelo;

public class Especialidad {
    private int codigoEspecialidad;
    private String nombre;
    private double precio;
    private int eliminado;

    @Override
    public String toString() {
        return "Especialidad{" + "codigoEspecialidad=" + codigoEspecialidad + ", nombre=" + nombre + ", precio=" + precio + ", eliminado=" + eliminado + '}';
    }

    
    
    public int getCodigoEspecialidad() {
        return codigoEspecialidad;
    }

    public void setCodigoEspecialidad(int codigoEspecialidad) {
        this.codigoEspecialidad = codigoEspecialidad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getEliminado() {
        return eliminado;
    }

    public void setEliminado(int eliminado) {
        this.eliminado = eliminado;
    }

}
