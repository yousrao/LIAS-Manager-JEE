-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 21 oct. 2026 à 02:21
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `lias_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `convention`
--

CREATE TABLE `convention` (
  `id` bigint(20) NOT NULL,
  `date_signature` date DEFAULT NULL,
  `objectif` varchar(255) DEFAULT NULL,
  `partenaire` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `convention`
--

INSERT INTO `convention` (`id`, `date_signature`, `objectif`, `partenaire`, `type`) VALUES
(1, '2023-01-10', 'Financement de projets de recherche et bourses.', 'CNRST - Maroc', 'NATIONALE'),
(2, '2022-05-15', 'Co-encadrement de thèses et mobilité doctorants.', 'Université de Lorraine - France', 'INTERNATIONALE'),
(3, '2023-09-20', 'Échange d enseignants et de chercheurs.', 'Erasmus+', 'INTERNATIONALE'),
(4, '2024-02-01', 'Projet de recherche sur l IA appliquée à l industrie.', 'OCP Group', 'INDUSTRIELLE');

-- --------------------------------------------------------

--
-- Structure de la table `document`
--

CREATE TABLE `document` (
  `id` bigint(20) NOT NULL,
  `date_depot` date DEFAULT NULL,
  `lien_fichier` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `document`
--

INSERT INTO `document` (`id`, `date_depot`, `lien_fichier`, `titre`, `type`) VALUES
(1, '2025-01-10', 'https://lias.ma/admin/docs/fin-2025.pdf', 'Demande de financement CNRST 2025', 'FINANCEMENT'),
(2, '2025-02-15', 'https://lias.ma/admin/docs/prog-2025.pdf', 'Programme des Doctoriales Ben M’Sik', 'PROGRAMME'),
(3, '2024-09-01', 'https://lias.ma/admin/docs/reglement.pdf', 'Règlement intérieur du Laboratoire', 'ADMINISTRATIF'),
(4, '2025-03-05', 'https://lias.ma/admin/docs/modele-att.docx', 'Modèle d attestation de recherche', 'ATTESTATION');

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

CREATE TABLE `evenement` (
  `id` bigint(20) NOT NULL,
  `date_evenement` date DEFAULT NULL,
  `lieu` varchar(255) DEFAULT NULL,
  `organisateur` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `evenement`
--

INSERT INTO `evenement` (`id`, `date_evenement`, `lieu`, `organisateur`, `titre`, `type`) VALUES
(1, '2025-06-15', 'Amphi 8, Faculté Ben M’Sik', 'Pr. Faouzia Benabbou', 'Journée d’étude : IA et Cybersécurité', 'CONFERENCE'),
(2, '2025-09-20', 'Salle de conférences LIAS', 'Pr. Abdessamad Belangour', 'Workshop : Big Data Analytics', 'WORKSHOP'),
(3, '2025-11-10', 'Bibliothèque du Laboratoire', 'Pr. Nawal Sael', 'Séminaire Doctoral : Méthodologie de recherche', 'SEMINAIRE'),
(4, '2025-12-05', 'Centre de Recherche', 'Direction du Labo', 'Doctoriales du LIAS 2025', 'CONFERENCE'),
(5, '2026-02-15', 'Laboratoire Informatique', 'Pr. Mohammed AIT DAOUD', 'Formation : Cloud et Microservices', 'WORKSHOP'),
(6, '2026-09-15', 'Amphi 8', 'Mr belangour', 'Réunion de rentrée 2027', 'CONFERENCE');

-- --------------------------------------------------------

--
-- Structure de la table `materiel`
--

CREATE TABLE `materiel` (
  `id` bigint(20) NOT NULL,
  `etat` varchar(255) DEFAULT NULL,
  `marque` varchar(255) DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `numero_inventaire` varchar(255) DEFAULT NULL,
  `detenteur_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `materiel`
--

INSERT INTO `materiel` (`id`, `etat`, `marque`, `nom`, `numero_inventaire`, `detenteur_id`) VALUES
(1, 'NEUF', 'Dell Precision', 'Station de travail IA', 'LIAS-2024-001', 1),
(2, 'BON', 'NVIDIA DGX', 'Serveur de Calcul GPU', 'LIAS-2023-005', 2),
(3, 'NEUF', 'MacBook Pro M3', 'Ordinateur Portable Recherche', 'LIAS-2024-012', 3),
(4, 'BON', 'Arduino/Raspberry', 'Kit Capteurs IoT', 'LIAS-IOT-08', 6),
(5, 'USÉ', 'Epson Pro', 'Vidéoprojecteur Amphi', 'FAC-BMS-99', 5),
(6, 'BON', 'Synology NAS', 'Unité de stockage Cloud', 'LIAS-ST-02', 1);

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE `message` (
  `id` bigint(20) NOT NULL,
  `contenu` varchar(255) DEFAULT NULL,
  `date_envoi` datetime(6) DEFAULT NULL,
  `expediteur` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `message`
--

INSERT INTO `message` (`id`, `contenu`, `date_envoi`, `expediteur`) VALUES
(1, 'il nous faut une reunion vers 8h demain. merci', '2026-06-13 16:05:51.000000', 'Pr. Faouzia Benabbou'),
(2, 'ça marche', '2026-06-13 16:48:59.000000', 'Pr. Abdessamad Belangour'),
(3, 'Bonjour tout le monde', '2026-06-22 15:46:46.000000', 'Pr. Abdessamad Belangour');

-- --------------------------------------------------------

--
-- Structure de la table `notification`
--

CREATE TABLE `notification` (
  `id` bigint(20) NOT NULL,
  `date_notif` datetime(6) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `notification`
--

INSERT INTO `notification` (`id`, `date_notif`, `message`, `type`) VALUES
(1, '2026-06-13 17:30:06.000000', 'Nouvel événement : Réunion de rentrée 2027', 'ÉVÉNEMENT'),
(6, '2026-06-13 18:06:44.000000', 'Nouveau candidat : Amine Mandid', 'DEMANDE'),
(9, '2026-06-22 16:04:13.000000', 'Nouvelle candidature : nouhaila bennani', 'DEMANDE'),
(11, '2026-06-22 16:14:10.000000', 'Événement créé : Big Data', 'ÉVÉNEMENT'),
(15, '2026-06-23 13:22:49.000000', 'Matériel mis à jour : pc', 'MATÉRIEL'),
(16, '2026-06-23 13:22:59.000000', 'Matériel mis à jour : pc', 'MATÉRIEL'),
(17, '2026-10-20 22:33:06.000000', 'Nouvelle candidature : ouatile yousra', 'DEMANDE'),
(18, '2026-10-20 22:33:38.000000', 'Candidat accepté : ouatile yousra', 'VALIDATION'),
(19, '2026-10-20 22:33:57.000000', 'Mise à jour membre : ouatile yousra', 'MEMBRE'),
(20, '2026-10-20 22:34:18.000000', 'Mise à jour membre : ouatile yousra', 'MEMBRE'),
(21, '2026-10-20 22:35:22.000000', 'Nouvelle publication : Big Data', 'RECHERCHE'),
(22, '2026-10-21 00:08:01.000000', 'Nouvelle candidature : ouatile yousra', 'DEMANDE'),
(23, '2026-10-21 00:08:48.000000', 'Mise à jour membre : ouatile yousra', 'MEMBRE'),
(24, '2026-10-21 00:08:59.000000', 'Mise à jour membre : ouatile yousra', 'MEMBRE'),
(25, '2026-10-21 00:09:27.000000', 'Candidat accepté : ouatile yousra', 'VALIDATION'),
(26, '2026-10-21 00:09:51.000000', 'Mise à jour membre : ouatile yousra', 'MEMBRE');

-- --------------------------------------------------------

--
-- Structure de la table `publication`
--

CREATE TABLE `publication` (
  `id` bigint(20) NOT NULL,
  `annee` int(11) NOT NULL,
  `lien` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `auteur_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `publication`
--

INSERT INTO `publication` (`id`, `annee`, `lien`, `titre`, `type`, `auteur_id`) VALUES
(6, 2024, 'https://doi.org/10.123/lias.01', 'A Framework for Big Data Analytics in Smart Cities', 'ARTICLE', 1),
(7, 2023, 'https://lias.ma/pub/nlp-2023', 'Deep Learning Models for Arabic NLP', 'CONFERENCE', 2),
(8, 2023, 'https://doi.org/10.456/cloud.ma', 'Cloud Computing Adoption in Morocco', 'ARTICLE', 7),
(9, 2024, 'https://lias.ma/pub/blockchain', 'Blockchain Security for IoT Devices', 'ARTICLE', 6),
(10, 2022, 'https://lias.ma/books/arch', 'Advanced Software Architectures', 'LIVRE', 6);

-- --------------------------------------------------------

--
-- Structure de la table `reunion`
--

CREATE TABLE `reunion` (
  `id` bigint(20) NOT NULL,
  `date_reunion` date DEFAULT NULL,
  `lienpv` varchar(255) DEFAULT NULL,
  `ordre_du_jour` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reunion`
--

INSERT INTO `reunion` (`id`, `date_reunion`, `lienpv`, `ordre_du_jour`, `titre`) VALUES
(1, '2025-09-15', 'https://lias.ma/pv/rentree-2025.pdf', 'Calendrier annuel, accueil des nouveaux doctorants, budget 2026.', 'Réunion de rentrée du Laboratoire'),
(2, '2025-10-20', 'https://lias.ma/pv/comite-oct-2025.pdf', 'Examen des dossiers de réinscription, validation des thèmes de recherche.', 'Comité Scientifique : Validation des thèses'),
(3, '2025-11-05', 'https://lias.ma/pv/conseil-mat-2025.pdf', 'Répartition des nouveaux serveurs de calcul GPU et stations de travail.', 'Conseil de laboratoire : Distribution matériel'),
(4, '2025-12-10', 'https://lias.ma/pv/coord-isdiac.pdf', 'Suivi des publications de l équipe et préparation du workshop IA.', 'Réunion de coordination : Axe ISDIAC');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `equipe` varchar(255) DEFAULT NULL,
  `themes` text DEFAULT NULL,
  `actif` bit(1) NOT NULL,
  `date_adhesion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `email`, `nom`, `password`, `role`, `statut`, `equipe`, `themes`, `actif`, `date_adhesion`) VALUES
(1, 'f.benabbou@univmsik.ma', 'Pr. Faouzia Benabbou', '123456', 'DIRECTEUR', 'PERMANENT', 'ISDIAC', 'IA, Cloud, NLP', b'1', '2021-01-15'),
(2, 'n.sael@univmsik.ma', 'Pr. Nawal Sael', '123456', 'CHEF_EQUIPE', 'PERMANENT', 'ISDIAC', 'Sciences de donnée', b'1', '2021-03-10'),
(3, 'm.aitdaoud@univmsik.ma', 'Pr. Mohammed AIT DAOUD', '123456', 'CHEF_EQUIPE', 'PERMANENT', 'SIMA', 'Systèmes intelligents et modélisation avancée', b'1', '2021-05-20'),
(4, 's.ouahabi@univmsik.ma', 'Pr. Sara Ouahabi', '123456', 'CHEF_EQUIPE', 'PERMANENT', 'SDTIC', 'Technologie intelligente', b'1', '2021-09-05'),
(5, 'a.ettaoufik@univmsik.ma', 'Pr. Abdelaziz Ettaoufik', '123456', 'CHEF_EQUIPE', 'PERMANENT', 'ILIAS', 'Génie Logiciel', b'1', '2021-10-15'),
(6, 'a.belangour@univmsik.ma', 'Pr. Abdessamad Belangour', '123456', 'DIRECTEUR_ADJOINT', 'PERMANENT', 'ILIAS', 'Ingénierie logicielle, architectures de données', b'1', '2021-01-15'),
(7, 'a.zaouch@univmsik.ma', 'Amal Zaouch', '123456', 'MEMBRE', 'PERMANENT', 'ISDIAC', 'Cloud Computing', b'1', '2022-02-01'),
(8, 'f.elazzaby@univmsik.ma', 'Fouzia Elazzaby', '123456', 'MEMBRE', 'PERMANENT', 'ISDIAC', 'Traitement de signal et d’images', b'1', '2022-02-01'),
(9, 'k.achtaich@univmsik.ma', 'Khadija Achtaich', '123456', 'MEMBRE', 'PERMANENT', 'SIMA', 'Technologies Cognitives', b'1', '2022-02-01'),
(10, 'm.hanoune@univmsik.ma', 'Mostafa Hanoune', '123456', 'MEMBRE', 'PERMANENT', 'SIMA', 'Systèmes Intelligents', b'1', '2022-02-01'),
(11, 'n.aharrane@univmsik.ma', 'Nabil AHARRANE', '123456', 'MEMBRE', 'PERMANENT', 'SIMA', 'Intelligence Artificielle', b'1', '2023-09-10'),
(12, 's.elfilali@univmsik.ma', 'Sanaa El filali', '123456', 'MEMBRE', 'PERMANENT', 'SDTIC', 'Technologie intelligente', b'1', '2023-09-10'),
(13, 'r.aitabdelouahid@univmsik.ma', 'Rachida AIT ABDELOUAHID', '123456', 'MEMBRE', 'PERMANENT', 'SDTIC', 'Architecture IOT', b'1', '2023-09-10'),
(14, 'n.achtaich@univmsik.ma', 'Naceur Achtaich', '123456', 'MEMBRE', 'PERMANENT', 'SDTIC', 'Mathématiques Appliqués', b'1', '2023-09-10'),
(15, 'y.sekhara@univmsik.ma', 'Youssef Sekhara', '123456', 'MEMBRE', 'PERMANENT', 'ILIAS', 'Informatique', b'1', '2024-01-15'),
(16, 'd.bouggar@univmsik.ma', 'Driss Bouggar', '123456', 'MEMBRE', 'PERMANENT', 'ILIAS', 'Modélisation Mathématique', b'1', '2024-01-15'),
(23, 'o.yousra@univmsik.ma', 'Ouatile', NULL, 'MEMBRE', 'RETRAITE', 'ILIAS', 'optimis', b'0', '2026-06-13'),
(25, 'M.amine@univmsik.ma', 'Amine Mandid', '123456', 'VISITEUR', 'DOCTORANT', 'SIMA', 'Developpement', b'1', '2026-06-13'),
(30, 'Nouhaila.bennani@student.ma', 'nouhaila bennani', '123456', 'VISITEUR', 'DOCTORANT', 'ISDIAC', 'optimis', b'1', '2026-06-22');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `convention`
--
ALTER TABLE `convention`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `materiel`
--
ALTER TABLE `materiel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKh9uxq9yw1x0fbh2wjjv9yc5ej` (`detenteur_id`);

--
-- Index pour la table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `publication`
--
ALTER TABLE `publication`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKjjqaki18anhrv7msuqj5rtskq` (`auteur_id`);

--
-- Index pour la table `reunion`
--
ALTER TABLE `reunion`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `convention`
--
ALTER TABLE `convention`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `document`
--
ALTER TABLE `document`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `evenement`
--
ALTER TABLE `evenement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `materiel`
--
ALTER TABLE `materiel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `publication`
--
ALTER TABLE `publication`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `reunion`
--
ALTER TABLE `reunion`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `materiel`
--
ALTER TABLE `materiel`
  ADD CONSTRAINT `FKh9uxq9yw1x0fbh2wjjv9yc5ej` FOREIGN KEY (`detenteur_id`) REFERENCES `utilisateur` (`id`);

--
-- Contraintes pour la table `publication`
--
ALTER TABLE `publication`
  ADD CONSTRAINT `FKjjqaki18anhrv7msuqj5rtskq` FOREIGN KEY (`auteur_id`) REFERENCES `utilisateur` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
