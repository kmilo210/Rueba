------------------------------------ DROP TABLE ---------------------------------------

DROP TABLE IF EXISTS tienda CASCADE;
DROP TABLE IF EXISTS electrodomestico CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS venta CASCADE;

------------------------------------- CREATE TABLE ---------------------------------

CREATE TABLE tienda(
	tienda_id VARCHAR(5) PRIMARY KEY NOT NULL,
	nombre_tienda VARCHAR(10) NOT NULL,
	direccion VARCHAR(20) NOT NULL,
	telefono VARCHAR(10) NOT NULL
);

CREATE TABLE electrodomestico(
	codigo VARCHAR(10) PRIMARY KEY NOT NULL,
	descripcion TEXT,
	precio INTEGER
);

CREATE TABLE cliente(
	cedula VARCHAR(10) PRIMARY KEY NOT NULL,
	nombre VARCHAR(10) NOT NULl,
	direccion VARCHAR(10) NOT NULL,
	telefono VARCHAR(10) NOT NULL
);

CREATE TABLE venta(
	codigo_tienda VARCHAR(10),
	codigo_electrodomestico VARCHAR(10),
	cliente_id VARCHAR(10),
	descuento FLOAT,
	fecha DATE,

	PRIMARY KEY (codigo_tienda, codigo_electrodomestico, cliente_id),
	FOREIGN KEY (codigo_tienda) REFERENCES tienda(tienda_id),
	FOREIGN KEY (codigo_electrodomestico) REFERENCES electrodomestico(codigo),
	FOREIGN KEY (cliente_id) REFERENCES cliente(cedula)
);

------------------------------------------- DATOS ---------------------------------------------


--------------------- TIENDA --------------------------
INSERT INTO tienda (tienda_id, nombre_tienda, direccion, telefono) VALUES
('T1', 'Tienda A', 'Calle 123', '1234567890'),
('T2', 'Tienda B', 'Avenida XYZ', '0987654321'),
('T3', 'Tienda C', 'Calle Principal', '1112223333'),
('T4', 'Tienda D', 'Avenida Central', '4445556666'),
('T5', 'Tienda E', 'Calle Secundaria', '7778889999'),
('T6', 'Tienda F', 'Avenida Norte', '2223334444'),
('T7', 'Tienda G', 'Calle Sur', '5556667777'),
('T8', 'Tienda H', 'Avenida Este', '8889990000'),
('T9', 'Tienda I', 'Calle Oeste', '3334445555'),
('T10', 'Tienda J', 'Avenida 20', '6667778888');


---------------- ELECTRODOMESTICO -------------------------------

INSERT INTO electrodomestico (codigo, descripcion, precio) VALUES
('E1', 'Nevera', 1000),
('E2', 'Televisor', 800),
('E3', 'Lavadora', 600),
('E4', 'Microondas', 200),
('E5', 'Licuadora', 50),
('E6', 'Aspiradora', 150),
('E7', 'Horno', 300),
('E8', 'Secadora', 700),
('E9', 'Cafetera', 80),
('E10', 'Tostadora', 40);

------------------------- CLIENTE -----------------------------

INSERT INTO cliente (cedula, nombre, direccion, telefono) VALUES
('C1', 'Cliente A', 'Calle 1', '1111111111'),
('C2', 'Cliente B', 'Avenida 2', '2222222222'),
('C3', 'Cliente C', 'Calle 3', '3333333333'),
('C4', 'Cliente D', 'Avenida 4', '4444444444'),
('C5', 'Cliente E', 'Calle 5', '5555555555'),
('C6', 'Cliente F', 'Avenida 6', '6666666666'),
('C7', 'Cliente G', 'Calle 7', '7777777777'),
('C8', 'Cliente H', 'Avenida 8', '8888888888'),
('C9', 'Cliente I', 'Calle 9', '9999999999'),
('C10', 'Cliente J', 'Avenida 10', '1010101010');

-------------------- VENTA ----------------------------

INSERT INTO venta (codigo_tienda, codigo_electrodomestico, cliente_id, descuento, fecha) VALUES
('T1', 'E1', 'C1', 0.10, '2024-01-01'),
('T2', 'E2', 'C2', 0.05, '2024-01-02'),
('T3', 'E3', 'C3', 0.12, '2024-01-03'),
('T4', 'E4', 'C4', 0.08, '2024-01-04'),
('T5', 'E5', 'C5', 0.15, '2024-01-05'),
('T6', 'E6', 'C6', 0.10, '2024-01-06'),
('T7', 'E7', 'C7', 0.05, '2024-01-07'),
('T8', 'E8', 'C8', 0.12, '2024-01-08'),
('T9', 'E9', 'C9', 0.08, '2024-01-09'),
('T10', 'E10', 'C10', 0.20, '2024-01-10'),
('T10', 'E1', 'C10', 0.15, '2024-01-10');

-----------------------------------------------------------------------------------------------------------

--- CONSULTAS

------------------------------------------------------------------------------------------------------------

--- 1 ---
SELECT DISTINCT nombre, direccion
FROM cliente INNER JOIN venta ON cliente.cedula = venta.cliente_id 
INNER JOIN electrodomestico ON venta.codigo_electrodomestico = electrodomestico.codigo
WHERE venta.descuento > 0.1;


--- 2 ---

SELECT nombre_tienda, direccion
FROM tienda INNER JOIN venta ON tienda.tienda_id = venta.codigo_tienda
WHERE venta.descuento < 0.15

EXCEPT

SELECT nombre_tienda, direccion
FROM tienda INNER JOIN venta ON tienda.tienda_id = venta.codigo_tienda
WHERE venta.descuento >= 0.15;


--- 4 ---
SELECT descripcion
FROM electrodomestico INNER JOIN venta ON electrodomestico.codigo = venta.codigo_electrodomestico
WHERE venta.descuento = 0.10

INTERSECT

SELECT descripcion
FROM electrodomestico INNER JOIN venta ON electrodomestico.codigo = venta.codigo_electrodomestico
WHERE venta.descuento = 0.15;


--- 5 ---
SELECT nombre_tienda, telefono
FROM tienda
	
EXCEPT

SELECT nombre_tienda, telefono
FROM tienda INNER JOIN venta ON tienda.tienda_id = venta.codigo_tienda
	INNER JOIN electrodomestico ON venta.codigo_electrodomestico = electrodomestico.codigo
WHERE electrodomestico.codigo = 'E1';