-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 31 mars 2021 à 23:44
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
  `giveaway_date` datetime DEFAULT NULL,
  `return_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `borrowing`
--

INSERT INTO `borrowing` (`id`, `lender_id`, `borrower_id`, `game_id`, `start_date`, `end_date`, `giveaway_date`, `return_date`) VALUES
(1, 10, 11, 2, '2021-03-09 23:12:40', '2021-05-01 22:29:31', '2021-03-31 23:17:45', '2021-03-31 23:18:47'),
(2, 9, 11, 5, '2021-03-10 22:29:44', '2021-05-01 22:29:44', NULL, NULL),
(3, 4, 13, 7, '2021-03-31 22:47:14', '2021-05-01 22:47:14', '2021-03-31 23:24:04', NULL),
(4, 3, 15, 9, '2021-03-31 22:53:43', '2021-05-01 22:53:43', '2021-03-31 23:33:22', '2021-03-31 23:34:27'),
(5, 18, 20, 18, '2021-03-31 23:05:44', '2021-05-01 23:05:44', NULL, NULL),
(6, 13, 2, 13, '2021-03-31 23:08:46', '2021-05-01 23:08:46', NULL, NULL),
(7, 15, 2, 15, '2021-03-31 23:08:56', '2021-05-01 23:08:56', NULL, NULL),
(8, 10, 4, 1, '2021-03-31 23:09:18', '2021-05-01 23:09:18', '2021-03-31 23:19:54', '2021-03-31 23:31:34'),
(9, 11, 4, 12, '2021-03-31 23:09:25', '2021-05-01 23:09:25', '2021-03-31 23:26:21', NULL),
(10, 20, 8, 20, '2021-03-31 23:10:06', '2021-05-01 23:10:06', '2021-03-31 23:40:07', '2021-03-31 23:40:09'),
(11, 18, 8, 19, '2021-03-31 23:10:16', '2021-05-01 23:10:16', '2021-03-31 23:40:43', '2021-03-31 23:40:45'),
(12, 7, 5, 3, '2021-03-31 23:10:58', '2021-05-01 23:10:58', NULL, NULL),
(13, 16, 5, 17, '2021-03-31 23:11:08', '2021-05-01 23:11:08', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'adresse'),
(2, 'cartes'),
(3, 'connaissance'),
(4, 'coopération'),
(5, 'dés'),
(6, 'lettres'),
(7, 'logique'),
(8, 'mémoire'),
(9, 'stratégie');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `game`
--

CREATE TABLE `game` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_players` int(11) NOT NULL,
  `max_players` int(11) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_archived` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `game`
--

INSERT INTO `game` (`id`, `owner_id`, `category_id`, `name`, `public`, `min_players`, `max_players`, `description`, `image`, `is_archived`) VALUES
(1, 10, 2, 'Parade', '6+', 2, 6, 'Parade vous invite au Pays des Merveilles... Alice et ses amis égaient agréablement les cartes de ce petit jeu de pose bien sympathique.\r\n\r\nLe principe du jeu - Comme dans \"6 qui prend\", on tentera d\'éviter de ramasser des cartes de pénalité.\r\n\r\nMélangez les 66 cartes (de couleurs et nombres différents) et distribuez une main de 5 cartes à chacun. Disposez ensuite un alignement de 6 cartes visibles sur la table: c\'est la Parade!\r\n\r\nChacun, tour à tour, exécutera les actions suivantes:\r\n\r\najouter une carte de sa main en fin Parade\r\npiocher une nouvelle carte pour compléter sa main\r\nSelon la carte posée, il faudra PEUT-ETRE reprendre des cartes de la Parade en guise de pénalités. Regardez d\'abord la valeur de la carte jouée: cette valeur indique le nombre de cartes (en commençant par la fin de la Parade) qui sont neutralisées. Ensuite, parmi toutes les autres cartes NON neutralisées, vous devrez ramasser:\r\n\r\ncelles qui sont de valeur égale ou inférieure à la carte jouée,\r\net toutes les cartes de couleur identique à la carte jouée.\r\nUn exemple? Olivier pose une carte \"4 jaune\": les 4 dernières cartes de la Parade (hormis celle jouée) sont donc neutralisées. Olivier observe le reste de la Parade et doit ramasser, s\'il y en a, toutes les cartes dont la valeur maximum est 4 ainsi que toutes les cartes jaunes. Il les pose faces visibles devant lui, triées par couleur.\r\n\r\nVous jouerez ainsi jusqu\'au moment où:\r\n\r\nun joueur a devant lui des cartes de pénalité de 6 couleurs différentes\r\nla pioche est épuisée.\r\nAprès un dernier tour de jeu, vous procéderez au décompte des points de pénalité...\r\n\r\nLes joueurs majoritaires (en nombre de cartes) dans chaque couleur peuvent retourner les cartes concernées: chacune vaut maintenant 1 point.\r\nAdditionnez ensuite les valeurs imprimées sur les cartes visibles.\r\nAu Pays des Merveilles, le joueur totalisant le moins de points est déclaré vainqueur!\r\nLe verdict - Parade est un bon petit jeu familial, plus accessible et moins hasardeux que 6 qui prend. C\'est un jeu dans lequel la règle des pénalités est assez subtile et permet des renversements de situation en fin de partie.', 'Parade-605b9f29c77e5.jpg', 0),
(2, 10, 9, 'Carcassonne', '8+', 2, 5, 'Matériel\r\n72 tuiles paysage (dont une tuile départ dans le sachet)\r\n40 pions partisans\r\n1 tableau de score\r\nPour commencer la partie\r\nChaque joueur choisit les pions d\'une couleur, et place un pion en position zéro sur le tableau des scores.\r\n\r\nLes tuiles sont regroupées en piles face cachées.\r\n\r\nOn place la tuile de départ au milieu de la table.\r\n\r\nLe tour de jeu\r\nTour à tour, un joueur:\r\n\r\nDoit piocher une tuile;\r\nDoit connecter la tuile à la construction en cours;\r\nPeut placer un pion sur un des éléments du décor de la tuile placée.\r\nS\'il place le pion dans une cité il sera chevalier, sur un chemin brigand, dans un monastère moine et dans un champs paysan.\r\n\r\nOn ne peut pas placer un chevalier, un brigand ou un paysan dans une cité, un chemin ou un champ qui en contient déjà un. On peut par contre réunir deux constructions occupées disjointes à l\'aide d\'une tuile.\r\n\r\nLe calcul des points en cours de partie\r\nEn cours de partie, on compte des points pour les constructions complétées:\r\n\r\nLorsqu\'une cité est fermée, le ou les joueurs ayant placé le plus grand nombre de chevaliers gagnent deux points par tuile formant la cité, plus deux points par blason (dessiné sur les tuiles).\r\nLorsqu\'un chemin est fermé à ses deux extrémités, le ou les joueurs ayant placé le plus grand nombre de brigands gagnent un point par tuile formant le chemin.\r\nLorsqu\'un monastère est complètement fermé par les huit tuiles qui l\'entoure, le joueur ayant placé le moine gagne neuf points.\r\nFin de la partie\r\nLa partie se termine lorsqu\'il n\'y a plus de tuile à piocher.\r\n\r\nChaque cité fermée rapporte trois points aux joueurs ayant placé le plus de paysans dans les champs qui la bordent.\r\n\r\nAprès le décompte final, le joueur ayant accumulé le plus de points de victoire remporte la partie.\r\n\r\nVARIANTE: Variante de réduction du hasard\r\nCette variante modifie la méthode de sélection des tuiles:\r\n\r\nLe tout premier joueur de la partie pioche deux tuiles au lieu d\'une. Il en joue une, et passe la tuile non utilisée au joueur suivant.\r\nLors des tours suivants chaque joueur récupère la tuile non utilisée, en pioche une nouvelle, joue l\'une des deux tuiles, et passe la tuile non utilisée au joueur suivant.\r\n\r\nVARIANTE: Variante de réduction du hasard\r\nCette variante, alternative à la précédente, modifie la méthode de sélection des tuiles:\r\n\r\nAu début de la partie, chaque joueur pioche 3 tuiles.\r\nTour à tour, chaque joueur place une de ses 3 tuiles, puis reprend une tuile dans la pioche s\'il en reste.\r\n\r\nVARIANTE: Variante pour la consistance du jeu\r\nPour rendre la construction plus compacte et plus réaliste, on peut interdire la présence de \"trous\" dans le paysage construit, c\'est-à-dire des emplacements non construits complètement entourés de tuiles.\r\n\r\nVARIANTE: Variante stratégique\r\nPour augmenter le côté stratégique de la construction, on peut choisir de ne pas compter les constructions non terminées en fin de partie (villes, chemins et monastères). Cela encourage les joueurs à créer des constructions qu\'ils se sentent capables de clôturer, plutôt que de voir se développer des villes anarchiques impossible à terminer.', 'Carcassonne-605b9eab098ed.jpg', 0),
(3, 7, 9, 'Jeu d\'échecs', '6+', 2, 2, 'Le jeu d\'échecs oppose deux joueurs possédant seize pièces chacun, respectivement blanches et noires, sur un échiquier de 64 cases. Chacun leur tour, les joueurs en font évoluer une selon ses déplacements propres. Pour parler des adversaires, on dit « les Blancs » et « les Noirs »\r\n\r\nRègles de déplacement des pièces:\r\n\r\nLe Roi se déplace d\'une case à la fois, dans toutes les directions.\r\n\r\nLa Tour se déplace horizontalement ou verticalement d\'un nombre de cases indifférent.\r\n\r\nLe Fou se déplace d\'un nombre indifférent de case, le long des diagonales uniquement.\r\n\r\nLa Dame se déplace soit horizontalement, soit verticalement, soit diagonalement d\'un nombre de cases indifférent.\r\n\r\nLe Cavalier a un déplacement un peu plus singulier. Elle se déplace de deux cases, horizontalement ou verticalement, puis d\'une autre case verticalement ou horizontalement.\r\n\r\nLe Pion se déplace d\'une case à la fois, excepté lors de sa position initiale où il a alors le choix entre avancer de deux cases en un seul coup, ou d\'une seule case.', 'Jeu-d-echecs-605b9f0556fcf.jpg', 0),
(4, 7, 3, 'Timeline V : Musique et Cinéma', '8+', 2, 8, 'Le principe tient en une phrase: le but est d\'intercaler des cartes au bon endroit pour former une ligne du temps.\r\n\r\nAu début de la partie, chaque joueur reçoit 6 cartes. Les joueurs ne peuvent regarder que le recto: on y voit un événement musique ou cinéma. Au verso de la carte, on voit la même illustration *et* l\'année de l\'événement.\r\n\r\nAu centre de la table, les joueurs vont construire une ligne du temps, c\'est-à-dire une ligne de cartes allant de la plus ancienne à la plus récente. Le but du jeu, c\'est d\'être le premier joueur à avoir posé toutes ses cartes à l\'endroit correct de la ligne du temps.\r\n\r\nLes joueurs jouent l\'un après l\'autre. A son tour, le joueur doit choisir une de ses cartes et la situer à l\'endroit correct de la ligne du temps. Il peut proposer de l\'intercaler entre deux autres cartes ou de la poser à une extrémité de la ligne.\r\n\r\nLe joueur vérifie sa proposition en retournant la carte. S\'il a raison, il pose la carte là où il l\'a suggéré. S\'il s\'est trompé, il défausse la carte du jeu et en pioche une nouvelle.', 'Timeline-musique-et-cinema-605b9f497c894.jpg', 0),
(5, 9, 1, 'Twister', '6+', 2, 0, 'Le plus jeune joueur fait tourner la girouette. Celle-ci va lui indiquer un pied ou une main (gauche ou droite) à mettre sur une pastille de couleur. Il s\'exécute, et c\'est au tour du joueur suivant.\r\n\r\nLa difficulté croît au fil du jeu, en effet, à chaque tour, les ordres de la girouette s\'ajoutent, et les joueurs sont souvent dans une position inconfortable.\r\n\r\nLes joueurs sont éliminés s\'ils tombent au sol. Toucher le sol avec une autre partie du corps que les mains ou les pieds est considéré comme tomber. On ne peut pas, par exemple, poser un genou à terre. Le dernier joueur qui tombe, ou le dernier qui reste sur le tapis est désigné vainqueur.', 'Twister-605b9f57597e2.jpg', 0),
(6, 4, 4, 'Just One', '8+', 3, 7, 'Just One est un party game coopératif où vous jouez tous ensemble pour découvrir le plus de mots mystères. Trouvez le meilleur indice pour aider votre équipier et soyez original, car tous les indices identiques seront annulés!', 'Just-One-605b9f1532ba8.jpg', 0),
(7, 4, 7, 'Cluedo', '8+', 3, 6, 'Au Cluedo, la patience et la déduction seront vos meilleurs alliés. En effet, il vous faudra explorer le manoir de fond en comble pour trouver les indices vous permettant de déterminer l’arme du crime, le lieu du meurtre et enfin l’assassin du Docteur Lenoir.', 'Cluedo-605b9ebce9f5f.jpg', 0),
(8, 4, 5, 'Association 10 dés', '10+', 2, 8, 'Que ce soit en mode compétitif (en équipes) ou coopératif (dès 2 joueurs), tout commence par un lancer de dés. Aussitôt, tous les joueurs mettent leurs neurones en action pour trouver une association d’idées grâce aux différents mots inscrits sur les dés. Une association c’est un mot, un lieu, un personnage, un titre... Tout est possible, il n’y a aucune limite aux idées ! Ainsi, Marine attrapera les mots « Film » et « Bateau », car elle pense à « Titanic ». Dans le mode compétitif, le chrono est lancé : Louis, son partenaire, dispose de 30 secondes pour deviner à quoi elle pense. S’il ne trouve pas, l’équipe adverse peut aussi tenter sa chance et deviner le mot de Marine.', 'Association-10-des-605b9e8fabaad.jpg', 0),
(9, 3, 6, 'Le Petit Bac', '8+', 2, 0, 'Tente de totaliser le maximum de points en trouvant le plus grand nombre de mots dont les premières lettres correspondent aux lettres indiquées par les dés que tu lances, ceci dans des catégories précises : Groupe de musique, Acteurs célèbres, Sport, Animaux sauvages, Objets froid, Objets de cuisine...\r\nPlus de 50 catégories pour encore plus d\'amusement.\r\nUne combinaison astucieuse de cartes et de dés qui fait toute l\'originalité de ce jeu.', 'Le-Petit-Bac-605ba025cd021.jpg', 0),
(10, 5, 8, 'Dobble', '6+', 2, 8, 'Le jeu comporte 55 cartes rondes, avec 8 dessins sur chacune. Chaque carte a un unique dessin commun avec n\'importe quelle autre carte du paquet. Le but du jeu est de trouver le dessin en commun entre deux cartes données, et de l\'annoncer.\r\n\r\nTous les joueurs jouent en même temps.\r\n\r\nIl existe 5 variantes du jeu avec des règles différentes.\r\n\r\nQuelque soit la variante jouée, il faut toujours :\r\n- être le plus rapide à repérer le symbole identique entre 2 cartes,\r\n- le nommer à voix haute\r\n- puis (selon la variante), prendre la carte, la poser ou la défausser.\r\n', 'Dobble-605b9ed419b9e.jpg', 0),
(11, 11, 3, 'Time\'s Up', '8+', 4, 12, 'Pour jouer au Time’s Up, il vous faut :\r\n\r\nLes cartes fournies avec le jeu.\r\nUne feuille et un crayon pour noter les résultats des manches.\r\n1 sablier ou un chrono.\r\nCommencer une partie de Time’Up :\r\nPour commencer, chaque équipe doit être répartie autour de la table sans que les joueurs d’une même équipe soient à côté les uns des autres. La partie se déroule en 3 manches et chaque équipe doit deviner le plus de possible personnalités écrites sur les cartes du jeu. On prend 40 cartes qui serviront durant les 3 manches.\r\n\r\nChaque manche ne doit durer que 30 secondes. A chaque fois, un joueur par équipe tente de faire deviner à ses coéquipiers le plus de personnalités.\r\n\r\nPrésentation de chaque manches du Time’s Up :\r\nPour la première manche, le joueur devant fait deviner peut parler autant qu’il le souhaite pour faire deviner le nom du personnage à découvrir à son équipe en 30 secondes. Il est interdit d’écarter une carte difficile. C’est ensuite autour de l’autre équipe et ainsi de suite jusqu’à ce que toutes les cartes ont été découvertes.\r\n\r\nLa deuxième manche n’autorise plus qu’à faire deviner les personnalités avec un seul mot. Cela peut paraitre difficile mais les cartes étant les mêmes, un travail de mémorisation lors de la première manche est indispensable si vous voulez gagner!\r\n\r\nLa troisième manche ne se fait qu’en mimes. Soyez malin pour faire deviner rapidement les personnalités!\r\n\r\nComment gagner une partie de Time’s Up :\r\nPour gagner la partie, il suffit à la fin de compter le nombre de points remportés par équipe.', 'Time-s-Up-6064d94234b83.jpg', 0),
(12, 11, 9, 'Méduris', '10+', 2, 4, 'Pour répondre à l\'appel des dieux, mettez-vous en route pour peupler le pied du mont Méduris. Pour vous assurer de la bienveillance des dieux, construisez des huttes, faites des offrandes au druide, collectez de précieuses pierres runiques et édifiez des temples monumentaux.\r\n\r\nEn employant vos ouvriers avec habileté, vous produirez de précieuses matières premières qui seront utiles à la construction de huttes et à l\'édification de temples. Plus la colonie est étendue, plus la construction de huttes est coûteuse. Mais si vous parvenez à satisfaire le druide par des offrandes vos efforts seront récompensés.\r\n\r\nSeul celui qui parviendra à placer ses huttes et temples avec habileté tout en conservant suffisamment d\'offrandes pour la grande finale parviendra à gagner la partie !', 'MEDURIS-6064da0867fa5.jpg', 0),
(13, 13, 9, 'Citadelles : quatrième édition Citadelles', '10+', 2, 8, 'Dans Citadelles, votre but est de bâtir une cité prestigieuse avant que vos adversaires ne parviennent à construire la leur.\r\nPour développer votre ville et ses nouveaux quartiers, il vous faudra de l\'or, mais aussi le soutien des dames, seigneurs et notables locaux, qui ont tous leur rôle à jouer.\r\n\r\nConsidéré comme l\'un des grands classiques du jeu de société moderne, Citadelles est un jeu de cartes faisant appel au bluff, à la diplomatie et à la stratégie.', 'Citadelles-quatrieme-edition-Citadelles-6064df4690aea.jpg', 0),
(14, 13, 9, 'SmallWorld', '10+', 2, 5, 'Dans Small World, les joueurs luttent pour conquérir les régions d\'un monde où il n\'y a pas de place pour tous !\r\n\r\nConçu par Philippe Keyaerts dans la droite ligne du jeu Vinci™, primé à plusieurs reprises, Small World plongera les joueurs dans un monde habité par des nains, des mages, des amazones, des géants, des orcs et même des humains. Ces peuples luttent sans merci en envoyant leurs troupes à la conquête de nouvelles régions : les civilisations les plus faibles seront impitoyablement chassées du monde de Small World !\r\n\r\nEn choisissant la bonne combinaison entre les 14 Peuples et les 20 Pouvoirs Spéciaux au bon moment, les joueurs pourront étendre leur empire, souvent aux dépens de leurs voisins ! Cependant, leur civilisation finira par s\'essouffler - il leur faudra alors en choisir une autre pour remporter la victoire.', 'SmallWorld-6064dfc56467a.jpg', 0),
(15, 15, 4, 'Les Loups-Garous', '10+', 8, 18, 'Les nuits ne sont pas sûres dans le petit hameau de Thiercelieux. D\'atroces meurtres sont commis par des villageois lycanthropes.\r\nThiercelieux, bourgade tranquille.\r\nLe jeu est composé de 24 cartes permettant de faire jouer jusqu\'à 18 personnes et un meneur de jeu. Ces cartes indiquent le type de personnages que chaque joueur va incarner durant la partie dirigée par le meneur.\r\nPour le jeu simple, seront utilisées les cartes \"Loup-Garou\", \"Simple Villageois\", \"Voyante\" et \"Capitaine\". Un tableau indique la répartition selon le nombre de participants.\r\n5 cartes peuvent être utilisées en remplacement de cartes villageois afin d\'apporter des variantes. Il s\'agit des cartes \"Chasseur\", \"Cupidon\", \"Sorcière\", \"Petite Fille\" et \"Voleur\".\r\nQui suis-je ?\r\nUne fois la répartition et le choix des cartes \"variantes\" établis, le meneur de jeu va distribuer à chaque joueur une carte, face cachée, qui va lui indiquer, après consultation discrète, qui il est. La carte \"Capitaine\" est mise de côté lors de la distribution. Selon la carte que le joueur reçoit, son objectif, et ses interventions durant le cours du jeu, vont être différents.\r\nVous n\'entendez que ma voix !\r\nLe meneur est là pour contrôler le jeu et indiquer les différentes phases durant la partie. Il va endormir et réveiller tout, ou une partie, des habitants du village. Être endormis signifie avoir les yeux fermés, être réveillé les avoir... Ouverts.\r\nS\'il a été introduit des villageois \"variantes\" qui l\'imposent, le meneur endort le village et débute alors une phase préparatoire.\r\n- Le meneur réveille le \"Voleur\" qui va pouvoir échanger sa carte avec une des 2 cartes supplémentaires rajoutées par sa présence et rester en trop lors de la distribution. Le \"voleur\" se rendort.\r\n- Le meneur réveille \"Cupidon\" qui désigne alors 2 joueurs dont les sorts seront liés. \"Cupidon\" se rendort.\r\n- Le meneur réveille les \"Amoureux\" désignés par \"Cupidons\" afin que chacun sache à qui il est lié. Les \"Amoureux\" se rendorment.\r\nLa partie peut alors commencer, il s\'agira d\'un enchaînement de jour et de nuit.\r\nUn cri dans la nuit.\r\nLa nuit venue, le meneur endort les villageois puis réveille, s\'ils sont intégré à la partie :\r\n1/ La \"Voyante\" : elle va indiquer un joueur au meneur. Celui-ci, montre alors à la \"Voyante\" la carte du joueur désigné. La \"Voyante\" se rendort.\r\n2/ Les \"Loups-Garous\" : ils vont indiquer une victime au meneur qui va aller retourner sa carte. Pendant cette période, si la \"Petite Fille\" fait partie du village, elle a le droit, et c\'est la seule, d\'ouvrir les yeux pour espionner discrètement les loups-garous, sans se faire prendre.\r\n3/ La \"Sorcière\" : le meneur lui indique la victime des Loups-Garous, elle peut alors décider de faire usage de son unique potion de guérison pour l\'épargner. Elle peut aussi indiquer un villageois de son choix et utiliser son unique potion d\'empoisonnement pour l\'éliminer.\r\nLe jour se lève.\r\nAu petit matin, tous les villageois ouvrent les yeux et découvrent, selon les variantes introduites, 0, 1 ou 2 morts.\r\na/ Si l\'une des victimes est le \"Chasseur\", il élimine immédiatement un joueur !\r\nb/ Si l\'une des victimes est l\'un des 2 amoureux, l\'autre meurt de chagrin et est éliminé.\r\nc/ Si l\'une des victimes est le \"Capitaine\", il désigne son remplaçant.\r\nTous les joueurs, y compris les Loups-Garous, vont débattre afin de désigner un des villageois qu\'ils pensent être lycanthrope. Le village (les survivants) vote afin d\'éliminer l\'un des leurs suspecté d\'être Loup-Garou. La voix du \"Capitaine\" compte double. Le joueur désigné montre alors sa carte et est éliminé. Les conséquences liées à son élimination sont identiques aux a, b et c du petit matin.\r\nLe village peut alors se rendormir car une nouvelle nuit commence.\r\nOui, mais comment je gagne ?\r\nIl y a deux objectifs distincts.\r\n1/ Pour les loups-garous, éliminer les autres villageois.\r\n2/ Pour les villageois qui ne sont pas loup-garou, démasquer et éliminer les loups-garous.\r\nLa partie s\'arrêtera dès lors que les loups-garous sont tous éliminés, seront alors déclarés \"Grand Vainqueur\" les non loups-garous. La partie s\'arrête aussi lorsque les loups-garous ont décimé tous les non loups-garous, ils sont alors déclarés \"Grand Vainqueur\".\r\nIl y a une troisième possibilité, introduite par \"Cupidon\". En effet, si les amoureux sont 1 loup-garou et un villageois, ils sont déclarés \"Grand Vainqueur\" s\'ils éliminent tous les autres joueurs !', 'Les-Loups-Garous-6064e07cb0e3c.jpg', 0),
(16, 15, 7, 'Dixit', '8+', 3, 6, 'Pour jouer à Dixit il vous faut :\r\nLe Dixit se joue avec 3 à 6 joueurs\r\nUn plateau de jeu\r\n84 cartes\r\n36 cartons « votes » de 6 couleurs différentes numérotées de 1 à 6\r\n6 pions « lapin »\r\nComment se déroule une partie du Dixit?\r\nLa mise en place du jeu de Dixit\r\nAvant de débuter la partie de Dixit, chaque joueur choisit un lapin et le place sur la case 0 de la piste. Les 84 cartes sont mélangées et 6 sont distribuées à chaque joueur. Le reste des cartes va dans la pioche. Si le jeu s’effectue avec 4 ou 5 joueurs, on ne distribue que 4 et 5 cartes à chacun d’eux.\r\n\r\nLe déroulement d’une partie de Dixit\r\nOn désigne un conteur le temps du tour de jeu. Il regarde les 6 cartes qu’il possède. Il en choisit une et formule une phrase pour la décrire sans montrer sa carte aux autres. La formulation est libre et peut faire référence à des œuvres : films, chansons, contes… Une fois que le conteur a prononcé sa phrase, les autres joueurs sélectionnent dans leur jeu la carte qui leur semble la mieux correspondre aux propos du conteur et la donnent au maître du jeu. Puis, le conteur mélange les cartes au hasard, face visible. Chaque carte reçoit un numéro, la plus à gauche recevant le nombre 1 et ainsi de suite.\r\nC’est l’heure du vote. Chaque joueur vote en secret pour la carte qu’il pense être celle qui a inspirée le conteur, à l’aide de son carton de vote. Puis la bonne image est dévoilée. Le conteur n’ayant, bien sûr, pas le droit de participer au vote.\r\n\r\nComment compter les points à Dixit ?\r\nSi tous les joueurs retrouvent l’image du conteur, ce dernier ne marque aucun point et les autres joueurs en marquent deux. Même chose si aucun ne la retrouve. Si seuls quelques joueurs ont retrouvé la bonne carte, ceux-ci et le conteur marquent 3 points. Enfin, chacun des joueurs, sauf le conteur, remporte 1 point pour chaque vote sur sa carte.\r\nPuis chacun des joueurs avance son pion lapin d’autant de cases qu’il a engrangé de points. Ceci fait, chacun complète son jeu pour posséder six cartes. Le nouveau conteur étant le joueur situé à la gauche du précédent.\r\n\r\nQuelques variantes du jeu de Dixit\r\nIl existe quelques variantes au jeu de Dixit :\r\n\r\nLe jeu à 3 joueurs : dans ce cas chaque joueur a 7 cartes. Les joueurs donnent deux images au lieu d’une au conteur.\r\nLe décompte : si un seul joueur retrouve l’image du conteur, tous deux marquent 4 points au lieu de 3.\r\nMimes ou chansons : au lieu d’énoncer une phrase, le conteur peut fredonner une chanson ou mimer sa carte.\r\nA noter qu’il existe une version de Dixit à 12 joueurs appelée Dixit Odyssey avec 12 pions lapins et 12 cartons de vote.\r\nComment gagner une partie de Dixit ?\r\nLe joueur ayant marqué le plus de points gagne la partie. Le partie s’achevant lorsqu’il n’y a plus de cartes dans la pioche.', 'Dixit-6064e14e76e88.jpg', 0),
(17, 16, 9, 'Catan', '12+', 3, 4, 'L\'aire de jeu est créée de façon aléatoire, puis les joueurs y placent à tour de rôle deux colonies et deux routes. L\'ordre de placement est determiné par les dés, le joueur ayant placé la dernière colonnie au premier placement sera le premier a placer sa seconde colonie. Une colonnie doit toujours être à deux chemins de la colonie la plus proche. Ensuite, chaque tour se décompose en trois phases :\r\n\r\nProduction : à son tour, le joueur lance deux dés. Les hexagones portant le nombre indiqué par les dés produisent tous la matière première correspondant au dessin sur celui-ci. Tous les joueurs ayant une ville ou une colonie placée à un sommet de ces hexagones reçoivent ces matières premières. Si les dés indiquent sept (le nombre statistiquement le plus probable), personne ne reçoit de ressources, et le pion brigand est déplacé vers une autre case. Tant qu\'il s\'y trouve, cette case ne produit pas de matières premières.\r\nCommerce : le joueur peut ensuite faire des échanges de matières premières avec les autres. Cette phase est le cœur du jeu. Il arrive qu\'après quelques jets de dés précis, une matière première ait subi une forte dévaluation, ou au contraire une importante hausse de cours. Les échanges sont alors très animés.\r\nConstruction : le joueur peut enfin dépenser ses ressources pour construire des routes et fonder des colonies ou des villes, afin d\'étendre son influence et d\'augmenter ses chances de gagner des matières premières. Il peut également acheter des cartes qu\'il pourra ensuite jouer quand il le désirera pour se rapprocher de la victoire.\r\nChaque colonie vaut un point de victoire (PV). Une ville en vaut deux, construire la route la plus longue (de longueur minimale 5 jetons route) en vaut également deux, et posséder l\'armée la plus puissante (constituée au minimum de trois cartes chevalier) permet aussi de gagner deux points.\r\n\r\nLe premier joueur qui totalise dix points de victoire gagne la partie.', 'Catan-6064e2487cef2.jpg', 0),
(18, 18, 2, '6 qui prend !', '10+', 2, 10, 'En début de manche vous recevez 10 cartes. À chaque tour, les joueurs choisissent une carte et la révèlent à tous en même temps : ces cartes sont ajoutées à l’une des 4 séries qui se forment sur la table. Celui qui doit jouer la sixième carte d’une série «récolte» les 5 premières... et toutes leurs têtes de boeufs ! Quand les 10 cartes sont jouées, chacun compte ses boeufs et les additionne à son total précédent. Après plusieurs manches, le plus petit troupeau gagnera la partie.', '6-qui-prend-6064e2cb9735e.jpg', 0),
(19, 18, 5, 'Mille Sabords', '8+', 2, 5, 'A l’abordage !!!\r\nGlissez-vous dans la peau d’un vieux loup de mer et organisez des parties de dés endiablées ! A l’aide des déroutantes cartes Pirate, défiez la chance et vos adversaires pour réaliser des combinaisons de dés et marquer un maximum de points. A votre tour, révélez une carte Pirate qui va influer sur votre tirage.\r\nPuis lancez les dés et tentez de réaliser la meilleure combinaison : vous pouvez relancer autant de fois que vous le souhaitez mais attention aux 3 têtes de mort ou vous rentrerez les mains vides ! Réservé aux pirates qui n’ont pas froid aux yeux !', 'Mille-Sabords-6064e38c18717.jpg', 0),
(20, 20, 1, 'Halli Galli', '6+', 2, 6, 'Halli Galli est un jeu très simple de rapidité et d\'observation.\r\nMatériel :\r\n* 56 cartes\r\n* 1 cloche\r\nDéroulement et but du jeu :\r\nLe but du jeu est de gagner toutes les cartes.\r\nSur les cartes sont dessinés de 1 à 5 fruits (bananes, prunes, fraises etc).\r\nPour commencer une partie, chaque joueur reçoit le même nombre de cartes qu\'il pose devant lui face caché. La clochette est posé au centre de la table.\r\nEnsuite, chaque joueur retourne un carte à tour de rôle. Dès que 5 fruits de la même sorte figurent parmi les cartes retournées, le joueur qui sonne le premier gagne toutes les cartes faces ouvertes.\r\nSi un joueur se trompe il donne une carte de sa pioche aux autres joueurs.\r\nQuand un joueur ne possède plus de cartes à retourner, il est éliminé.\r\nDès qu\'un joueur a gagné toutes les cartes il est déclaré grand vainqueur !', 'Halli-Galli-6064e41e74306.jpg', 0);

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `borrowing_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `message`
--

INSERT INTO `message` (`id`, `borrowing_id`, `author_id`, `created_at`, `content`) VALUES
(1, 1, 11, '2021-03-31 23:15:59', 'Bonjour.'),
(2, 1, 10, '2021-03-31 23:16:06', 'Bonjour.'),
(3, 1, 11, '2021-03-31 23:16:57', 'Quand serais-tu dispo pour faire l\'echange ?'),
(4, 1, 10, '2021-03-31 23:17:21', 'Cet aprem à 16h ? Près de la gare.'),
(5, 1, 11, '2021-03-31 23:17:35', 'Ok, ça marche. A tout à l\'heure'),
(6, 1, 11, '2021-03-31 23:18:13', 'Hello, on se retrouve comme la dernière fois pour que je te rende ton jeu ?'),
(7, 1, 11, '2021-03-31 23:18:25', 'Je suis dispo en fin de matinée vers 11h30'),
(8, 1, 10, '2021-03-31 23:18:42', 'Ok, ça me va. A tout à l\'heure.'),
(9, 2, 11, '2021-03-31 23:19:27', 'Salut ! Quand es-tu dispo pour faire l\'échange ?'),
(10, 2, 9, '2021-03-31 23:21:14', 'Je peux ce soir après le boulot vers 17h. Tu vois le monoprix du centre-ville ? Je peux t\'y retrouver vers 17h30.'),
(11, 2, 11, '2021-03-31 23:21:27', 'Ok ça marche ! A ce soir !'),
(12, 3, 13, '2021-03-31 23:23:06', 'Salut, tu es dispo aujourd\'hui pour l\'échange ?'),
(13, 3, 4, '2021-03-31 23:23:32', 'Malheureusement non, mais demain midi, je peux te retrouver devant la gare?'),
(14, 3, 13, '2021-03-31 23:23:52', 'Ok, pas de soucis, mais 12h30 ça te vas ? C\'est ma pause dej.'),
(15, 3, 4, '2021-03-31 23:23:58', 'Ok ! A demain !'),
(16, 9, 4, '2021-03-31 23:26:19', 'Hello. Je suis dispo demain à partir de 16h pour l\'echange'),
(17, 9, 11, '2021-03-31 23:26:41', '16h30 ? Près de la place du marché ?'),
(18, 9, 4, '2021-03-31 23:26:48', 'Nikel ! A demain !'),
(19, 8, 10, '2021-03-31 23:29:07', 'Salut, j\'ai vu que tu voulais emprunter mon jeu. Je ne suis pas dispo avant demain soir après le boulot. Vers 18h à la gare ça t\'irai ?'),
(20, 8, 4, '2021-03-31 23:29:57', 'Hum, ok, si tu n\'as pas d\'autre dispo avant. Je te rejoins près du kiosque à journaux.'),
(21, 8, 10, '2021-03-31 23:30:05', 'Ok, à demain !'),
(22, 8, 4, '2021-03-31 23:30:34', 'Hello ! Quand est-ce qu\'on peut se retrouver pour que je te rende le jeu ?'),
(23, 8, 10, '2021-03-31 23:30:52', 'Je suis dispo toute la journée, je suis de repos. Donc comme tu veux.'),
(24, 8, 4, '2021-03-31 23:31:15', 'Ha ben super. 12h au même endroit que la dernère fois ?'),
(25, 8, 10, '2021-03-31 23:31:29', 'Ok ça marche. A tout à l\'heure !'),
(26, 4, 15, '2021-03-31 23:33:20', 'Salut ^^ J\'aimerais emprunter ton jeu.'),
(27, 4, 3, '2021-03-31 23:33:37', 'Hello ! Pas de soucis. Je suis dispo aujourd\'hui si tu veux'),
(28, 4, 15, '2021-03-31 23:34:11', 'Ça tombe bien, moi aussi. On pourrait se retrouver vers 14h ? Au niveau du Lycée ?'),
(29, 4, 3, '2021-03-31 23:34:24', 'Oui, je vois où c\'est. A tout à l\'heure.'),
(30, 4, 15, '2021-03-31 23:34:49', 'Hello ! Es-tu dispo demain pour que je te rende ton jeu ?'),
(31, 4, 3, '2021-03-31 23:35:26', 'Oui sans problème. En fin de matinée par contre. Vers 11h ?'),
(32, 4, 15, '2021-03-31 23:35:38', 'Ok, 11h, devant le lycée alors'),
(33, 10, 8, '2021-03-31 23:38:05', 'Bonjour. Seriez-vous disponible aujourd\'hui pour l\'echange du jeu ?'),
(34, 10, 20, '2021-03-31 23:38:24', 'Alors oui, mais rapidement, je n\'ai pas beaucoup de temps.'),
(35, 10, 20, '2021-03-31 23:38:38', 'Je peux te retrouver à 13h à la sortie de la gare'),
(36, 10, 8, '2021-03-31 23:39:03', 'Ah ça tombe bien, j\'y passe à cette heure pour aller au lycée'),
(37, 10, 20, '2021-03-31 23:39:12', 'Alors à tout à l\'heure'),
(38, 10, 8, '2021-03-31 23:39:33', 'Bonjour. Peux-on se retrouver demain en fin d\'après-midi pour que je vous rende le jeu ?'),
(39, 10, 20, '2021-03-31 23:39:51', 'Ok, 17h ça t\'irais ? Au même endroit ?'),
(40, 10, 8, '2021-03-31 23:39:57', 'Parfais ! a demain !'),
(41, 11, 8, '2021-03-31 23:41:13', 'Bonjour. Je souhaiterai emprunter votre jeu. Seriez-vous disponible cet après-midi ?'),
(42, 11, 18, '2021-03-31 23:41:45', 'Ha non, c\'est un peu court pour moi. Mais demain à partir de 17h c\'est possible.'),
(43, 11, 8, '2021-03-31 23:42:00', 'Ok, peut-on se retrouver près du Lycée ?'),
(44, 11, 18, '2021-03-31 23:42:12', 'Pas de problème ! A demain !'),
(45, 11, 8, '2021-03-31 23:42:35', 'Bonjour. Je souhaiterai vous rendre votre jeu. Aujourd\'hui c\'est possible ?'),
(46, 11, 18, '2021-03-31 23:43:00', 'Ha bah ça tombe bien, je dois justement passer près du Lycée à midi. Ca t\'irai ?'),
(47, 11, 8, '2021-03-31 23:43:12', 'Parfait ! à tout à l\'heure !');

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
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_registered` tinyint(1) NOT NULL,
  `is_archived` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `roles`, `firstname`, `lastname`, `address`, `zipcode`, `city`, `is_registered`, `is_archived`) VALUES
(1, 'Admin', 'admin@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_ADMIN\"]', NULL, NULL, NULL, NULL, NULL, 0, 0),
(2, 'Rififi', 'f.chatel@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Franck', 'Chatel', '20 Rue Saint-Roch', 78200, 'Mantes-la-Jolie', 1, 0),
(3, 'Gallinette', 'gaelle.mercier@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Gaelle', 'Mercier', '2 Rue de l\'Abbé Duval', 78130, 'Les Mureaux', 1, 0),
(4, 'Floflo', 'flo.pruvost@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Florian', 'Pruvost', '32 Rue François Truffaut', 78370, 'Plaisir', 1, 0),
(5, 'Tilie', 'tilie78@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Mathilde', 'Drouet', '2 Rue Thierry le Luron', 78180, 'Montigny-le-Bretonneux', 1, 0),
(6, 'Enzo', 'enzonimo@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Enzo', 'Bisson', '5 Avenue Toulouse Lautrec', 78390, 'Bois-d\'Arcy', 1, 0),
(7, 'Aymé', 'aymeric.neveu@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Aymeric', 'Neveu', '15 Rue Borgnis Desbordes', 78000, 'Versailles', 1, 0),
(8, 'Nissa', 'nissa@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Anissa ', 'LeCorre', '17 Rue Clément Ader', 78140, 'Vélizy-Villacoublay', 1, 0),
(9, 'Karim', 'karim.maes@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Karim', 'Maes', '14-34 Rue Costes et Bellonte', 78220, 'Viroflay', 1, 0),
(10, 'Didine', 'didine78@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Amandine', 'Toutain', '23 Rue Wauthier', 78100, 'Saint-Germain-en-Laye', 1, 0),
(11, 'Kiki', 'k.guery@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Kylian', 'Guery', '2 Rue de Bretagne', 78711, 'Mantes-la-Ville', 1, 0),
(12, 'KaïdKaïs', 'kaïs.mendes@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Kaïs', 'Mendes', '17 Rue Ronsard', 78300, 'Poissy', 1, 0),
(13, 'Apple', 'adam.celik@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Adam', 'Celik', '3 Rue de la Petite Côté', 78410, 'Aubergenville', 1, 0),
(14, 'Milady', 'mila.diaz@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Mila', 'Diaz', '59-29 Avenue de Normandie', 78450, 'Villepreux', 1, 0),
(15, 'Licette', 'alicette@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Alice', 'Carre', '9-7 Rue Jean Philippe Rameau', 78530, 'Buc', 1, 0),
(16, 'Younitek', 'you.pir@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Younes', 'Piron', '23 Rue Jules Michelet', 78280, 'Guyancourt', 1, 0),
(17, 'Nanou', 'nanou@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Anaelle', 'Lebreton', '21 Rue du Bel air', 78210, 'Saint-Cyr-l\'École', 1, 0),
(18, 'TheoLeo', 'theo.cottin@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Théo', 'Cottin', '44-68 Avenue Pasteur', 78340, 'Les Clayes-sous-Bois', 1, 0),
(19, 'DonDim', 'd.bouteiller@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Dimitri', 'Bouteiller', '7 Allée du Bourbonnais', 78310, 'Maurepas', 1, 0),
(20, 'Yoyo', 'yohan.burel@mail.com', '$2y$13$vvDi0RYzKavBSBzN4Ij5ZOy98OBSH14pFAbGRXN95wHH3gjpiNoAC', '[\"ROLE_USER\"]', 'Yohann ', 'Burel', '10-20 Boulevard du Général Exelmans', 78150, 'Le Chesnay-Rocquencourt', 1, 0);

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
-- Index pour la table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `IDX_232B318C7E3C61F9` (`owner_id`),
  ADD KEY `IDX_232B318C12469DE2` (`category_id`);

--
-- Index pour la table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_B6BD307F4675F064` (`borrowing_id`),
  ADD KEY `IDX_B6BD307FF675F31B` (`author_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `game`
--
ALTER TABLE `game`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  ADD CONSTRAINT `FK_232B318C12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `FK_232B318C7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `FK_B6BD307F4675F064` FOREIGN KEY (`borrowing_id`) REFERENCES `borrowing` (`id`),
  ADD CONSTRAINT `FK_B6BD307FF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
