<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20210324213431 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE borrowing (id INT AUTO_INCREMENT NOT NULL, lender_id INT NOT NULL, borrower_id INT NOT NULL, game_id INT NOT NULL, start_date DATETIME NOT NULL, end_date DATETIME NOT NULL, return_date DATETIME DEFAULT NULL, INDEX IDX_226E5897855D3E3D (lender_id), INDEX IDX_226E589711CE312B (borrower_id), INDEX IDX_226E5897E48FD905 (game_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE category (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE game (id INT AUTO_INCREMENT NOT NULL, owner_id INT NOT NULL, category_id INT NOT NULL, name VARCHAR(255) NOT NULL, public VARCHAR(255) NOT NULL, min_players INT NOT NULL, max_players INT NOT NULL, description LONGTEXT NOT NULL, image VARCHAR(255) NOT NULL, INDEX IDX_232B318C7E3C61F9 (owner_id), INDEX IDX_232B318C12469DE2 (category_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user (id INT AUTO_INCREMENT NOT NULL, username VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL, password VARCHAR(255) NOT NULL, roles LONGTEXT NOT NULL COMMENT \'(DC2Type:json)\', firstname VARCHAR(255) DEFAULT NULL, lastname VARCHAR(255) DEFAULT NULL, address VARCHAR(255) DEFAULT NULL, zipcode INT DEFAULT NULL, city VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE borrowing ADD CONSTRAINT FK_226E5897855D3E3D FOREIGN KEY (lender_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE borrowing ADD CONSTRAINT FK_226E589711CE312B FOREIGN KEY (borrower_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE borrowing ADD CONSTRAINT FK_226E5897E48FD905 FOREIGN KEY (game_id) REFERENCES game (id)');
        $this->addSql('ALTER TABLE game ADD CONSTRAINT FK_232B318C7E3C61F9 FOREIGN KEY (owner_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE game ADD CONSTRAINT FK_232B318C12469DE2 FOREIGN KEY (category_id) REFERENCES category (id)');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE game DROP FOREIGN KEY FK_232B318C12469DE2');
        $this->addSql('ALTER TABLE borrowing DROP FOREIGN KEY FK_226E5897E48FD905');
        $this->addSql('ALTER TABLE borrowing DROP FOREIGN KEY FK_226E5897855D3E3D');
        $this->addSql('ALTER TABLE borrowing DROP FOREIGN KEY FK_226E589711CE312B');
        $this->addSql('ALTER TABLE game DROP FOREIGN KEY FK_232B318C7E3C61F9');
        $this->addSql('DROP TABLE borrowing');
        $this->addSql('DROP TABLE category');
        $this->addSql('DROP TABLE game');
        $this->addSql('DROP TABLE user');
    }
}
