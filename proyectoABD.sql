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
