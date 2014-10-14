-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Client: roemer.im
-- Généré le: Mar 14 Octobre 2014 à 09:45
-- Version du serveur: 10.0.12-MariaDB-1~wheezy-log
-- Version de PHP: 5.3.28

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `dream`
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
-- Structure de la table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `dream_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `post_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `dream_id` (`dream_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `comment`
--

INSERT INTO `comment` (`id`, `user_id`, `dream_id`, `content`, `post_date`) VALUES
(1, 1, 2, 'Omg c drol', '2014-10-14 10:11:24'),
(2, 1, 1, 'Hahahhaahahaah énorme', '2014-10-14 10:11:32');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `dream`
--

INSERT INTO `dream` (`id`, `user_id`, `category_id`, `content`, `date`) VALUES
(1, 1, 4, 'Loris et un concombre dans une pièce sombre.. Une licorne arc-en-ciel qui pop juste après. C''était mad.', '2014-10-08 11:41:15'),
(2, 1, 4, 'Un singe tout nu avec des pieds sur la tête qui copule avec une mouche verte.', '2014-10-08 11:41:15'),
(3, 1, 4, 'OMG ma mère avec mon père c sal wesh', '2014-10-08 16:00:53'),
(4, 1, 4, 'Test sql', '2014-10-10 15:17:19'),
(5, 1, 4, 'Bonjour gros bot', '2014-10-10 15:26:39');

-- --------------------------------------------------------

--
-- Structure de la table `hashtag`
--

CREATE TABLE IF NOT EXISTS `hashtag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `dream_id` int(11) NOT NULL,
  `content` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`),
  KEY `user_id_2` (`user_id`),
  KEY `dream_id` (`dream_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
-- Contraintes pour la table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`dream_id`) REFERENCES `dream` (`id`);

--
-- Contraintes pour la table `dream`
--
ALTER TABLE `dream`
  ADD CONSTRAINT `fk_dream_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `fk_dream_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `hashtag`
--
ALTER TABLE `hashtag`
  ADD CONSTRAINT `hashtag_ibfk_2` FOREIGN KEY (`dream_id`) REFERENCES `dream` (`id`),
  ADD CONSTRAINT `hashtag_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
