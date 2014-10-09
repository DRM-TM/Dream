-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 09 Octobre 2014 à 11:45
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `dream`
--

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `mature` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `name` (`name`),
  KEY `name_2` (`name`),
  KEY `id_2` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `category`
--

INSERT INTO `category` (`id`, `name`, `mature`) VALUES
(1, 'WTF', 0),
(2, 'Fun', 0),
(4, 'Sexy', 1),
(5, 'Porno', 1);

-- --------------------------------------------------------

--
-- Structure de la table `dream`
--

CREATE TABLE IF NOT EXISTS `dream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `dream`
--

INSERT INTO `dream` (`id`, `user_id`, `category_id`, `content`, `date`) VALUES
(1, 1, 4, 'Loris et un concombre dans une pièce sombre.. Une licorne arc-en-ciel qui pop juste après. C''était mad.', '2014-10-08 11:41:15'),
(2, 1, 4, 'Un singe tout nu avec des pieds sur la tête qui copule avec une mouche verte.', '2014-10-08 11:41:15'),
(3, 1, 4, 'OMG ma mère avec mon père c sal wesh', '2014-10-08 16:00:53');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(1024) NOT NULL,
  `inscription_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_connection` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_token` varchar(1024) NOT NULL,
  `birthdate` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `inscription_date`, `last_connection`, `user_token`, `birthdate`) VALUES
(1, 'julien.ganichot@gmail.com', 'dbdff46e7e9cb1429e890b326a2a3133', '2014-10-08 11:31:55', '2014-10-08 11:31:55', '', '1993-06-21');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `dream`
--
ALTER TABLE `dream`
  ADD CONSTRAINT `fk_dream_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `fk_dream_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
