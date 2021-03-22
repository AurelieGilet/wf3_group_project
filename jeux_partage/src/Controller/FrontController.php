<?php

namespace App\Controller;

use App\Repository\GameRepository;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class FrontController extends AbstractController
{
    /**
     * @Route("/front", name="front")
     */
    public function index(): Response
    {
        return $this->render('front/index.html.twig', [
            'controller_name' => 'FrontController',
        ]);
    }


	/**
	 * @Route("/catalogue", name="catalogue")
	 */
	public function catalogue(GameRepository $gameRepo): Response
	{
		$games = $gameRepo->findAll();

		// dump($games);
		return $this->render('front/catalogue.html.twig', [
			'games' => $games
		]);
	}

}
