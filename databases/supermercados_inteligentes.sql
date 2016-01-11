-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 11-01-2016 a las 14:51:05
-- Versión del servidor: 5.5.46-0ubuntu0.14.04.2
-- Versión de PHP: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `supermercados_inteligentes`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_items`
--

CREATE TABLE IF NOT EXISTS `supers_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_items_por_supermercado`
--

CREATE TABLE IF NOT EXISTS `supers_items_por_supermercado` (
  `items_por_supermercado_id` int(11) NOT NULL AUTO_INCREMENT,
  `items_por_supermercado_item_id` int(11) NOT NULL COMMENT 'FK con tabla items',
  `items_por_supermercado_item_precio` int(11) NOT NULL,
  `items_por_supermercado_supermercado_id` int(11) NOT NULL COMMENT 'FK con tabla supermercados',
  `items_por_supermercado_items_disponibles` int(11) NOT NULL,
  PRIMARY KEY (`items_por_supermercado_id`),
  KEY `supermercado` (`items_por_supermercado_supermercado_id`),
  KEY `item` (`items_por_supermercado_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_items_por_transaccion`
--

CREATE TABLE IF NOT EXISTS `supers_items_por_transaccion` (
  `item_por_transaccion_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_por_transaccion_item_id` int(11) NOT NULL COMMENT 'FK con tabla items',
  `item_por_transaccion_usuario_id` int(11) NOT NULL COMMENT 'FK con tabla usuarios',
  `item_por_transaccion_supermercado_id` int(11) NOT NULL COMMENT 'FK con tabla supermercados',
  `item_por_transaccion_fecha` datetime NOT NULL,
  PRIMARY KEY (`item_por_transaccion_id`),
  KEY `item` (`item_por_transaccion_item_id`),
  KEY `usuario` (`item_por_transaccion_usuario_id`),
  KEY `supermercado` (`item_por_transaccion_supermercado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_localidades`
--

CREATE TABLE IF NOT EXISTS `supers_localidades` (
  `localidad_id` int(11) NOT NULL AUTO_INCREMENT,
  `localidad_nombre` varchar(70) NOT NULL,
  `localidad_provincia_id` int(11) NOT NULL COMMENT 'FK con tabla provincias',
  `localidad_pais_id` int(11) NOT NULL COMMENT 'FK con tabla paises',
  PRIMARY KEY (`localidad_id`),
  KEY `provincia` (`localidad_provincia_id`),
  KEY `pais` (`localidad_pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_paises`
--

CREATE TABLE IF NOT EXISTS `supers_paises` (
  `pais_id` int(11) NOT NULL AUTO_INCREMENT,
  `pais_nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_provincias`
--

CREATE TABLE IF NOT EXISTS `supers_provincias` (
  `provincia_id` int(11) NOT NULL AUTO_INCREMENT,
  `provincia_nombre` varchar(70) NOT NULL,
  `provincia_pais_id` int(11) NOT NULL COMMENT 'El id del pais adonde pertence la provincia. Vinculo entre tablas',
  PRIMARY KEY (`provincia_id`),
  KEY `pais` (`provincia_pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_supermercados`
--

CREATE TABLE IF NOT EXISTS `supers_supermercados` (
  `supermercado_id` int(11) NOT NULL AUTO_INCREMENT,
  `supermercado_nombre` varchar(255) NOT NULL,
  `supermercado_direccion_1` int(11) NOT NULL,
  `supermercado_direccion_2` int(11) NOT NULL,
  `supermercado_localidad_id` int(11) NOT NULL COMMENT 'FK con tabla localidades',
  `supermercado_provincia_id` int(11) NOT NULL COMMENT 'FK con tabla provincias',
  `supermercado_pais_id` int(11) NOT NULL COMMENT 'FK con tabla paises',
  PRIMARY KEY (`supermercado_id`),
  KEY `localidad` (`supermercado_localidad_id`),
  KEY `provincia` (`supermercado_provincia_id`),
  KEY `pais` (`supermercado_pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_transacciones`
--

CREATE TABLE IF NOT EXISTS `supers_transacciones` (
  `transaccion_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaccion_fecha` datetime NOT NULL,
  `transaccion_usuario` int(11) NOT NULL COMMENT 'FK con tabla usuarios',
  `transaccion_supermercado` int(11) NOT NULL COMMENT 'FK con tabla supermercados',
  PRIMARY KEY (`transaccion_id`),
  KEY `usuario` (`transaccion_usuario`),
  KEY `supermercado` (`transaccion_supermercado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supers_usuarios`
--

CREATE TABLE IF NOT EXISTS `supers_usuarios` (
  `usuario_id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_validado` tinyint(1) NOT NULL,
  `usuario_nombre_completo` varchar(150) NOT NULL,
  `usuario_email` varchar(255) NOT NULL,
  `usuario_telefono` tinyint(4) NOT NULL,
  `usuario_direccion_1` varchar(255) NOT NULL,
  `usuario_direccion_2` varchar(255) NOT NULL,
  `usuario_localidad` int(11) NOT NULL COMMENT 'FK con tabla localidades',
  `usuario_provincia` int(11) NOT NULL COMMENT 'FK con tabla provincias',
  `usuario_pais` int(11) NOT NULL COMMENT 'FK con tabla paises',
  `usuario_puntuacion` int(11) NOT NULL,
  PRIMARY KEY (`usuario_id`),
  KEY `localidad` (`usuario_localidad`),
  KEY `provincia` (`usuario_provincia`),
  KEY `pais` (`usuario_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `supers_items_por_supermercado`
--
ALTER TABLE `supers_items_por_supermercado`
  ADD CONSTRAINT `supers_items_por_supermercado_ibfk_2` FOREIGN KEY (`items_por_supermercado_item_id`) REFERENCES `supers_items` (`item_id`),
  ADD CONSTRAINT `supers_items_por_supermercado_ibfk_1` FOREIGN KEY (`items_por_supermercado_supermercado_id`) REFERENCES `supers_supermercados` (`supermercado_id`);

--
-- Filtros para la tabla `supers_items_por_transaccion`
--
ALTER TABLE `supers_items_por_transaccion`
  ADD CONSTRAINT `supers_items_por_transaccion_ibfk_3` FOREIGN KEY (`item_por_transaccion_supermercado_id`) REFERENCES `supers_supermercados` (`supermercado_id`),
  ADD CONSTRAINT `supers_items_por_transaccion_ibfk_1` FOREIGN KEY (`item_por_transaccion_item_id`) REFERENCES `supers_items` (`item_id`),
  ADD CONSTRAINT `supers_items_por_transaccion_ibfk_2` FOREIGN KEY (`item_por_transaccion_usuario_id`) REFERENCES `supers_usuarios` (`usuario_id`);

--
-- Filtros para la tabla `supers_localidades`
--
ALTER TABLE `supers_localidades`
  ADD CONSTRAINT `supers_localidades_ibfk_2` FOREIGN KEY (`localidad_pais_id`) REFERENCES `supers_paises` (`pais_id`),
  ADD CONSTRAINT `supers_localidades_ibfk_1` FOREIGN KEY (`localidad_provincia_id`) REFERENCES `supers_provincias` (`provincia_id`);

--
-- Filtros para la tabla `supers_provincias`
--
ALTER TABLE `supers_provincias`
  ADD CONSTRAINT `supers_provincias_ibfk_1` FOREIGN KEY (`provincia_pais_id`) REFERENCES `supers_paises` (`pais_id`);

--
-- Filtros para la tabla `supers_supermercados`
--
ALTER TABLE `supers_supermercados`
  ADD CONSTRAINT `supers_supermercados_ibfk_3` FOREIGN KEY (`supermercado_pais_id`) REFERENCES `supers_paises` (`pais_id`),
  ADD CONSTRAINT `supers_supermercados_ibfk_1` FOREIGN KEY (`supermercado_localidad_id`) REFERENCES `supers_localidades` (`localidad_id`),
  ADD CONSTRAINT `supers_supermercados_ibfk_2` FOREIGN KEY (`supermercado_provincia_id`) REFERENCES `supers_provincias` (`provincia_id`);

--
-- Filtros para la tabla `supers_transacciones`
--
ALTER TABLE `supers_transacciones`
  ADD CONSTRAINT `supers_transacciones_ibfk_2` FOREIGN KEY (`transaccion_supermercado`) REFERENCES `supers_supermercados` (`supermercado_id`),
  ADD CONSTRAINT `supers_transacciones_ibfk_1` FOREIGN KEY (`transaccion_usuario`) REFERENCES `supers_usuarios` (`usuario_id`);

--
-- Filtros para la tabla `supers_usuarios`
--
ALTER TABLE `supers_usuarios`
  ADD CONSTRAINT `supers_usuarios_ibfk_3` FOREIGN KEY (`usuario_pais`) REFERENCES `supers_paises` (`pais_id`),
  ADD CONSTRAINT `supers_usuarios_ibfk_1` FOREIGN KEY (`usuario_localidad`) REFERENCES `supers_localidades` (`localidad_id`),
  ADD CONSTRAINT `supers_usuarios_ibfk_2` FOREIGN KEY (`usuario_provincia`) REFERENCES `supers_provincias` (`provincia_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
