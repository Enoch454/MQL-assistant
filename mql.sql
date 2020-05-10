drop database if exists mql;
CREATE DATABASE mql;
use mql;

-- -----------------------------------------------------------------------------
-- TABLE: Usuario
-- -----------------------------------------------------------------------------
-- drop table if exists Usuario;
create table Usuario(
    idUsuario int not null AUTO_INCREMENT,
    nickName VARCHAR(20),
    contraseña VARCHAR(20),
    PRIMARY KEY (idUsuario)
);
-- grant select, insert, update, delete on Usuario to public;

-- -----------------------------------------------------------------------------
-- TABLE: Admon
-- -----------------------------------------------------------------------------
-- drop table if exists Admon;
create table Admon(
    idAdmon int not null AUTO_INCREMENT,
    nombre VARCHAR(50),
    idUsuario int not null,
    PRIMARY KEY (idAdmon),
    CONSTRAINT fk_admon_usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);
-- grant select, insert, update, delete on Admon to public

-- -----------------------------------------------------------------------------
-- TABLE: Empresa
-- -----------------------------------------------------------------------------
-- drop table if exists Empresa;
create table Empresa(
    idEmpresa int not null AUTO_INCREMENT,
    nombre VARCHAR(50),
    telefono VARCHAR(10),
    direccion VARCHAR(50),
    PRIMARY KEY (idEmpresa)
);
-- grant select, insert, update, delete on Empresa to public

-- -----------------------------------------------------------------------------
-- TABLE: Estilo
-- -----------------------------------------------------------------------------
-- drop table if exists Estilo;
create table Estilo(
    idEstilo int not null AUTO_INCREMENT,
    nombre VARCHAR(50),
    tipo VARCHAR(20),
    descripcion VARCHAR(200),
    imagenAdjunta BLOB,
    idEmpresa int,
    CONSTRAINT fk_estilo_empresa FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa),
    PRIMARY KEY (idEstilo)
);
-- grant select, insert, update, delete on Estilo to public;

-- -----------------------------------------------------------------------------
-- TABLE: Secretario
-- -----------------------------------------------------------------------------
-- drop table if exists Secretario;
create table Secretario(
    idSecretario int not null AUTO_INCREMENT,
    nombre VARCHAR(50),
    direccion VARCHAR(50),
    telefono VARCHAR(10),
    idUsuario int not null,
    idEmpresa int not null,
    PRIMARY KEY (idSecretario),
    CONSTRAINT fk_secretario_usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
    CONSTRAINT fk_secretario_empresa FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);
-- grant select, insert, update, delete on Secretario to public

-- -----------------------------------------------------------------------------
-- TABLE: Cliente
-- -----------------------------------------------------------------------------
-- drop table if exists Cliente;
create table Cliente(
    idCliente int not null AUTO_INCREMENT,
    nombre VARCHAR(50),
    telefono VARCHAR(10),
    direccion VARCHAR(50),
    idEmpresa int not null,
    PRIMARY KEY (idCliente),
    CONSTRAINT fk_cliente_empresa FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);
-- grant select, insert, update, delete on Cliente to public

-- -----------------------------------------------------------------------------
-- TABLE: Encargado
-- -----------------------------------------------------------------------------
-- drop table if exists Encargado;
create table Encargado(
    idEncargado int not null AUTO_INCREMENT,
    nombre VARCHAR(50),
    direccion VARCHAR(50),
    telefono VARCHAR(10),
    idUsuario int not null,
    idEmpresa int not null,
    PRIMARY KEY (idEncargado),
    CONSTRAINT fk_encargado_usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
    CONSTRAINT fk_encargado_empresa FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);
-- grant select, insert, update, delete on Encargado to public

-- -----------------------------------------------------------------------------
-- TABLE: Corte
-- -----------------------------------------------------------------------------
-- drop table if exists Corte;
create table Corte(
    idCorte int not null AUTO_INCREMENT,
    fechaPedido date not null,
    fechaEntrega date,
    cantidadPiezas int not null,
    estaCancelado bit,
    idEstilo int not null,
    idCliente int not null,
    idEncargado int not null,
    PRIMARY KEY (idCorte),
    CONSTRAINT fk_corte_estilo FOREIGN KEY (idEstilo) REFERENCES Estilo(idEstilo),
    CONSTRAINT fk_corte_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    CONSTRAINT fk_corte_encargado FOREIGN KEY (idEncargado) REFERENCES Encargado(idEncargado)
);
-- grant select, insert, update, delete on Corte to public

-- -----------------------------------------------------------------------------
-- TABLE: Operacion
-- -----------------------------------------------------------------------------
-- drop table if exists Operacion;
create table Operacion(
    idOperacion int not null AUTO_INCREMENT,
    nombre varchar(50),
    descripcion VARCHAR(100),
    operacionFutura int,
    idEstilo int not null,
    PRIMARY KEY (idOperacion),
    CONSTRAINT fk_operacion_estilo FOREIGN KEY (idEstilo) REFERENCES Estilo(idEstilo)
);
-- grant select, insert, update, delete on Operacion to public

-- -----------------------------------------------------------------------------
-- TABLE: Bono_Respaldo
-- -----------------------------------------------------------------------------
-- drop table if exists Bono_Respaldo;
create table Bono_Respaldo(
    idBonoRespaldo int not null AUTO_INCREMENT,
    numPiezas int,
    porcentajeDelEstimado decimal,
    monto decimal,
    idOperacion int not null,
    PRIMARY KEY (idBonoRespaldo),
    CONSTRAINT fk_bonorespaldo_operacion FOREIGN KEY (idOperacion) REFERENCES Operacion(idOperacion)
);
-- grant select, insert, update, delete on Bono_Respaldo to public

-- -----------------------------------------------------------------------------
-- TABLE: Hora
-- -----------------------------------------------------------------------------
-- drop table if exists Hora;
create table Hora(
    idHora int not null AUTO_INCREMENT,
    horaInicio time,
    horaFin time,
    diaSemana VARCHAR(9),
    enUso bit,
    esExtra bit,
    idEmpresa int not null,
    PRIMARY KEY (idHora),
    CONSTRAINT fk_hora_empresa FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);
-- grant select, insert, update, delete on Hora to public

-- -----------------------------------------------------------------------------
-- TABLE: Corte_Operacion
-- -----------------------------------------------------------------------------
-- drop table if exists Corte_Operacion;
create table Corte_Operacion(
    idCorteOperacion int not null AUTO_INCREMENT,
    numPiezasProcesadas int,
    minutajeEstimado int,
    corteOperacionFutura int,
    idCorte int not null,
    idOperacion int not null,
    PRIMARY KEY (idCorteOperacion),
    CONSTRAINT fk_corteoperacion_corte FOREIGN KEY (idCorte) REFERENCES Corte(idCorte),
    CONSTRAINT fk_corteoperacion_operacion FOREIGN KEY (idOperacion) REFERENCES Operacion(idOperacion)
);
-- grant select, insert, update, delete on Corte_Operacion to public

-- -----------------------------------------------------------------------------
-- TABLE: Bono
-- -----------------------------------------------------------------------------
-- drop table if exists Bono;
create table Bono(
    idBono int not null AUTO_INCREMENT,
    numPiezas int,
    porcentajeDelEstimado decimal,
    monto decimal,
    idCorteOperacion int not null,
    PRIMARY KEY (idBono),
    CONSTRAINT fk_bono_corteoperacion FOREIGN KEY (idCorteOperacion) REFERENCES Corte_Operacion(idCorteOperacion)
);
-- grant select, insert, update, delete on Bono to public

-- -----------------------------------------------------------------------------
-- TABLE: Corte_Operacion_Hora
-- -----------------------------------------------------------------------------
-- drop table if exists Corte_Operacion_Hora;
create table Corte_Operacion_Hora(
    idCorteOperacionHora int not null AUTO_INCREMENT,
    fecha date,
    idCorteOperacion int not null,
    idHora int not null,
    PRIMARY KEY (idCorteOperacionHora),
    CONSTRAINT fk_coh_corteoperacion FOREIGN KEY (idCorteOperacion) REFERENCES Corte_Operacion(idCorteOperacion),
    CONSTRAINT fk_coh_hora FOREIGN KEY (idHora) REFERENCES Hora(idHora)
);
-- grant select, insert, update, delete on Corte_Operacion_Hora to public

-- -----------------------------------------------------------------------------
-- TABLE: Operario
-- -----------------------------------------------------------------------------
-- drop table if exists Operario;
create table Operario(
    idOperario int not null AUTO_INCREMENT,
    nombre varchar(50),
    telefono varchar(10),
    dirección varchar(50),
    sueldoBase decimal,
    estaContratado bit,
    estaActivo bit,
    estaOcupado bit,
    idEmpresa int not null,
    idCorteOperacion int,
    PRIMARY KEY (idOperario),
    CONSTRAINT FK_operario_corteoperacion FOREIGN KEY (idCorteOperacion) REFERENCES Corte_Operacion(idCorteOperacion),
    CONSTRAINT FK_operario_empresa FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);
-- grant select, insert, update, delete on Operario to public

-- -----------------------------------------------------------------------------
-- TABLE: Corte_Operacion_Hora_Operario
-- -----------------------------------------------------------------------------
-- drop table if exists Corte_Operacion_Hora_Operario;
create table Corte_Operacion_Hora_Operario(
    idCorteOperacionHoraOperario int not null AUTO_INCREMENT,
    numOperacionesRealizadas int,
    idCorteOperacionHora int not null,
    idOperario int not null,
    PRIMARY KEY (idCorteOperacionHoraOperario),
    CONSTRAINT fk_coho_coh FOREIGN KEY (idCorteOperacionHora) REFERENCES Corte_Operacion_Hora(idCorteOperacionHora),
    CONSTRAINT fk_coho_operario FOREIGN KEY (idOperario) REFERENCES Operario(idOperario)
);
-- grant select, insert, update, delete on Corte_Operacion_Hora_Operario to public

-- -----------------------------------------------------------------------------
-- TABLE: Sueldo
-- -----------------------------------------------------------------------------
-- drop table if exists Sueldo;
create table Sueldo(
    idSueldo int not null AUTO_INCREMENT,
    fechaCorte date,
    fechaPago date,
    base decimal,
    porBono decimal,
    porHoraExtra decimal,
    descuento decimal,
    OtrosBonos decimal,
    comentarioOtrosBonos varchar(100),
    idOperario int not null,
    PRIMARY KEY (idSueldo),
    CONSTRAINT FK_sueldo_operario FOREIGN KEY (idOperario) REFERENCES Operario(idOperario)
);
-- grant select, insert, update, delete on Sueldo to public
