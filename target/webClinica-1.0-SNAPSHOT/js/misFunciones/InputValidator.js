function soloLetras(e) {
    var key = e.keyCode || e.which,
            tecla = String.fromCharCode(key).toLowerCase(),
            letras = " áéíóúabcdefghijklmnñopqrstuvwxyz",
            especiales = [8, 37, 39, 46],
            tecla_especial = false;

    for (var i in especiales) {
        if (key === especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) === -1 && !tecla_especial) {
        return false;
    }
}

function soloNumeros(e) {
    var key = window.Event ? e.which : e.keyCode;
    return (key >= 48 && key <= 57);
}

function ObtFecActual(data) {
    alert("Fecha: "+data);
    if (data === "" || data === undefined) {
        var fecha = new Date();
        return  fecha.toJSON().slice(0, 10);
    } else {
        return data;
    }
}

function ObtFecActual() {
    var hoy = new Date();
    return  hoy.toJSON().slice(0, 10);
}

function ObtHoraActual(data) {
    if (data === "" || data === undefined) {
        var hoy = new Date();

        return (hoy.getHours() < 10 ? '0' + hoy.getHours() : hoy.getHours()) +
                ':' + (hoy.getMinutes() < 10 ? '0' + hoy.getMinutes() : hoy.getMinutes());
    } else {
        return data;
    }
}

function ObtHoraActual() {
    var hoy = new Date();

    return (hoy.getHours() < 10 ? '0' + hoy.getHours() : hoy.getHours()) +
            ':' + (hoy.getMinutes() < 10 ? '0' + hoy.getMinutes() : hoy.getMinutes());
}

