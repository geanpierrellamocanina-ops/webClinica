DROP DATABASE IF EXISTS bdClinicaInt;

CREATE DATABASE bdClinicaInt;

USE bdClinicaInt;

CREATE TABLE Especialidad(
	codigoEspecialidad INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(70),
	precio DECIMAL(8,2),
	eliminado INT 
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE Medico(
	codigoMedico INT AUTO_INCREMENT PRIMARY KEY,
	codigoEspecialidad INT,
	nombres VARCHAR(100),
	apellidos VARCHAR(100),
	telefono CHAR(9),
	correo VARCHAR(100),
	fechaIngreso DATE,
	eliminado INT,
	FOREIGN KEY(codigoEspecialidad) REFERENCES Especialidad(codigoEspecialidad)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE Paciente(
	codigoPaciente INT AUTO_INCREMENT PRIMARY KEY,
	nombres VARCHAR(100),
	apellidos VARCHAR(100),
	telefono CHAR(9),
	tipoDocumento VARCHAR(50),
	documentoIdentidad VARCHAR(20),
	eliminado INT
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE Cama(
	codigoCama INT AUTO_INCREMENT PRIMARY KEY,
	categoria VARCHAR(40),
	numeroCama VARCHAR(30),
	precioDia DECIMAL(8,2),
	estado VARCHAR(20)
	
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE Internamiento(
	codigoInternamiento INT AUTO_INCREMENT PRIMARY KEY,
	codigoPaciente INT,
	codigoMedico INT,
	codigoCama INT,
	fechaIngreso DATE,
	horaIngreso TIME,
	fechaSalida DATE,
	horaSalida TIME,
	totalPagar DECIMAL(8,2),
	estado VARCHAR(20),
    observacion VARCHAR(400),
	FOREIGN KEY(codigoPaciente) REFERENCES Paciente(codigoPaciente),
	FOREIGN KEY(codigoCama) REFERENCES Cama(codigoCama),
	FOREIGN KEY(codigoMedico) REFERENCES Medico(codigoMedico)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE Medicina(
	codigoMedicina INT AUTO_INCREMENT PRIMARY KEY,
	laboratorio VARCHAR(100),
	nombre VARCHAR(100),
	eliminado INT
	
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE Consulta(
	codigoConsulta INT AUTO_INCREMENT PRIMARY KEY,
	codigoPaciente INT,
	codigoMedico INT,
	fechaRegistro DATE,
	fechaAtencion DATE,
	horaAtencion TIME,
	totalPagar DECIMAL(8,2),
	estadoConsulta VARCHAR(50),
	observacion VARCHAR(600),
	FOREIGN KEY(codigoMedico) REFERENCES Medico(codigoMedico),
	FOREIGN KEY(codigoPaciente) REFERENCES Paciente(codigoPaciente)	
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE Receta(
	codigoReceta INT AUTO_INCREMENT PRIMARY KEY,
	codigoConsulta INT,
	codigoMedicina INT,
    cantidad INT,
	comentario VARCHAR(120),
	FOREIGN KEY(codigoConsulta) REFERENCES Consulta(codigoConsulta),
	FOREIGN KEY(codigoMedicina) REFERENCES Medicina(codigoMedicina)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



INSERT INTO Especialidad VALUES(NULL , 'Cardiologia' , 30 , 0);
INSERT INTO Especialidad VALUES(NULL , 'Medicina General' , 45 , 0);
INSERT INTO Especialidad VALUES(NULL , 'Traumatologia' , 86 , 0);
INSERT INTO Especialidad VALUES(NULL , 'Endocrinología' , 25 , 0);
INSERT INTO Especialidad VALUES(NULL , 'Dermatología' , 30 , 0);
INSERT INTO Especialidad VALUES(NULL , 'Gastroenterología' , 25 , 0);

INSERT INTO Medico VALUES(NULL , 1 , 'Manuel' , 'Campos Gutierrez' , '954236523' , 'juan.campos@gmail.com' , '2011-12-01' , 0);
INSERT INTO Medico VALUES(NULL , 2 , 'Carla' , 'Alarcon Jimenez' , '987563215' , 'carla.alarcon@gmail.com' , '2016-10-16' , 0);
INSERT INTO Medico VALUES(NULL , 2 , 'Jimena' , 'Barraza Fernandez' , '965412365' , 'jimena.barraza@gmail.com' , '2018-12-01' , 0);
INSERT INTO Medico VALUES(NULL , 2 , 'Fernando' , 'Alpino Contreras' , '9654123658' , 'fernando.alpino@gmail.com' , '2020-01-13' , 0);
INSERT INTO Medico VALUES(NULL , 3 , 'Laura' , 'Guzman Sotomayor' , '962000125' , 'laura.guzman@gmail.com' , '2021-07-03' , 0);
INSERT INTO Medico VALUES(NULL , 3 , 'Jorge' , 'Fernandez Zulman' , '969698542' , 'jorge.fernandez@gmail.com' , '2022-05-11' , 0);
INSERT INTO Medico VALUES(NULL , 4 , 'Calixto' , 'Fernandez Dulan' , '965423666' , 'calixto.fernandez@gmail.com' , '2018-02-19' , 0);
INSERT INTO Medico VALUES(NULL , 4 , 'Alan' , 'Leon Larico' , '987568999' , 'alan.leon@gmail.com' , '2016-06-12' , 0);
INSERT INTO Medico VALUES(NULL , 5 , 'Sergio' , 'Bazo Cerron' , '954125252' , 'sergio.bazo@gmail.com' , '2014-08-24' , 0);

INSERT INTO Medicina VALUES(NULL , 'Medicsur' , 'Analgésico' , 0);
INSERT INTO Medicina VALUES(NULL , 'Laboratorios roemmers' , 'Anestésico' , 0);
INSERT INTO Medicina VALUES(NULL , 'Medicsur' , 'Antibiótico' , 0);
INSERT INTO Medicina VALUES(NULL , 'Medicsur' , 'Artesunato' , 0);
INSERT INTO Medicina VALUES(NULL , 'Medicsur' , 'Aztreonam de reserva' , 0);
INSERT INTO Medicina VALUES(NULL , 'MultiLab' , 'Budesonida' , 0);
INSERT INTO Medicina VALUES(NULL , 'Medicsur' , 'Cefalosporinas - 4ª generación' , 0);

INSERT INTO Paciente VALUES(NULL , 'Maria' , 'Fernandez Aguilar' , '2545632' , 'DNI' , '12352323' , 0);
INSERT INTO Paciente VALUES(NULL , 'Mateo' , 'Mendoza Morales' , '987565425' , 'DNI' , '01256325' , 0);
INSERT INTO Paciente VALUES(NULL , 'Claudia' , 'Aguilar Zulmaran' , '985423336' , 'DNI' , '12456985' , 0);
INSERT INTO Paciente VALUES(NULL , 'Giovani' , 'Gonzales Aguilar' , '9998565415' , 'DNI' , '45236589' , 0);
INSERT INTO Paciente VALUES(NULL , 'Tito' , 'Castillo Alpino' , '985632563' , 'DNI' , '65236545' , 0);
INSERT INTO Paciente VALUES(NULL , 'Humberto' , 'Navarro Martinez' , '987565426' , 'DNI' , '55563254' , 0);

INSERT INTO Cama VALUES(NULL , 'Articulada' , 1 , 30 , 'Disponible');
INSERT INTO Cama VALUES(NULL , 'Articulada' , 2 , 14 , 'Disponible');
INSERT INTO Cama VALUES(NULL , 'Ortopédica' , 3 , 30 , 'Disponible');
INSERT INTO Cama VALUES(NULL , 'Ortopédica' , 4 , 30 , 'Disponible');
INSERT INTO Cama VALUES(NULL , 'Ortopédica' , 5 , 20 , 'Disponible');
INSERT INTO Cama VALUES(NULL , 'Traumatológica' , 6 , 30 , 'Disponible');
INSERT INTO Cama VALUES(NULL , 'Traumatológica' , 7 , 25 , 'Disponible');
INSERT INTO Cama VALUES(NULL , 'Articulada' , 8 , 30 , 'Disponible');
INSERT INTO Cama VALUES(NULL , 'Articulada' , 9 , 30 , 'Disponible');



select * from Internamiento;
