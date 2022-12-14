-- Database: TiendaProductoPg

-- DROP DATABASE IF EXISTS "TiendaProductoPg";

CREATE DATABASE "TiendaProductoPg"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Argentina.1252'
    LC_CTYPE = 'Spanish_Argentina.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
CREATE TABLE Tipo_Producto (
	id_Tip_Producto serial,
    Tipo VARCHAR(100),
	PRIMARY KEY (id_Tip_Producto)
);

CREATE TABLE Producto (
	id_Producto serial,
    Codigo_Producto INT UNIQUE NOT NULL,
    Valor_Uni float8,
    Costo float,
    Cantidad_Llego INT,
    Cantidad_Actual INT,
    Tipo_Producto INT,
    Descripcion VARCHAR(100),
    Img VARCHAR(100),
	PRIMARY KEY (id_Producto),
    FOREIGN KEY (Tipo_Producto) REFERENCES Tipo_Producto(id_Tip_producto)
);

CREATE TABLE Perfil (
	id_Perfil serial,
    Tipo_Perfil VARCHAR(100),
	PRIMARY KEY (id_Perfil)
);

CREATE TABLE Devolucion (
	id_Devolucion serial,
    id_Producto INT,
    Fecha_Devolucion DATE,
	PRIMARY KEY (id_Devolucion),
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);

CREATE TABLE Departamento (
	id_Departamento serial,
    Departamento VARCHAR(100),
	PRIMARY KEY (id_Departamento)
);

CREATE TABLE Municipio (
	id_Municipio serial,
    Municipio VARCHAR(100),
    id_Departamento INT,
	PRIMARY KEY (id_Municipio),
    FOREIGN KEY (id_Departamento) REFERENCES Departamento(id_Departamento)
);

CREATE TABLE Bodega (
	id_Bodega serial,
    Telefono INT,
    Direccion VARCHAR(100),
    id_Departamento INT,
	PRIMARY KEY (id_Bodega),
    FOREIGN KEY (id_Departamento) REFERENCES Departamento(id_Departamento)
);

CREATE TABLE Tienda (
	id_Tienda serial,
    Tienda VARCHAR(100) NOT NULL,
    id_Departamento INT,
    Direccion VARCHAR(100),
    id_Bodega INT,
	PRIMARY KEY (id_Tienda),
    FOREIGN KEY (id_Departamento) REFERENCES  Departamento(id_Departamento),
    FOREIGN KEY (id_Bodega) REFERENCES Bodega(id_Bodega)
); 

CREATE TABLE Usuario (
	id_Usu serial,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Usuario VARCHAR(100),
    Psw VARCHAR(100),
    Rol VARCHAR(100),
    id_Tienda INT,
	PRIMARY KEY (id_Usu),
    FOREIGN KEY (id_Tienda) REFERENCES Tienda(id_Tienda)
);

CREATE TABLE Traslado (
	id_Traslado serial,
    id_Tienda_Actual INT,
	id_Tienda_Nueva INT,
    id_Producto INT,
    Fecha_Traslado DATE,
	PRIMARY KEY (id_Traslado),
	FOREIGN KEY (id_Tienda_Actual) REFERENCES Tienda(id_Tienda),
	FOREIGN KEY (id_Tienda_Nueva) REFERENCES Tienda(id_Tienda),
	FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);

CREATE TABLE Tienda_Producto (
	id_Tienda_Producto serial,
    id_Producto INT,
    id_Tienda INT,
    Cantidad INT,
    Saldo FLOAT,
	PRIMARY KEY (id_Tienda_Producto),
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto),
    FOREIGN KEY (id_Tienda) REFERENCES Tienda(id_Tienda)
);

CREATE TABLE Perfil_Usuario (
	id_Tip_Perfil serial,
    id_Usuario INT,
    id_Perfil INT,
	PRIMARY KEY (id_Tip_Perfil),
    FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usu),
    FOREIGN KEY (id_Perfil) REFERENCES Perfil(id_Perfil)
);

CREATE TABLE Cliente (
	id_Cliente serial,
    Nombres VARCHAR(100),
    N_Documento INT UNIQUE,
    Email VARCHAR(100),
    Telefono INT ,
    Direccion VARCHAR(100),
    id_Departamento INT,
    id_Usuario INT,
    Fecha_Nacimiento DATE,
	PRIMARY KEY (id_Cliente),
    FOREIGN KEY (id_Departamento) REFERENCES Departamento(id_Departamento),
    FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usu)
);

CREATE TABLE Factura_Venta (
	id_Factura_Venta serial,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Estado BOOLEAN,
    id_Cliente INT,
    id_Usuario INT,
    id_Tienda INT,
	PRIMARY KEY (id_Factura_Venta),
    FOREIGN KEY (id_Cliente) REFERENCES Cliente(id_Cliente),
    FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usu),
    FOREIGN KEY (id_Tienda) REFERENCES Tienda(id_Tienda)
);

CREATE TABLE Ventas (
	id_Ventas serial,
    Cantidad INT,
    Tipo_Descuento VARCHAR(100),
    Valor_Descuento FLOAT,
    id_Factura INT,
    id_Producto INT,
	PRIMARY KEY (id_Ventas),
    FOREIGN KEY (id_Factura) REFERENCES Factura_Venta(id_Factura_Venta),
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);
