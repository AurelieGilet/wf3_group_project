# Bienvenue sur Jeux Partage !

Projet de groupe de fin de formation WebForce3. 

## Qu'est-ce que c'est ?

C'est un site de mise en relation de personnes qui souhaitent partager leurs jeux de société.

## Qui l'a fait ?

4 développeuses web junior:

* [Aurélie Gilet](https://github.com/AurelieGilet)
* [Céline Saint-Martin](https://github.com/CelineSaintMartin)
* [Céline Trivier](https://github.com/titiceline)
* [Véronique Khammisouk](https://github.com/VeroniqueKhammisouk)


## Quelles Technos ?

Ce projet est réalisé avec Symfony 5.2.4

## Installation

_Pour installer le site en local :_
*	$ git pull origin master 
*	$ cd jeux_partage
*	$ composer install

_Configuration connexion BDD dans le fichier .env :_
* DATABASE_URL="mysql://root:@127.0.0.1:3306/jeux_partage?" pour le serveur Xampp

_Création de la BDD et importation des tables :_
* $ php bin/console doctrine:database:create
* $ php bin/console doctrine:migrations:migrate
