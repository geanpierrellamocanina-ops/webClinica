$(document).ready(function () {
    $("#form").validate({
        rules: {
            correo: {
                required: true,
                email: true
            },
            contrasennia: {
                required: true
            }
        },
        messages: {
            correo: {
                required: "El campo es requerido.",
                email: "Formato no valido."
            },
            contrasennia: {
                required: "El campo es requerido."
            }
        }, submitHandler: function (form) {
            IniciarSesion(form.id);
        }
    });
});

function IniciarSesion(form) {
    $.ajax({
        type: "post",
        url: "ControlLogin",
        data: $("#" + form).serialize(),
        success: function (data) {
            if (data !== "") {
                $("#btnIniciar").prop('disabled', true);
                $("#btnIniciar").text("Cargando...");

                toastr.success('Bienvenido.');
                setTimeout(function () {
                    $(location).attr("href", data);
                }, 1000);

            } else {
                toastr.error("Correo y/o contraseña incorrecto");
            }
        },
        error: function (data) {
            console.dir(data);
        }
    });
}