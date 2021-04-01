<?php

namespace App\Entity;

use App\Entity\User;
use App\Entity\Category;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use App\Repository\GameRepository;

/**
 * @ORM\Entity(repositoryClass=GameRepository::class)
 */
class Game
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
	 * 
	 * @Assert\NotBlank(
	 * 		message="Merci de saisir le nom du jeu",
	 * 		groups={"game_registration"}
	 * )
     */
    private $name;

    /**
     * @ORM\Column(type="string", length=255)
	 * 
	 * @Assert\NotBlank(
	 * 		message="Merci d'indiquer la tranche d'âge",
	 * 		groups={"game_registration"}
	 * )
     */
    private $public;

    /**
     * @ORM\Column(type="integer")
	 * 
	 * @Assert\NotBlank(
	 * 		message="Indiquer le nombre de joueur minimum",
	 * 		groups={"game_registration"}
	 * )
     */
    private $minPlayers;

    /**
     * @ORM\Column(type="integer")
     */
    private $maxPlayers;

    /**
     * @ORM\Column(type="text")
	 * 
	 * @Assert\NotBlank(
	 * 		message="Merci de renseigner la règle du jeu",
	 * 		groups={"game_registration"}
	 * )
     */
    private $description;

    /**
     * @ORM\Column(type="string", length=255)
	 * 
     */
    private $image;

    /**
     * @ORM\ManyToOne(targetEntity=User::class, inversedBy="games")
     * @ORM\JoinColumn(nullable=false)
     */
    private $owner;

    /**
     * @ORM\ManyToOne(targetEntity=Category::class, inversedBy="games")
     * @ORM\JoinColumn(nullable=false)
     */
    private $category;

    /**
     * @ORM\Column(
	 * 		type="boolean",
	 * 		options={"default":0}
	 * )
     */
    private $isArchived = 0;



    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getPublic(): ?string
    {
        return $this->public;
    }

    public function setPublic(string $public): self
    {
        $this->public = $public;

        return $this;
    }

    public function getMinPlayers(): ?int
    {
        return $this->minPlayers;
    }

    public function setMinPlayers(int $minPlayers): self
    {
        $this->minPlayers = $minPlayers;

        return $this;
    }

    public function getMaxPlayers(): ?int
    {
        return $this->maxPlayers;
    }

    public function setMaxPlayers(int $maxPlayers): self
    {
        $this->maxPlayers = $maxPlayers;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(string $image): self
    {
        $this->image = $image;

        return $this;
    }

    public function getOwner(): ?User
    {
        return $this->owner;
    }

    public function setOwner(?User $owner): self
    {
        $this->owner = $owner;

        return $this;
    }

    public function getCategory(): ?Category
    {
        return $this->category;
    }

    public function setCategory(?Category $category): self
    {
        $this->category = $category;

        return $this;
    }

    public function getIsArchived(): ?bool
    {
        return $this->isArchived;
    }

    public function setIsArchived(bool $isArchived): self
    {
        $this->isArchived = $isArchived;

        return $this;
    }

    
}
