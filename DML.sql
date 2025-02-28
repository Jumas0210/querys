INSERT INTO Roles (Name) VALUES
('Administrador'),
('Auxiliar de Registro');

INSERT INTO Users (Name, Email, Password, RoleID) VALUES
('Carlos Pérez', 'carlosperez@email.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 1),  -- admin123 --
('Ana Rodríguez', 'anarodriguez@email.com', '68ba28fb581de8c708e71262b1a098601f24e4020c5b259077a688abe44dbdf8', 2); -- aux123 --

INSERT INTO Merchants (BusinessName, City, Phone, Email, Status, UpdatedByUser) VALUES
('Tienda La Esperanza', 'Bogotá', '3104567890', 'contacto@esperanza.com', 'Active', 1),
('Tecnología Express', 'Medellín', '3207896543', 'ventas@tecnoexpress.com', 'Active', 2),
('Verduras y Frutas San Juan', 'Cali', '3156547891', 'info@sanjuanfrutas.com', 'Active', 1),
('Moda Latina', 'Barranquilla', '3181234567', 'soporte@modalatina.com', 'Active', 2),
('Autopartes El Rayo', 'Cartagena', '3129876543', 'ventas@elrayo.com', 'Active', 1);


INSERT INTO Establishments (Name, Revenue, EmployeeCount, UpdatedByUser) VALUES
('Supermercado Los Andes', 18000.50, 10, 1),
('ElectroHogar Medellín', 25000.75, 12, 2),
('Frutería La Cosecha', 9000.25, 6, 1),
('Boutique La Elegancia', 16000.90, 8, 2),
('Taller Mecánico Turbo', 14000.10, 7, 1),
('Minimarket San Jorge', 19000.30, 11, 2),
('Almacén TecnoMóvil', 28000.00, 15, 1),
('Panadería El Trigal', 7000.80, 5, 2),
('Café Central', 12000.50, 9, 1),
('Gimnasio VitalFit', 22000.00, 10, 2);

INSERT INTO Merchant_Establishment (MerchantID, EstablishmentID) VALUES
(1, 1), (1, 6),  -- Tienda La Esperanza
(2, 2), (2, 7),  -- Tecnología Express
(3, 3), (3, 8),  -- Verduras y Frutas San Juan
(4, 4), (4, 9),  -- Moda Latina
(5, 5), (5, 10); -- Autopartes El Rayo
