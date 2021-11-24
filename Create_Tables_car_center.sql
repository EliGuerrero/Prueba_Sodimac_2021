--*********************
--*****Eliana Guerrero 
--*********************

-- Create tables section -------------------------------------------------

CREATE TABLE TIENDA(
  id_tienda Number NOT NULL,
  nombre_tienda VARCHAR2(100 CHAR),
  celular_tienda Number NOT NULL,
  direccion_tienda VARCHAR2(100 CHAR),
  email_tienda VARCHAR2(30 CHAR) NOT NULL
);

-- Add keys for table VEHICULO

ALTER TABLE TIENDA ADD CONSTRAINT PK_TIENDA PRIMARY KEY (id_tienda);


-- Table VEHICULO

CREATE TABLE VEHICULO(
  id_vehiculo Number NOT NULL,
  id_cliente Number NOT NULL,
  placa_vehiculo VARCHAR2(4 CHAR ) NOT NULL,
  marca_vehiculo VARCHAR2(20 CHAR) NOT NULL,
  modelo_vehiculo VARCHAR2(20 CHAR)
);

-- Add keys for table VEHICULO

ALTER TABLE VEHICULO ADD CONSTRAINT PK_VEHICULO PRIMARY KEY (id_vehiculo);

-- Table PERSONA

CREATE TABLE PERSONA(
  numero_identificacion Number NOT NULL,
  tipo_identificacion VARCHAR2(2 CHAR ) NOT NULL,
  primer_nombre VARCHAR2(50 CHAR) NOT NULL,
  segundo_nombre VARCHAR2(50 CHAR),
  primer_apellido VARCHAR2(50 CHAR) NOT NULL,
  segundo_apellido VARCHAR2(50 CHAR),
  celular_persona Number NOT NULL,
  direccion_persona VARCHAR2(100 CHAR),
  email_persona VARCHAR2(30 CHAR) NOT NULL
);

-- Add keys for table PERSONA

ALTER TABLE PERSONA ADD CONSTRAINT PK_PERSONA PRIMARY KEY (numero_identificacion);

-- Add check constraints
ALTER TABLE PERSONA
ADD CONSTRAINT PERSONA_CK01	Check	(tipo_identificacion IN ('CC','TE','NIT'))ENABLE;

-- Table MECANICO

CREATE TABLE MECANICO(
  id_mecanico Number NOT NULL,
  persona_numero_identificacion Number,
  id_tienda Number NOT NULL,
  estado_mecanico VARCHAR2(20 CHAR) NOT NULL
);

-- Add keys for table MECANICO

ALTER TABLE MECANICO ADD CONSTRAINT PK_MECANICO PRIMARY KEY (id_mecanico);
-- Add check constraints
ALTER TABLE MECANICO
ADD CONSTRAINT MECANICO_CK01	Check	(estado_mecanico IN ('ACTIVO','INACTIVO'))ENABLE;

-- Table CLIENTE

CREATE TABLE CLIENTE(
  id_cliente Number NOT NULL,
  persona_numero_identificacion Number NOT NULL
);

-- Add keys for table CLIENTE

ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente);

-- Table MANTENIMIENTO

CREATE TABLE MANTENIMIENTO(
  id_mantenimiento Number NOT NULL,
  id_mecanico Number NOT NULL,
  id_cliente Number NOT NULL,
  estado_mantenimiento VARCHAR2(20 CHAR) NOT NULL,
  descripcion_mantenimiento VARCHAR2(500 CHAR)
);

-- Add keys for table MANTENIMIENTO

ALTER TABLE MANTENIMIENTO ADD CONSTRAINT PK_MANTENIMIENTO PRIMARY KEY (id_mantenimiento);
-- Add check constraints
ALTER TABLE MANTENIMIENTO
ADD CONSTRAINT MANTENIMIENTO_CK01	Check	(estado_mantenimiento IN ('TERMINADO','EN PROCESO'))ENABLE;

-- Table FACTURA

CREATE TABLE FACTURA(
  id_factura Number NOT NULL,
  id_cliente Number NOT NULL,
  id_tienda Number NOT NULL,
  descripcion_factura VARCHAR2(500 CHAR)
);

-- Add keys for table FACTURA

ALTER TABLE FACTURA ADD CONSTRAINT PK_FACTURA PRIMARY KEY (id_factura);


-- Table DETALLE_FACTURA

CREATE TABLE DETALLE_FACTURA(
  id_factura Number NOT NULL,
  id_repuesto Number  NOT NULL,
  cantidad Number  NOT NULL,
  descuento Number,
  monto_total Number NOT NULL,
  fecha Date NOT NULL
);

-- Add keys for table DETALLE_FACTURA

ALTER TABLE DETALLE_FACTURA ADD CONSTRAINT PK_DETALLE_FACTURA PRIMARY KEY (id_factura,id_repuesto);

-- Table REPUESTO

CREATE TABLE REPUESTO(
  id_repuesto Number NOT NULL,
  nombre_repuesto VARCHAR2(100 CHAR) NOT NULL,
  precio Number NOT NULL
);

-- Add keys for table REPUESTO

ALTER TABLE REPUESTO ADD CONSTRAINT PK_REPUESTO PRIMARY KEY (id_repuesto);

-- Table SERVICIO

CREATE TABLE SERVICIO(
  id_servicio Number NOT NULL,
   id_mantenimiento Number NOT NULL,
  valor_minimo_servicio Number NOT NULL,
   valor_maximo_servicio Number,
  tipo_servicio VARCHAR2(200 CHAR) NOT NULL,
   descripcion_servicio VARCHAR2(500 CHAR)
);

-- Add keys for table SERVICIO

ALTER TABLE SERVICIO ADD CONSTRAINT PK_SERVICIO PRIMARY KEY (id_servicio);

-- Table PRESUPUESTO

CREATE TABLE PRESUPUESTO(
  id_presupuesto Number NOT NULL,
   id_cliente Number NOT NULL,
  monto_presupuesto Number,
  fecha_presupuesto Date
);

-- Add keys for table PRESUPUESTO

ALTER TABLE PRESUPUESTO ADD CONSTRAINT PK_PRESUPUESTO PRIMARY KEY (id_presupuesto);


-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE MANTENIMIENTO ADD CONSTRAINT FK1_MANTENIMIENTO FOREIGN KEY (id_mecanico) REFERENCES MECANICO (id_mecanico);

ALTER TABLE MANTENIMIENTO ADD CONSTRAINT FK2_MANTENIMIENTO FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente);

ALTER TABLE MECANICO ADD CONSTRAINT FK1_MECANICO FOREIGN KEY (persona_numero_identificacion) REFERENCES PERSONA (numero_identificacion);

ALTER TABLE MECANICO ADD CONSTRAINT FK2_MECANICO FOREIGN KEY (id_tienda) REFERENCES TIENDA (id_tienda);

ALTER TABLE DETALLE_FACTURA ADD CONSTRAINT FK1_DETALLE_FACTURA FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura);

ALTER TABLE DETALLE_FACTURA ADD CONSTRAINT FK2_DETALLE_FACTURA FOREIGN KEY (id_repuesto) REFERENCES REPUESTO (id_repuesto);

ALTER TABLE CLIENTE ADD CONSTRAINT FK1_CLIENTE FOREIGN KEY (persona_numero_identificacion) REFERENCES PERSONA (numero_identificacion);

ALTER TABLE VEHICULO ADD CONSTRAINT FK1_VEHICULO FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente);

ALTER TABLE PRESUPUESTO ADD CONSTRAINT FK1_PRESUPUESTO FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente);

ALTER TABLE FACTURA ADD CONSTRAINT FK1_FACTURA FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente);

ALTER TABLE FACTURA ADD CONSTRAINT FK2_FACTURA FOREIGN KEY (id_tienda) REFERENCES TIENDA (id_tienda);

ALTER TABLE SERVICIO ADD CONSTRAINT FK1_SERVICIO FOREIGN KEY (id_mantenimiento) REFERENCES MANTENIMIENTO (id_mantenimiento);
