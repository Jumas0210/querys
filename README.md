# Base de datos - OLSoftware (SQL Server)

## Descripción
Este proyecto utiliza SQL Server como sistema de gestión de base de datos para almacenar la información de comerciantes, establecimientos y usuarios. Se implementó un modelo relacional normalizado con auditoría automatizada mediante triggers.

## Estructura de la Base de Datos
Se implementaron las siguientes tablas:

- Usuarios: Contiene la información de autenticación.
- Roles: Define los roles dentro del sistema (Administrador, Auxiliar).
- Comerciantes: Almacena datos de los comerciantes registrados.
- Establecimientos: Contiene la información de los establecimientos.
- Establecimientos_Comerciantes: Tabla intermedia para la relación entre comerciantes y establecimientos.

## Características Implementadas
- Base de datos normalizada con relaciones bien definidas.
- Identificadores únicos generados como IDENTITY.
- Triggers para auditoría de inserción y actualización.
- Datos semilla generados para facilitar pruebas.
- Procedimiento almacenado para consultar comerciantes activos con datos agregados.
