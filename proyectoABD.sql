CREATE DATABASE proyectoABD;

DROP DATABASE proyectoABD;

USE proyectoABD;

--creando tabla proveedor
CREATE TABLE proveedor(
	id_proveedor SMALLINT PRIMARY KEY IDENTITY,
	nombre VARCHAR(25) NOT NULL,
);

-- creando tabla empleado
CREATE TABLE empleado(
	nombre VARCHAR(25) NOT NULL,
	fecha_entrada DATE NOT NULL,
	id_empleado INT PRIMARY KEY IDENTITY
);

-- creando tabla catalogo categoria
CREATE TABLE categoria(
	id_categoria INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(25) NOT NULL
);

-- creando tabla marca
CREATE TABLE marca(
	id_marca INT PRIMARY KEY IDENTITY,
	nombreMarca VARCHAR(25) NOT NULL
);

-- creando tabla producto
CREATE TABLE producto(
	id_producto INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(25),
	fk_id_marca INT NOT NULL,
	fk_id_categoria INT NOT NULL,
	precio SMALLINT NOT NULL,
	stock SMALLINT NOT NULL
);

--Agregando llaves foraneas a tabla producto
ALTER TABLE producto ADD CONSTRAINT fk_from_categoria FOREIGN KEY (fk_id_categoria) REFERENCES categoria(id_categoria);
ALTER TABLE producto ADD CONSTRAINT fk_from_marca FOREIGN KEY (fk_id_marca) REFERENCES marca(id_marca);

-- creando tabla venta
CREATE TABLE venta(
	id_venta INT PRIMARY KEY IDENTITY,
	fk_id_empleado INT NOT NULL
);

--Agregando llave foranea a tabla venta
ALTER TABLE venta ADD CONSTRAINT fk_from_empleado FOREIGN KEY (fk_id_empleado) REFERENCES empleado(id_empleado);

--Creando tabla de la relacion producto venta
CREATE TABLE prodxventa(
	pkfk_id_producto INT NOT NULL,
	pkfk_id_venta INT NOT NULL,
	cant INT
);

-- Aregando llaves foraneas a la tabla relacion producto venta
ALTER TABLE prodxventa ADD CONSTRAINT fk_from_productoFOREIGN KEY (pkfk_id_producto) REFERENCES producto(id_producto);
ALTER TABLE prodxventa ADD CONSTRAINT fk_from_ventaFOREIGN KEY (pkfk_id_venta) REFERENCES venta(id_venta);

-- Agregando llave primaria a la tabla relacion producto venta
ALTER TABLE prodxventa ADD PRIMARY KEY (pkfk_id_producto,pkfk_id_venta);

--Creando tabla que relaciona proveedor y producto
CREATE TABLE prodxproveedor(
	pkfk_id_producto INT NOT NULL,
	pkfk_id_proveedor SMALLINT NOT NULL
);

--Agregando llave primaria a la tabla que relaciona producto y venta
ALTER TABLE prodxproveedor ADD PRIMARY KEY(pkfk_id_producto,pkfk_id_proveedor);

-- Agregando llaves foraneas a la tabla que relaciona producto y venta
ALTER TABLE prodxproveedor ADD CONSTRAINT fk_from_producto2 FOREIGN KEY (pkfk_id_producto) REFERENCES producto(id_producto);
ALTER TABLE prodxproveedor ADD CONSTRAINT fk_from_proveedor FOREIGN KEY (pkfk_id_proveedor) REFERENCES proveedor(id_proveedor);

INSERT INTO categoria(nombre) VALUES('Juguetes');
INSERT INTO categoria(nombre) VALUES('Jardin');
INSERT INTO categoria(nombre) VALUES('Ocio');
INSERT INTO categoria(nombre) VALUES('Articulos Personales');
INSERT INTO categoria(nombre) VALUES('Productos Congelados');
INSERT INTO categoria(nombre) VALUES('Utiles escolares');
INSERT INTO categoria(nombre) VALUES('Productos de cocina');
INSERT INTO categoria(nombre) VALUES('Productos Decorativos');
INSERT INTO categoria(nombre) VALUES('Herramientas');

INSERT INTO marca(nombreMarca) VALUES ('Hershey');
INSERT INTO marca(nombreMarca) VALUES ('Lays');
INSERT INTO marca(nombreMarca) VALUES ('JS Gardens');
INSERT INTO marca(nombreMarca) VALUES ('GrandmasKitchen');
INSERT INTO marca(nombreMarca) VALUES ('Colgate');
INSERT INTO marca(nombreMarca) VALUES ('Oral-B');
INSERT INTO marca(nombreMarca) VALUES ('Moyu');
INSERT INTO marca(nombreMarca) VALUES ('Sheng-shou');
INSERT INTO marca(nombreMarca) VALUES ('Martin Congelados');
INSERT INTO marca(nombreMarca) VALUES ('Scribe');
INSERT INTO marca(nombreMarca) VALUES ('Stanley');

INSERT INTO empleado(nombre,fecha_entrada,id_supervisor) VALUES ('Juan Martinez','2018-08-21',null);
INSERT INTO empleado(nombre,fecha_entrada,id_supervisor) VALUES ('Raul Granados', '2017-12-20',1);
INSERT INTO empleado(nombre,fecha_entrada,id_supervisor) VALUES ('Daniel Dominguez','2018-02-24',1);
INSERT INTO empleado(nombre,fecha_entrada,id_supervisor) VALUES ('Astrid Guzman','2017-02-10',1);
INSERT INTO empleado(nombre,fecha_entrada,id_supervisor) VALUES ('Jorge Miranda','2018-05-04',1);
INSERT INTO empleado(nombre,fecha_entrada,id_supervisor) VALUES('Josue Gonzales','2018-05-20',1);

INSERT INTO venta(fk_id_empleado) VALUES (2);
INSERT INTO venta(fk_id_empleado) VALUES (3);
INSERT INTO venta(fk_id_empleado) VALUES (1);
INSERT INTO venta(fk_id_empleado) VALUES (6);
INSERT INTO venta(fk_id_empleado) VALUES (5);
INSERT INTO venta(fk_id_empleado) VALUES (2);
INSERT INTO venta(fk_id_empleado) VALUES (3);
INSERT INTO venta(fk_id_empleado) VALUES (4);
INSERT INTO venta(fk_id_empleado) VALUES (2);


--Creando procesos almacenados 

CREATE PROCEDURE spEmpleados
AS
SELECT * FROM empleado
GO

EXECUTE spEmpleados;

CREATE PROCEDURE spTopVentas
AS 
SELECT TOP 5 
e.nombre, e.fecha_entrada, count(v.id_venta) as 'numeroDeVentas' FROM
empleado e JOIN venta v
ON e.id_empleado = v.fk_id_empleado
GROUP BY e.nombre, e.fecha_entrada
ORDER BY numeroDeVentas ASC
GO

--Creando vistas
CREATE VIEW vwVentaEmpleados AS
SELECT * FROM 
empleado JOIN venta
ON empleado.id_empleado = venta.fk_id_empleado;

SELECT * FROM vwVentaEmpleados;

CREATE VIEW vwProductosVendidos AS
SELECT p.nombre, p.precio, sum(pv.cant) as 'cantidadVendida' FROM 
prodxventa pv JOIN producto p
ON pv.pkfk_id_producto = p.id_producto
GROUP BY p.nombre, p.precio;

SELECT * FROM vwProductosVendidos
