<?php

namespace App\Controller;

use App\Entity\Game;
use App\Entity\User;
use App\Entity\Category;
use App\Entity\Borrowing;
use App\Form\GameFormType;
use App\Form\GameEditFormType;
use App\Form\BorrowingFormType;
use App\Repository\GameRepository;
use App\Repository\UserRepository;
use App\Repository\CategoryRepository;
use App\Repository\BorrowingRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\File\File;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface;

class FrontController extends AbstractController
{
	// Method to get all categories from DB and send them to template
	public function categories(CategoryRepository $categoryRepo): Response
	{
		$categories = $categoryRepo->findAll();

		return $this->render('front/_category.html.twig', [
			'categories' => $categories
		]);
	}

    /**
     * @Route("/", name="home")
     */
    public function home(): Response
    {
        return $this->render('front/home.html.twig');
    }

	/**
	 * Method to show games list on catalog page
	 * Method to show games listed by category
	 * @Route("/catalogue", name="catalogue")
	 * @Route("/catalogue/{id}", name="catalogue_category")
	 */
	public function catalogue(GameRepository $gameRepo, BorrowingRepository $borrowingRepo, CategoryRepository $categoryRepo, Category $category = null): Response
	{
		$categoryName = "";
		if($category != null)
		{
			$games = $gameRepo->findBy(['category' => $category->getId()]);
			$categoryName = $category->getName();
		}
		else
		{
			$games = $gameRepo->findBy(array('isArchived' => false));
		}

		$borrowings = $borrowingRepo->findBy(['returnDate' => NULL]);

		// Map containing borrowing objects for games not yet returned : is used in template to update status (available for borrowing or not) and if not available, display the presumed date of return (endDate)
		$borrowedGames = [];
		foreach ($borrowings as $borrowing) {
			$borrowedGames[$borrowing->getGame()->getId()] = $borrowing;
		}

		return $this->render('front/catalog.html.twig', [
			'games' => $games,
			'borrowedGames' => $borrowedGames,
			'categoryName' => $categoryName
		]);
	}
  
  	/**
	 * Method to show the details of a game
	 * @Route("/catalogue/detail/{id}", name="detail")
	 */
	public function detail(Game $game, BorrowingRepository $borrowingRepo):Response
	{
		$borrowing = $borrowingRepo->findOneBy(['game' => $game, 'returnDate' => NULL]);

		return $this->render('front/detail.html.twig', [
				'game' => $game,
				'borrowing' => $borrowing
		]);
	}

	/**
	 * Method to borrow a game
	 * @Route("/emprunts/{id}", name="borrowing")
	 */
	public function borrowing(Request $request, EntityManagerInterface $manager, Borrowing $borrowing = null, Game $game, UserRepository $userRepo, BorrowingRepository $borrowingRepo, User $user = null): Response
	{
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			$user = $this->getUser();

			$borrowedGame = $borrowingRepo->findBy(array('game' => $game, 'returnDate' => null));

			if ($user == $game->getOwner()) {
				$this->addFlash('danger', "Vous ne pouvez pas emprunter vos propres jeux");
					return $this->redirectToRoute('catalogue');
			}
			elseif(!$borrowedGame) 
			{
				$borrowing = new Borrowing;
				
				$lender = $userRepo->findOneBy(['id' => $game->getOwner()]);

				$startDate = new \DateTime;
				$endDate = (new \DateTime)->add(new \DateInterval('P1M'));

				$form = $this->createForm(BorrowingFormType::class, $borrowing);
				$form->handleRequest($request);

				if($form->isSubmitted() && $form->isValid() && $user->getIsRegistered() == true)
				{
					$borrowing->setLender($lender);
					$borrowing->setBorrower($user);
					$borrowing->setGame($game);
					$borrowing->setStartDate($startDate);
					$borrowing->setEndDate($endDate);

					$manager->persist($borrowing);
					$manager->flush();

					$this->addFlash('success', "Votre emprunt est validé");

					return $this->redirectToRoute('account_games_borrowed');
				}
				elseif($form->isSubmitted() && $form->isValid() && $user->getIsRegistered() != true)
				{
					$this->addFlash('danger', "Vous devez compléter votre profil avant de pouvoir emprunter un jeu");
					return $this->redirectToRoute('security_profil');
				}
			}
			else 
			{
				$this->addFlash('danger', "Ce jeu est déjà emprunté");
					return $this->redirectToRoute('catalogue');
			}
			
			return $this->render('front/borrowing.html.twig', [
				'game' => $game, 
				'form' => $form->createView(),
				'startDate' => $startDate,
				'endDate' => $endDate
			]);
		}
	}

	/**
	 * Method to show on user account their games 
	 * @Route("/compte/jeux", name="account_games")
	 * @Route("/compte/jeux/supprimer/{id}", name="account_games_delete")
	 */
	public function showGames(EntityManagerInterface $manager, GameRepository $gameRepo, BorrowingRepository $borrowingRepo, Game $game = null, User $user = null, AuthorizationCheckerInterface $authChecker): Response
	{
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			$user = $this->getUser();
		
			$games = $gameRepo->findBy(array('owner' => $user, 'isArchived' => false));

			$borrowings = $borrowingRepo->findBy(['returnDate' => NULL]);
			$borrowedGamesId= array();
			foreach ($borrowings as $key => $value) {
				array_push($borrowedGamesId, $value->getGame()->getId());
			}

			if($game != null) 
			{
				$gameId = $game->getId();
				$gameName = $game->getName();
				if(in_array($gameId, $borrowedGamesId))
				{
					$this->addFlash("danger", "Impossible de supprimer le jeu $gameName : il est emprunté");
					return $this->redirectToRoute('account_games');
				}
				else
				{
					$game->setIsArchived(true);
					$manager->persist($game);
					$manager->flush();

					$this->addFlash('success', "Votre jeu $gameName a bien été supprimé");
					return $this->redirectToRoute('account_games');
				}
				
			}
			
			return $this->render('front/account_games.html.twig', [
				'games' => $games
			]);
		}
	}

	/**
	 * Method on user account to add a new game
	 * @Route("/compte/jeux/nouveau", name="account_games_create")
	 */
	public function createGame(Request $request, SluggerInterface $slugger, EntityManagerInterface $manager, User $user = null): Response
	{
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			$user = $this->getUser();

			$game = new Game;
			
			$form = $this->createForm(GameFormType::class, $game);
			$form->handleRequest($request);

			if($form->isSubmitted() && $form->isValid())
			{
				/** @var UploadedFile $imageFile */
				$imageFile = $form->get('image')->getData();
				
				if($imageFile != null)
				{
					$gameName = $game->getName();
					$safeFilename = $slugger->slug($gameName);
					$filename = $safeFilename.'-'.uniqid().'.'.$imageFile->guessExtension();
					try {
						$imageFile->move(
							$this->getParameter('images_directory'),
							$filename
						);
					} catch (FileException $e) {
						
					}
					$game->setImage($filename);
				}

				$game->setOwner($user);

				$message = "Le jeu " . $game->getName() . " a bien été ajouté à votre compte";

				$manager->persist($game);
				$manager->flush();

				$this->addFlash('success', $message);

				return $this->redirectToRoute('account_games');
			}
			
			return $this->render('front/account_games_registration.html.twig', [
				'form' => $form->createView(), 
				'gameName' => null
			]);
		}
	}

	/**
	 * Method on user account to add a new game or edit an existing one
	 * @Route("/compte/jeux/edit/{id}", name="account_games_edit")
	 */
	public function editGame(Request $request, SluggerInterface $slugger, EntityManagerInterface $manager,Game $game = null): Response
	{
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			$form = $this->createForm(GameEditFormType::class, $game);
			$form->handleRequest($request);

			if($form->isSubmitted() && $form->isValid())
			{
				/** @var UploadedFile $imageFile */
				$imageFile = $form->get('image')->getData();
				
				if($imageFile != null)
				{
					$gameName = $game->getName();
					$safeFilename = $slugger->slug($gameName);
					$filename = $safeFilename.'-'.uniqid().'.'.$imageFile->guessExtension();
					try {
						$imageFile->move(
							$this->getParameter('images_directory'),
							$filename
						);
					} catch (FileException $e) {
						
					}
					$game->setImage($filename);
				}
				else
				{
					$game->setImage($game->getImage());
				}

				$message = "Le jeu " . $game->getName() . " a bien été modifié";

				$manager->persist($game);
				$manager->flush();

				$this->addFlash('success', $message);

				return $this->redirectToRoute('account_games');
			}
			
			return $this->render('front/account_games_registration.html.twig', [
				'form' => $form->createView(), 
				'gameName' => $game->getName()
			]);
		}
	}

	/**
	 * Method to show on user account their borrowed games 
	 * Method to cancel game borrowing
	 * @Route("/compte/emprunts", name="account_games_borrowed")
	 * @Route("/compte/emprunts/annulation/{id}", name="account_games_borrowing_cancel")
	 */
	public function gamesBorrowed(EntityManagerInterface $manager, BorrowingRepository $borrowingRepo, Borrowing $borrowing = null): Response
	{
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			$user = $this->getUser();

			$borrowings = $borrowingRepo->findBy(['borrower' => $user]);

			if($borrowing != null && $borrowing->getGiveawayDate() == null)
			{
				$manager->remove($borrowing);
				$manager->flush();

				$this->addFlash('success', "Votre emprunt a bien été annulé");
				return $this->redirectToRoute('account_games_borrowed');
			}
			elseif($borrowing != null && $borrowing->getGiveawayDate() != null)
			{
				$this->addFlash('danger', "Votre emprunt ne peut pas être annulé");
				return $this->redirectToRoute('account_games_borrowed');
			}

			return $this->render('front/account_games_borrowed.html.twig', [
				'borrowings' => $borrowings
			]);
		}
	}

	/**
	 * Method to show lended games on user accout
	 * Method to cancel game lending
	 * @Route("/compte/prets", name="account_games_lended")
	 * @Route("/compte/prets/annulation/{id}", name="account_games_lended_cancel")
	 */
	public function gamesLended(BorrowingRepository $borrowingRepo, Borrowing $borrowing = NULL, Request $request, EntityManagerInterface $manager): Response
	{
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			$user = $this->getUser();
			$lendings = $borrowingRepo->findBy(['lender' => $user]);

			if($borrowing != null && $borrowing->getGiveawayDate() == null)
			{
				$manager->remove($borrowing);
				$manager->flush();

				$this->addFlash('success', "Votre prêt a bien été annulé");
				return $this->redirectToRoute('account_games_lended');
			}
			elseif($borrowing != null && $borrowing->getGiveawayDate() != null)
			{
				$this->addFlash('danger', "Votre prêt ne peut pas être annulé");
				return $this->redirectToRoute('account_games_lended');
			}

			return $this->render('front/account_games_lended.html.twig', [
				'lendings' => $lendings
			]);
		}
	}

	/**
	 * Method to indicate the game has been given to the borrower
	 * Method to indicate the game has been returned by the borrower
	 * @Route("/compte/prets/remise/{id}", name="account_games_lended_giveaway")
	 * @Route("/compte/prets/retour/{id}", name="account_games_lended_return")
	 */
	public function lendingValidation(Borrowing $borrowing = NULL, Request $request, EntityManagerInterface $manager): Response
	{
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			if($borrowing != null)
			{
				if($borrowing->getGiveawayDate() == null && $borrowing->getReturnDate() == null)
				{
					$borrowing->setGiveawayDate(new \DateTime);
					$manager->persist($borrowing);
					$manager->flush();

					$this->addFlash('success', "Le jeu a été remis à l'emprunteur");

					return $this->redirectToRoute('account_games_lended');
				}
				elseif($borrowing->getReturnDate() == null && $borrowing->getGiveawayDate() != null)
				{
					$borrowing->setReturnDate(new \DateTime);
					$manager->persist($borrowing);
					$manager->flush();

					$this->addFlash('success', "Le jeu a été rendu par l'emprunteur");
					
					return $this->redirectToRoute('account_games_lended');
				}
			}

			return $this->render('front/account_games_lended.html.twig');
		}
	}
}
