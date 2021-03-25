<?php

namespace App\Controller;

use App\Entity\Game;
use App\Entity\User;
use App\Form\GameFormType;
use App\Repository\GameRepository;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\String\Slugger\SluggerInterface;

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
	public function catalogue(GameRepository $gameRepo): Response
	{
		$games = $gameRepo->findAll();
		dump($games);
		
		// dump($games);
		return $this->render('front/catalog.html.twig', [
			'games' => $games
		]);
	}
  
  	/**
	 * @Route("/catalogue/{id}", name="catalogue_detail")
	 * 
	 */
	public function detail(Game $detailGame):Response
	{

		return $this->render('front/detail.html.twig', [
				'detail' => $detailGame
		]);
	}

	/**
	 * @Route("/compte/jeux", name="account_games")
	 */
	public function showGames(GameRepository $gameRepo, User $user = null): Response
	{
		$user = $this->getUser();

		dump($user);
	
		$games = $gameRepo->findBy(array('owner' => $user));
		dump($games);
		
		return $this->render('front/account_games.html.twig', [
			'games' => $games
		]);
	}

	/**
	 * @Route("/compte/jeux/nouveau", name="account_games_create")
	 * 
	 */
	public function createGame(Request $request, SluggerInterface $slugger, EntityManagerInterface $manager,Game $game = null, User $user = null): Response
	{
		$user = $this->getUser();

		$game = new Game;

		$form = $this->createForm(GameFormType::class, $game);
		$form->handleRequest($request);
		// dd($request);

		if($form->isSubmitted() && $form->isValid())
		{
			$gameName = $game->getName();

			/** @var UploadedFile $imageFile */
			$imageFile = $form->get('image')->getData();

			if($imageFile)
			{
				$safeFilename = $slugger->slug($gameName);
				$filename = $safeFilename.'-'.uniqid().'-'.$imageFile->guessExtension();
				try {
					$imageFile->move(
						$this->getParameter('images_directory'),
						$filename
					);
				} catch (FileException $e) {
					
				}
			}

			$game->setImage($filename);
			$game->setOwner($user);

			$manager->persist($game);
			$manager->flush();

			$this->addFlash('success', "Le jeu a bien été ajouté à votre compte !");

			return $this->redirectToRoute('account_games');

		}

		return $this->render('front/account_games_registration.html.twig', [
			'form' => $form->createView()
		]);
	}






}
