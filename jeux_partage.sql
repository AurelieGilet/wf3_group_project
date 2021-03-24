-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 24 mars 2021 à 21:26
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 7.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `jeux_partage`
--

-- --------------------------------------------------------

--
-- Structure de la table `borrowing`
--

CREATE TABLE `borrowing` (
  `id` int(11) NOT NULL,
  `lender_id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `return_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `borrowing`
--

INSERT INTO `borrowing` (`id`, `lender_id`, `borrower_id`, `game_id`, `start_date`, `end_date`, `return_date`) VALUES
(1, 10, 2, 1, '2021-02-14 21:13:02', '2021-03-14 21:13:02', '2021-03-13 13:28:02'),
(2, 5, 2, 10, '2021-03-16 10:45:02', '2021-04-13 10:45:02', NULL),
(3, 10, 7, 2, '2021-02-02 13:38:45', '2021-03-02 13:38:45', '2021-02-28 16:18:45');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20210322111743', '2021-03-22 17:51:19', 962);

-- --------------------------------------------------------

--
-- Structure de la table `game`
--

CREATE TABLE `game` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('adresse','memoire','cartes','connaissance','des','lettres','logique','strategie','cooperation') COLLATE utf8mb4_unicode_ci NOT NULL,
  `public` enum('6+','8+','10+') COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_players` int(11) NOT NULL,
  `max_players` int(11) DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `game`
--

INSERT INTO `game` (`id`, `owner_id`, `name`, `category`, `public`, `min_players`, `max_players`, `description`, `image`) VALUES
(1, 10, 'Parade', 'cartes', '6+', 2, 6, 'Parade vous invite au Pays des Merveilles... Alice et ses amis égaient agréablement les cartes de ce petit jeu de pose bien sympathique.\r\n\r\nLe principe du jeu - Comme dans \"6 qui prend\", on tentera d\'éviter de ramasser des cartes de pénalité.\r\n\r\nMélangez les 66 cartes (de couleurs et nombres différents) et distribuez une main de 5 cartes à chacun. Disposez ensuite un alignement de 6 cartes visibles sur la table: c\'est la Parade!\r\n\r\nChacun, tour à tour, exécutera les actions suivantes:\r\n\r\najouter une carte de sa main en fin Parade\r\npiocher une nouvelle carte pour compléter sa main\r\nSelon la carte posée, il faudra PEUT-ETRE reprendre des cartes de la Parade en guise de pénalités. Regardez d\'abord la valeur de la carte jouée: cette valeur indique le nombre de cartes (en commençant par la fin de la Parade) qui sont neutralisées. Ensuite, parmi toutes les autres cartes NON neutralisées, vous devrez ramasser:\r\n\r\ncelles qui sont de valeur égale ou inférieure à la carte jouée,\r\net toutes les cartes de couleur identique à la carte jouée.\r\nUn exemple? Olivier pose une carte \"4 jaune\": les 4 dernières cartes de la Parade (hormis celle jouée) sont donc neutralisées. Olivier observe le reste de la Parade et doit ramasser, s\'il y en a, toutes les cartes dont la valeur maximum est 4 ainsi que toutes les cartes jaunes. Il les pose faces visibles devant lui, triées par couleur.\r\n\r\nVous jouerez ainsi jusqu\'au moment où:\r\n\r\nun joueur a devant lui des cartes de pénalité de 6 couleurs différentes\r\nla pioche est épuisée.\r\nAprès un dernier tour de jeu, vous procéderez au décompte des points de pénalité...\r\n\r\nLes joueurs majoritaires (en nombre de cartes) dans chaque couleur peuvent retourner les cartes concernées: chacune vaut maintenant 1 point.\r\nAdditionnez ensuite les valeurs imprimées sur les cartes visibles.\r\nAu Pays des Merveilles, le joueur totalisant le moins de points est déclaré vainqueur!\r\nLe verdict - Parade est un bon petit jeu familial, plus accessible et moins hasardeux que 6 qui prend. C\'est un jeu dans lequel la règle des pénalités est assez subtile et permet des renversements de situation en fin de partie.', 'Parade-605b9f29c77e5-jpg'),
(2, 10, 'Carcassonne', 'strategie', '8+', 2, 5, 'Matériel\r\n72 tuiles paysage (dont une tuile départ dans le sachet)\r\n40 pions partisans\r\n1 tableau de score\r\nPour commencer la partie\r\nChaque joueur choisit les pions d\'une couleur, et place un pion en position zéro sur le tableau des scores.\r\n\r\nLes tuiles sont regroupées en piles face cachées.\r\n\r\nOn place la tuile de départ au milieu de la table.\r\n\r\nLe tour de jeu\r\nTour à tour, un joueur:\r\n\r\nDoit piocher une tuile;\r\nDoit connecter la tuile à la construction en cours;\r\nPeut placer un pion sur un des éléments du décor de la tuile placée.\r\nS\'il place le pion dans une cité il sera chevalier, sur un chemin brigand, dans un monastère moine et dans un champs paysan.\r\n\r\nOn ne peut pas placer un chevalier, un brigand ou un paysan dans une cité, un chemin ou un champ qui en contient déjà un. On peut par contre réunir deux constructions occupées disjointes à l\'aide d\'une tuile.\r\n\r\nLe calcul des points en cours de partie\r\nEn cours de partie, on compte des points pour les constructions complétées:\r\n\r\nLorsqu\'une cité est fermée, le ou les joueurs ayant placé le plus grand nombre de chevaliers gagnent deux points par tuile formant la cité, plus deux points par blason (dessiné sur les tuiles).\r\nLorsqu\'un chemin est fermé à ses deux extrémités, le ou les joueurs ayant placé le plus grand nombre de brigands gagnent un point par tuile formant le chemin.\r\nLorsqu\'un monastère est complètement fermé par les huit tuiles qui l\'entoure, le joueur ayant placé le moine gagne neuf points.\r\nFin de la partie\r\nLa partie se termine lorsqu\'il n\'y a plus de tuile à piocher.\r\n\r\nChaque cité fermée rapporte trois points aux joueurs ayant placé le plus de paysans dans les champs qui la bordent.\r\n\r\nAprès le décompte final, le joueur ayant accumulé le plus de points de victoire remporte la partie.\r\n\r\nVARIANTE: Variante de réduction du hasard\r\nCette variante modifie la méthode de sélection des tuiles:\r\n\r\nLe tout premier joueur de la partie pioche deux tuiles au lieu d\'une. Il en joue une, et passe la tuile non utilisée au joueur suivant.\r\nLors des tours suivants chaque joueur récupère la tuile non utilisée, en pioche une nouvelle, joue l\'une des deux tuiles, et passe la tuile non utilisée au joueur suivant.\r\n\r\nVARIANTE: Variante de réduction du hasard\r\nCette variante, alternative à la précédente, modifie la méthode de sélection des tuiles:\r\n\r\nAu début de la partie, chaque joueur pioche 3 tuiles.\r\nTour à tour, chaque joueur place une de ses 3 tuiles, puis reprend une tuile dans la pioche s\'il en reste.\r\n\r\nVARIANTE: Variante pour la consistance du jeu\r\nPour rendre la construction plus compacte et plus réaliste, on peut interdire la présence de \"trous\" dans le paysage construit, c\'est-à-dire des emplacements non construits complètement entourés de tuiles.\r\n\r\nVARIANTE: Variante stratégique\r\nPour augmenter le côté stratégique de la construction, on peut choisir de ne pas compter les constructions non terminées en fin de partie (villes, chemins et monastères). Cela encourage les joueurs à créer des constructions qu\'ils se sentent capables de clôturer, plutôt que de voir se développer des villes anarchiques impossible à terminer.', 'Carcassonne-605b9eab098ed-jpg'),
(3, 7, 'Jeu d\'échecs', 'strategie', '6+', 2, 2, 'Le jeu d\'échecs oppose deux joueurs possédant seize pièces chacun, respectivement blanches et noires, sur un échiquier de 64 cases. Chacun leur tour, les joueurs en font évoluer une selon ses déplacements propres. Pour parler des adversaires, on dit « les Blancs » et « les Noirs »\r\n\r\nRègles de déplacement des pièces:\r\n\r\nLe Roi se déplace d\'une case à la fois, dans toutes les directions.\r\n\r\nLa Tour se déplace horizontalement ou verticalement d\'un nombre de cases indifférent.\r\n\r\nLe Fou se déplace d\'un nombre indifférent de case, le long des diagonales uniquement.\r\n\r\nLa Dame se déplace soit horizontalement, soit verticalement, soit diagonalement d\'un nombre de cases indifférent.\r\n\r\nLe Cavalier a un déplacement un peu plus singulier. Elle se déplace de deux cases, horizontalement ou verticalement, puis d\'une autre case verticalement ou horizontalement.\r\n\r\nLe Pion se déplace d\'une case à la fois, excepté lors de sa position initiale où il a alors le choix entre avancer de deux cases en un seul coup, ou d\'une seule case.', 'Jeu-d-echecs-605b9f0556fcf-jpg'),
(4, 7, 'Timeline V : Musique et Cinéma', 'connaissance', '8+', 2, 8, 'Le principe tient en une phrase: le but est d\'intercaler des cartes au bon endroit pour former une ligne du temps.\r\n\r\nAu début de la partie, chaque joueur reçoit 6 cartes. Les joueurs ne peuvent regarder que le recto: on y voit un événement musique ou cinéma. Au verso de la carte, on voit la même illustration *et* l\'année de l\'événement.\r\n\r\nAu centre de la table, les joueurs vont construire une ligne du temps, c\'est-à-dire une ligne de cartes allant de la plus ancienne à la plus récente. Le but du jeu, c\'est d\'être le premier joueur à avoir posé toutes ses cartes à l\'endroit correct de la ligne du temps.\r\n\r\nLes joueurs jouent l\'un après l\'autre. A son tour, le joueur doit choisir une de ses cartes et la situer à l\'endroit correct de la ligne du temps. Il peut proposer de l\'intercaler entre deux autres cartes ou de la poser à une extrémité de la ligne.\r\n\r\nLe joueur vérifie sa proposition en retournant la carte. S\'il a raison, il pose la carte là où il l\'a suggéré. S\'il s\'est trompé, il défausse la carte du jeu et en pioche une nouvelle.', 'Timeline-musique-et-cinema-605b9f497c894-jpg'),
(5, 9, 'Twister', 'adresse', '6+', 2, NULL, 'Le plus jeune joueur fait tourner la girouette. Celle-ci va lui indiquer un pied ou une main (gauche ou droite) à mettre sur une pastille de couleur. Il s\'exécute, et c\'est au tour du joueur suivant.\r\n\r\nLa difficulté croît au fil du jeu, en effet, à chaque tour, les ordres de la girouette s\'ajoutent, et les joueurs sont souvent dans une position inconfortable.\r\n\r\nLes joueurs sont éliminés s\'ils tombent au sol. Toucher le sol avec une autre partie du corps que les mains ou les pieds est considéré comme tomber. On ne peut pas, par exemple, poser un genou à terre. Le dernier joueur qui tombe, ou le dernier qui reste sur le tapis est désigné vainqueur.', 'Twister-605b9f57597e2-jpg'),
(6, 4, 'Just One', 'cooperation', '8+', 3, 7, 'Just One est un party game coopératif où vous jouez tous ensemble pour découvrir le plus de mots mystères. Trouvez le meilleur indice pour aider votre équipier et soyez original, car tous les indices identiques seront annulés!', 'Just-One-605b9f1532ba8-jpg'),
(7, 4, 'Cluedo', 'logique', '8+', 3, 6, 'Au Cluedo, la patience et la déduction seront vos meilleurs alliés. En effet, il vous faudra explorer le manoir de fond en comble pour trouver les indices vous permettant de déterminer l’arme du crime, le lieu du meurtre et enfin l’assassin du Docteur Lenoir.', 'Cluedo-605b9ebce9f5f-jpg'),
(8, 4, 'Association 10 dés', 'des', '10+', 2, 8, 'Que ce soit en mode compétitif (en équipes) ou coopératif (dès 2 joueurs), tout commence par un lancer de dés. Aussitôt, tous les joueurs mettent leurs neurones en action pour trouver une association d’idées grâce aux différents mots inscrits sur les dés. Une association c’est un mot, un lieu, un personnage, un titre... Tout est possible, il n’y a aucune limite aux idées ! Ainsi, Marine attrapera les mots « Film » et « Bateau », car elle pense à « Titanic ». Dans le mode compétitif, le chrono est lancé : Louis, son partenaire, dispose de 30 secondes pour deviner à quoi elle pense. S’il ne trouve pas, l’équipe adverse peut aussi tenter sa chance et deviner le mot de Marine.', 'Association-10-des-605b9e8fabaad-jpg'),
(9, 3, 'Le Petit Bac', 'lettres', '8+', 2, NULL, 'Tente de totaliser le maximum de points en trouvant le plus grand nombre de mots dont les premières lettres correspondent aux lettres indiquées par les dés que tu lances, ceci dans des catégories précises : Groupe de musique, Acteurs célèbres, Sport, Animaux sauvages, Objets froid, Objets de cuisine...\r\nPlus de 50 catégories pour encore plus d\'amusement.\r\nUne combinaison astucieuse de cartes et de dés qui fait toute l\'originalité de ce jeu.', 'Le-Petit-Bac-605ba025cd021-jpg'),
(10, 5, 'Dobble', 'memoire', '6+', 2, 8, 'Le jeu comporte 55 cartes rondes, avec 8 dessins sur chacune. Chaque carte a un unique dessin commun avec n\'importe quelle autre carte du paquet. Le but du jeu est de trouver le dessin en commun entre deux cartes données, et de l\'annoncer.\r\n\r\nTous les joueurs jouent en même temps.\r\n\r\nIl existe 5 variantes du jeu avec des règles différentes.\r\n\r\nQuelque soit la variante jouée, il faut toujours :\r\n- être le plus rapide à repérer le symbole identique entre 2 cartes,\r\n- le nommer à voix haute\r\n- puis (selon la variante), prendre la carte, la poser ou la défausser.\r\n', 'Dobble-605b9ed419b9e-jpg');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipcode` int(11) DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `roles`, `firstname`, `lastname`, `address`, `zipcode`, `city`) VALUES
(1, 'Admin', 'admin@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_ADMIN\"]', NULL, NULL, NULL, NULL, NULL),
(2, 'Rififi', 'f.chatel@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Franck', 'Chatel', '20 Rue Saint-Roch', 78200, 'Mantes-la-Jolie'),
(3, 'Gallinette', 'gaelle.mercier@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Gaelle', 'Mercier', '2 Rue de l\'Abbé Duval', 78130, 'Les Mureaux'),
(4, 'Floflo', 'flo.pruvost@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Florian', 'Pruvost', '32 Rue François Truffaut', 78370, 'Plaisir'),
(5, 'Tilie', 'tilie78@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Mathilde', 'Drouet', '2 Rue Thierry le Luron', 78180, 'Montigny-le-Bretonneux'),
(6, 'Enzo', 'enzonimo@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Enzo', 'Bisson', '5 Avenue Toulouse Lautrec', 78390, 'Bois-d\'Arcy'),
(7, 'Aymé', 'aymeric.neveu@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Aymeric', 'Neveu', '15 Rue Borgnis Desbordes', 78000, 'Versailles'),
(8, 'Nissa', 'nissa@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Anissa ', 'LeCorre', '17 Rue Clément Ader', 78140, 'Vélizy-Villacoublay'),
(9, 'Karim', 'karim.maes@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Karim', 'Maes', '14-34 Rue Costes et Bellonte', 78220, 'Viroflay'),
(10, 'Didine', 'didine78@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Amandine', 'Toutain', '23 Rue Wauthier', 78100, 'Saint-Germain-en-Laye'),
(11, 'Test', 'test@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'test', 'test', '10 rue machin', 74654, 'paris');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `borrowing`
--
ALTER TABLE `borrowing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_226E5897855D3E3D` (`lender_id`),
  ADD KEY `IDX_226E589711CE312B` (`borrower_id`),
  ADD KEY `IDX_226E5897E48FD905` (`game_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_232B318C7E3C61F9` (`owner_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `borrowing`
--
ALTER TABLE `borrowing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `game`
--
ALTER TABLE `game`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `borrowing`
--
ALTER TABLE `borrowing`
  ADD CONSTRAINT `FK_226E589711CE312B` FOREIGN KEY (`borrower_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_226E5897855D3E3D` FOREIGN KEY (`lender_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_226E5897E48FD905` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`);

--
-- Contraintes pour la table `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `FK_232B318C7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
