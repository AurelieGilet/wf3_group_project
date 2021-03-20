<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class JeuxPartageController extends AbstractController
{
    /**
     * @Route("/jeux/partage", name="jeux_partage")
     */
    public function index(): Response
    {
        return $this->render('jeux_partage/index.html.twig', [
            'controller_name' => 'JeuxPartageController',
        ]);
    }
}
