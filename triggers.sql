create database triggers;
use triggers;

create table clientes(
    id_cliente int(11) not null auto_increment,
    nombre varchar(50) not null,
    seccion varchar(20) not null,
    accion varchar(10) not null default 'Insertado',
    primary key(id_cliente)
);

create table auditoria_cliente(
    id int(11) not null auto_increment,
    nombre_anterior varchar(50) not null,
    seccion_anterior varchar(20) not null,
    nombre_nuevo varchar(50) not null,
    seccion_nueva varchar(20) not null,
    usuario varchar(30) not null,
    modificado datetime not null,
    proceso varchar(10) not null,
    id_cliente int(11) not null,
    primary key(id),
    foreign key(id_cliente) references clientes(id_cliente)
);

insert into clientes (nombre, seccion, accion) values ("Antonella", "Mecanica", "Reparar");
insert into clientes (nombre, seccion, accion) values ("Mateo", "Computacion", "Programacion");
insert into clientes (nombre, seccion, accion) values ("Joaquin", "Computacion", "Diseño");
insert into clientes (nombre, seccion, accion) values ("Alejo", "Mecanica", "Cambiar ruedas");


--Si es una operación «Insert» toma valor nombre_nuevo, seccion_nueva,
--usuario (que es el que tiene abierta la sesión), modificado (que toma la
--fecha y hora del sistema), proceso (accion que se ejecuta)
DELIMITER $$
create trigger triggerInsert
after «insert» on clientes
for each row
begin
    insert into auditoria_cliente (nombre_anterior, seccion_anterior, nombre_nuevo, seccion_nueva, usuario, modificado, proceso, id_cliente) 
    values ("", "", new.nombre, new.seccion, new.usuario, NOW(), "Insertado", new.id_cliente);
end $$
DELIMITER ;


--2) Si es una operación «Update» toma valores todos los atributos y el
--proceso es ‘Modificado’
DELIMITER $$
create trigger triggerUpdate
after «Update» on clientes
for each row
begin
    insert into auditoria_cliente (nombre_anterior, seccion_anterior, nombre_nuevo, seccion_nueva, usuario, modificado, proceso, id_cliente) 
    values (old.nombre, old.seccion, new.nombre, new.seccion, new.usuario, NOW(), "Modificado", new.id_cliente);
end $$
DELIMITER ;

--3) Si es una operación «Delete» toma valor nombre_anterior, seccion_anterior, usuario
--(que es el que tiene abierta la sesión), modificado (que toma la fecha y hora del
--sistema), proceso ‘Eliminado’
DELIMITER $$
create trigger triggerDelete
after «Delete» on clientes
for each row
begin
    insert into auditoria_cliente (nombre_anterior, seccion_anterior, nombre_nuevo, seccion_nueva, usuario, modificado, proceso, id_cliente) 
    values (old.nombre, old.seccion, "", "", new.usuario, NOW(), "Eliminado", old.id_cliente);
end $$
DELIMITER ;