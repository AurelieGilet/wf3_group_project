<?php

namespace App\Controller;

use App\Entity\Game;
use App\Entity\User;
use App\Entity\Borrowing;
use App\Form\GameFormType;
use App\Form\BorrowingFormType;
use App\Repository\BorrowingRepository;
use App\Repository\GameRepository;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;

class FrontController extends AbstractController
{
    /**
     * @Route("/", name="home")
     */
    public function home(): Response
    {
        return $this->render('front/home.html.twig');
    }


	/**
	 * @Route("/catalogue", name="catalogue")
	 * 
	 */
	public function catalogue(GameRepository $gameRepo, BorrowingRepository $borrowingRepo): Response
	{
		$games = $gameRepo->findAll();
		dump($games);

		$borrowing = $borrowingRepo->findBy(['returnDate' => NULL]);
		dump($borrowing);

		$gamesId = array();
		foreach ($borrowing as $key => $value) {
			array_push($gamesId, $value->getGame()->getId());
		}
		dump($gamesId);

		
		return $this->render('front/catalog.html.twig', [
			'games' => $games,
			'gamesId' => $gamesId
		]);
	}
  
  	/**
	 * @Route("/catalogue/{id}", name="detail")
	 * 
	 */
	public function detail(Game $game):Response
	{

		return $this->render('front/detail.html.twig', [
				'game' => $game
		]);
	}

	/**
	 * @Route("/emprunts/{id}", name="borrowing")
	 */
	public function borrowing(Request $request, EntityManagerInterface $manager, Borrowing $borrowing = null, GameRepository $gameRepo, Game $game, UserRepository $userRepo, User $user = null): Response
	{
		$borrowing = new Borrowing;
		$user = $this->getUser();
		dump($user);
		
		$lender = $userRepo->findOneBy(['id' => $game->getOwner()]);
		dump($lender);


		$startDate = new \DateTime;;
		$endDate = (new \DateTime)->add(new \DateInterval('P1M'));

		$form = $this->createForm(BorrowingFormType::class, $borrowing);
		$form->handleRequest($request);

		if($form->isSubmitted() && $form->isValid())
		{
			$borrowing->setLender($lender);
			$borrowing->setBorrower($user);
			$borrowing->setGame($game);
			$borrowing->setStartDate($startDate);
			$borrowing->setEndDate($endDate);

			$manager->persist($borrowing);
			$manager->flush();

			$this->addFlash('success', "Votre emprunt est validé");
		}

		dump($request);
		dump($form);


		return $this->render('front/borrowing.html.twig', [
			'game' => $game, 
			'form' => $form->createView(),
			'startDate' => $startDate,
			'endDate' => $endDate
		]);
	}

	/**
	 * @Route("/compte/jeux", name="account_games")
	 */
	public function showGames(GameRepository $gameRepo, User $user = null): Response
	{
		$user = $this->getUser();

		// dump($user);
	
		$games = $gameRepo->findBy(array('owner' => $user));
		dump($games);
		
		return $this->render('front/account_games.html.twig', [
			'games' => $games
		]);
	}

	/**
	 * @Route("/compte/jeux/nouveau", name="account_games_create")
	 * @Route("/compte/jeux/edit/{id}", name="account_games_edit")
	 * 
	 */
	public function createGame(Request $request, SluggerInterface $slugger, EntityManagerInterface $manager,Game $game = null, User $user = null): Response
	{
		$user = $this->getUser();

		if(!$game)
		{
			$game = new Game;
		}

		$form = $this->createForm(GameFormType::class, $game);
		$form->handleRequest($request);

		if($form->isSubmitted() && $form->isValid())
		{
			/** @var UploadedFile $imageFile */
			$imageFile = $form->get('image')->getData();

			if($imageFile)
			{
				$gameName = $game->getName();
				$safeFilename = $slugger->slug($gameName);
				$filename = $safeFilename.'-'.uniqid().'-'.$imageFile->guessExtension();
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

			if(!$game->getId())
			{
				$message = "Le jeu " . $game->getName() . " a bien été ajouté à votre compte";
			}
			else
			{
				$message = "Le jeu " . $game->getName() . " a bien été modifié";
			}

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
