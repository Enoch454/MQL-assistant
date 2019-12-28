CREATE DATABASE mql

-------------------------------------------------------------------------------
-- TABLE: Empresa
-------------------------------------------------------------------------------
drop table if exists Empresa
create table Empresa(
    id_empresa INT,
    nombre VARCHAR(50),
    telefono VARCHAR(10),
    direcccion VARCHAR(100),
    PRIMARY KEY id_empresa,
    CONSTRAINT emp_anal FOREIGN KEY Analista REFERENCES(id_analista),
)

grant select, insert, update, delete on Empresa to root


-------------------------------------------------------------------------------
-- TABLE: Analista
-------------------------------------------------------------------------------
drop table if exists Analista
create table Analista(
  id_analista INT,
  nombre VARCHAR(50),
  id_estilo INT,
  PRIMARY KEY id_analista,
)

grant select, insert, update, delete on Analista to public


-------------------------------------------------------------------------------
-- TABLE: Corte
-------------------------------------------------------------------------------
drop table if exists Corte
create table Corte(
    id_corte INT,
    id_estilo INT,
    id_cliente INT,
    PRIMARY KEY id_corte,
)

grant select, insert, update, delete on Corte to public

  -------------------------------------------------------------------------------
  -- TABLE: Cliente
  -------------------------------------------------------------------------------
  drop table if exists Cliente
  go


  create table Cliente(
    id_cliente INT,
    nombre VARCHAR(50),
    telefono VARCHAR(10),
    direcccion VARCHAR(100),
    PRIMARY KEY id_cliente,
  )
  go


  grant select, insert, update, delete on TABLE_NAME to public
  go

  -------------------------------------------------------------------------------
  -- TABLE: Estilo
    -------------------------------------------------------------------------------

  drop table if exists Estilo
    go


  create table Estilo
    id_estilo int,
    nombre VARCHAR(50),
    comentarios TEXT,
    PRIMARY KEY id_estilo,
  )


  grant select, insert, update, delete on Estilo
    to public

  -------------------------------------------------------------------------------
  -- TABLE: Jornada
  -------------------------------------------------------------------------------

  drop table if exists Jornada


  create table Jornada(
      id_jornada int,
      id_estilo INT,
      esBihorario BOOLEAN,

  )
  go


  grant select, insert, update, delete on Jornada to public
  go

  -------------------------------------------------------------------------------
  -- TABLE: Operacion
  -------------------------------------------------------------------------------

  drop table if exists Operacion
  go


  create table Operacion(
      id_operacion int,
      id_jornada int,
      tareaHora int,
      totalProducido INT



  )
  go


  grant select, insert, update, delete on Operacion to public
  go

  -------------------------------------------------------------------------------
  -- TABLE: Hora
  -------------------------------------------------------------------------------

  drop table if exists Hora
  go


  create table Hora(
      id_hora INT,
      id_jornada int,
      esExtra BOOLEAN,
      horaRevicion TIME,
  )
  go


  grant select, insert, update, delete on Hora to public
  go

  -------------------------------------------------------------------------------
  -- TABLE: OperacionOperario
  -------------------------------------------------------------------------------

  drop table if exists OperacionOperario
  go


  create table OperacionOperario(
      id_operacionOperario int,
      id_operacion INT,
      id_operario int,
      id_hora int,
      tareaHora int
  )
  go


  grant select, insert, update, delete on OperacionOperario to public
  go

  -------------------------------------------------------------------------------
  -- TABLE: Operario
  -------------------------------------------------------------------------------

  drop table if exists Operario
  go


  create table Operario(
      id_operario int,
      id_sueldo int
  )
  go


  grant select, insert, update, delete on Operario to public
  go

  -------------------------------------------------------------------------------
  -- TABLE: Sueldo
  -------------------------------------------------------------------------------

  drop table if exists Sueldo
  go


  create table Sueldo(
      id_sueldo int
      inicioSemana date,
      finSemana date,
      sueldoTotal money,
      sueldaBase money,
      sueldoHorasExtra money
  )
  go


  grant select, insert, update, delete on Sueldo to public
  go
