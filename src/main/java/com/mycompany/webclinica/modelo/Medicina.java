package com.mycompany.webclinica.modelo;
public class Medicina {
    private int codigoMedicina;
    private String labotario;
    private String nombre;
    private int eliminado;

    public int getCodigoMedicina() {
        return codigoMedicina;
    }

    public void setCodigoMedicina(int codigoMedicina) {
        this.codigoMedicina = codigoMedicina;
    }

    public String getLabotario() {
        return labotario;
    }

    public void setLabotario(String labotario) {
        this.labotario = labotario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getEliminado() {
        return eliminado;
    }

    public void setEliminado(int eliminado) {
        this.eliminado = eliminado;
    }

}
