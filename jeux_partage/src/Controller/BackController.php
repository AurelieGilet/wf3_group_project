<?php

namespace App\Controller;

use App\Entity\Game;
use App\Entity\User;
use App\Entity\Borrowing;
use App\Entity\Category;
use App\Form\GameFormType;
use App\Form\BorrowingFormType;
use App\Form\CategoryFormType;
use App\Repository\GameRepository;
use App\Repository\UserRepository;
use App\Repository\BorrowingRepository;
use App\Repository\CategoryRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\File\Exception\FileException;

class BackController extends AbstractController
{
    /**
     * @Route("/back", name="back")
     */
    public function index(): Response
    {
        return $this->render('back/index.html.twig', [
            'controller_name' => 'BackController',
        ]);
    }
}