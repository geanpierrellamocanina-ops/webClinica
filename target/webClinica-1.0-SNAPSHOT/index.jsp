<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Login</title>
        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/metisMenu.min.css" rel="stylesheet">
        <link href="./css/startmin.css" rel="stylesheet">
        <link href="./css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="./css/errorInput.css" rel="stylesheet" type="text/css"/>
        <link href="./alertify/toastr.min.css" rel="stylesheet" type="text/css"/>
    </head>

    <style>
        body{
            background: url(img/fondo.jpg) no-repeat center top;
        }
    </style>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-body">
                            <div class="text-center">
                                <img src="img/avatar.png" class="img-rounded"/>
                            </div>
                            <form id="form" method="post">
                                <fieldset>
                                    <div class="form-group">
                                        <label>Correo Eléctronico</label>
                                        <input class="form-control"  name="correo" id="correo" type="email" autofocus >
                                    </div>
                                    <div class="form-group">
                                        <label>Contraseña</label>
                                        <input class="form-control" name="contrasennia" id="contrasennia" type="password">
                                    </div>
                                    <input type="hidden" name="accion" value="login">
                                    <button type="submit" id="btnIniciar"  class="btn btn-lg btn-primary btn-block">Iniciar Sesión</button>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="./js/jquery.min.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/metisMenu.min.js"></script>
        <script src="./js/startmin.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js" type="text/javascript"></script>
        <script src="./alertify/toastr.min.js"></script>
        <script src="./js/misFunciones/FnLogin.js"></script>
    </body>
</html>
