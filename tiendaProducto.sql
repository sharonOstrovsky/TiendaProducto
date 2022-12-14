-- falta la linea de relacion entre bodega y tienda
-- falta la linea de relacion entre cliente con departamento y cliente con usuario
DROP DATABASE IF EXISTS tiendaProducto;
CREATE DATABASE IF NOT EXISTS tiendaProducto;
USE tiendaProducto;

CREATE TABLE Tipo_Producto (
	id_Tip_Producto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(100)
);

CREATE TABLE Producto (
	id_Producto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Codigo_Producto INT UNSIGNED UNIQUE NOT NULL,
    Valor_Uni DOUBLE,
    Costo DOUBLE,
    Cantidad_Llego INT UNSIGNED,
    Cantidad_Actual INT UNSIGNED,
    Tipo_Producto INT UNSIGNED,
    Descripcion VARCHAR(100),
    Img BLOB,
    FOREIGN KEY (Tipo_Producto) REFERENCES Tipo_Producto(id_Tip_producto)
);

CREATE TABLE Perfil (
	id_Perfil INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Tipo_Perfil VARCHAR(100)
);

CREATE TABLE Devolucion (
	id_Devolucion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_Producto INT UNSIGNED,
    Fecha_Devolucion DATE,
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);

CREATE TABLE Departamento (
	id_Departamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Departamento VARCHAR(100)
);

CREATE TABLE Municipio (
	id_Municipio INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Municipio VARCHAR(100),
    id_Departamento INT UNSIGNED,
    FOREIGN KEY (id_Departamento) REFERENCES Departamento(id_Departamento)
);

CREATE TABLE Bodega (
	id_Bodega INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Telefono INT,
    Direccion VARCHAR(100),
    id_Departamento INT UNSIGNED,
    FOREIGN KEY (id_Departamento) REFERENCES Departamento(id_Departamento)
);

CREATE TABLE Tienda (
	id_Tienda INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Tienda VARCHAR(100) NOT NULL,
    id_Departamento INT UNSIGNED,
    Direccion VARCHAR(100),
    id_Bodega INT UNSIGNED,
    FOREIGN KEY (id_Departamento) REFERENCES  Departamento(id_Departamento),
    FOREIGN KEY (id_Bodega) REFERENCES Bodega(id_Bodega)
); 

CREATE TABLE Usuario (
	id_Usu INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Usuario VARCHAR(100),
    Psw VARCHAR(100),
    Rol VARCHAR(100),
    id_Tienda INT UNSIGNED,
    FOREIGN KEY (id_Tienda) REFERENCES Tienda(id_Tienda)
);

CREATE TABLE Traslado (
	id_Traslado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_Tienda_Actual INT UNSIGNED,
	id_Tienda_Nueva INT UNSIGNED,
    id_Producto INT UNSIGNED,
    Fecha_Traslado DATE,
	FOREIGN KEY (id_Tienda_Actual) REFERENCES Tienda(id_Tienda),
	FOREIGN KEY (id_Tienda_Nueva) REFERENCES Tienda(id_Tienda),
	FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);

CREATE TABLE Tienda_Producto (
	id_Tienda_Producto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_Producto INT UNSIGNED,
    id_Tienda INT UNSIGNED,
    Cantidad INT UNSIGNED,
    Saldo DOUBLE,
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto),
    FOREIGN KEY (id_Tienda) REFERENCES Tienda(id_Tienda)
);

CREATE TABLE Perfil_Usuario (
	id_Tip_Perfil INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_Usuario INT UNSIGNED,
    id_Perfil INT UNSIGNED,
    FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usu),
    FOREIGN KEY (id_Perfil) REFERENCES Perfil(id_Perfil)
);

CREATE TABLE Cliente (
	id_Cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nombres VARCHAR(100),
    N_Documento INT UNSIGNED UNIQUE,
    Email VARCHAR(100),
    Telefono INT UNSIGNED,
    Direccion VARCHAR(100),
    id_Departamento INT UNSIGNED,
    id_Usuario INT UNSIGNED,
    Fecha_Nacimiento DATE,
    FOREIGN KEY (id_Departamento) REFERENCES Departamento(id_Departamento),
    FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usu)
);

CREATE TABLE Factura_Venta (
	id_Factura_Venta INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Estado TINYINT,
    id_Cliente INT UNSIGNED,
    id_Usuario INT UNSIGNED,
    id_Tienda INT UNSIGNED,
    FOREIGN KEY (id_Cliente) REFERENCES Cliente(id_Cliente),
    FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usu),
    FOREIGN KEY (id_Tienda) REFERENCES Tienda(id_Tienda)
);

CREATE TABLE Ventas (
	id_Ventas INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Cantidad DOUBLE,
    Tipo_Descuento VARCHAR(100),
    Valor_Descuento DOUBLE,
    id_Factura INT UNSIGNED,
    id_Producto INT UNSIGNED,
    FOREIGN KEY (id_Factura) REFERENCES Factura_Venta(id_Factura_Venta),
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);




-- FOREIGN KEY (id_depto) REFERENCES departamento(id_depto)