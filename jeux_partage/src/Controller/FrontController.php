<?php

namespace App\Controller;

use App\Entity\Game;
use App\Repository\GameRepository;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

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

		
		// dump($games);
		return $this->render('front/catalog.html.twig', [
			'games' => $games
		]);
	}

	/**
	 * 
	 * @Route("/catalogue/{id}", name="catalogue_detail")
	 */

	 public function detail(Game $detailGame):Response
	 {

		return $this->render('front/detail.html.twig', [
				'detail' => $detailGame
		]);
	}

	


}
