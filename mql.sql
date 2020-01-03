CREATE DATABASE mql

-------------------------------------------------------------------------------
-- TABLE: DetalleEmpresa
-------------------------------------------------------------------------------
drop table if exists DetalleEmpresa
create table DetalleEmpresa(
    id_DetalleEmpresa int not null,
    esBinario BINARY not null,
    inicioSemana date not null,
    finSemana date not null,
    PRIMARY KEY (id_DetalleEmpresa)

)
grant select, insert, update, delete on DetalleEmpresa to public

-------------------------------------------------------------------------------
-- TABLE: Empresa
-------------------------------------------------------------------------------
drop table if exists Empresa
create table Empresa(
    id_empresa int not null,
    nombre VARCHAR(50) not null,
    telefono VARCHAR(10),
    direcccion VARCHAR(100),
    PRIMARY KEY id_empresa,
    CONSTRAINT FK_detalle FOREIGN KEY id_detalle REFERENCES DetalleEmpresa(id_DetalleEmpresa),

)

grant select, insert, update, delete on Empresa to root

-------------------------------------------------------------------------------
-- TABLE: Analista
-------------------------------------------------------------------------------
drop table if exists Analista
create table Analista(
  id_analista int not null,
  nombre VARCHAR(50) not null,
  id_estilo int not null,
  id_empresa int not null,
  PRIMARY KEY id_analista,
  CONSTRAINT FK_estilo FOREIGN KEY id_estilo REFERENCES Estilo(id_estilo),
  CONSTRAINT FK_empresa FOREIGN KEY id_empresa REFERENCES Empresa(id_empresa)
)

grant select, insert, update, delete on Analista to public


-------------------------------------------------------------------------------
-- TABLE: Corte
-------------------------------------------------------------------------------
drop table if exists Corte
create table Corte(
    id_corte int not null,
    id_estilo int not null,
    id_cliente int not null,
    cantidadPiezas int not null,
    PRIMARY KEY id_corte,
    CONSTRAINT FK_estilo FOREIGN KEY id_estilo REFERENCES Estilo(id_estilo),
    CONSTRAINT FK_cliente FOREIGN KEY id_cliente REFERENCES Cliente(id_cliente)

)

grant select, insert, update, delete on Corte to public

-------------------------------------------------------------------------------
-- TABLE: Estilo
-------------------------------------------------------------------------------
drop table if exists Estilo
create table Estilo(
    id_estilo int not null,
    nombre VARCHAR(50) not null,
    comentarios TEXT,
    PRIMARY KEY id_estilo,
)

grant select, insert, update, delete on Estilo to public

-------------------------------------------------------------------------------
-- TABLE: Jornada
-------------------------------------------------------------------------------
drop table if exists Jornada
create table Jornada(
    id_jornada int not null,
    id_estilo int not null,
    esBihorario boolean not null,
    PRIMARY KEY id_jornada,
    CONSTRAINT FK_estilo FOREIGN KEY (id_estilo) REFERENCES Estilo(id_estilo)
)
grant select, insert, update, delete on Jornada to public

-------------------------------------------------------------------------------
-- TABLE: Operacion
-------------------------------------------------------------------------------
drop table if exists Operacion
create table Operacion(
      id_operacion int not null,
      id_jornada int not null,
      tareaHora int not null,
      totalProducido int not null,
      PRIMARY KEY (id_operacion),
      CONSTRAINT FK_jornada FOREIGN KEY (id_jornada) REFERENCES Jornada(id_jornada)
)
grant select, insert, update, delete on Operacion to public

-------------------------------------------------------------------------------
-- TABLE: Hora
-------------------------------------------------------------------------------
drop table if exists Hora
create table Hora(
    id_jornada int not null,
    esExtra boolean not null,
    horaRevicion TIME not null,
    PRIMARY KEY horaRevicion
)
grant select, insert, update, delete on Hora to public

-------------------------------------------------------------------------------
-- TABLE: OperacionOperario
-------------------------------------------------------------------------------
drop table if exists OperacionOperario
create table OperacionOperario(
    id_operacionOperario int not null,
    id_operacion int not null,
    id_operario int not null,
    id_hora int not null,
    tareaHora int not null,
    PRIMARY KEY id_operacionOperario,
    CONSTRAINT FK_operacion FOREIGN KEY (id_operacion) REFERENCES Operacion(id_operacion),
    CONSTRAINT FK_operario FOREIGN KEY (id_operario) REFERENCES Operario(id_operario),
    CONSTRAINT FK_hora FOREIGN KEY (id_hora) REFERENCES Operario(id_hora)

)
grant select, insert, update, delete on OperacionOperario to public

-------------------------------------------------------------------------------
-- TABLE: Operario
-------------------------------------------------------------------------------
drop table if exists Operario
create table Operario(
    id_operario int not null,
    id_sueldo int not null,
    id_empresa int not null,
    nombre VARCHAR(50) not null,
    direcccion VARCHAR(100),
    telefono VARCHAR(10),
    PRIMARY KEY (id_operario),
    CONSTRAINT FK_sueldo FOREIGN KEY (id_sueldo) REFERENCES Sueldo(id_sueldo),
    CONSTRAINT FK_empresa FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)

)

grant select, insert, update, delete on Operario to public

-------------------------------------------------------------------------------
-- TABLE: Sueldo
-------------------------------------------------------------------------------
drop table if exists Sueldo
create table Sueldo(
    id_sueldo int not null,
    sueldoTotal money not null,
    sueldoBase money not null,
    sueldoHorasExtra money not null,
    PRIMARY KEY (id_sueldo)
)

grant select, insert, update, delete on Sueldo to public
