<?php

namespace App\Controller;

use App\Entity\Message;
use App\Entity\Borrowing;
use App\Form\MessengerAppFormType;
use App\Repository\MessageRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class MessageController extends AbstractController
{
    /**
     * @Route("/messagerie/emprunt/{id}", name="messenger_borrowing")
     */
    public function index(MessengerAppFormType $form, MessageRepository $messageRepo, Borrowing $borrowing, Message $message, Request $request, EntityManagerInterface $manager ): Response
    {
		$messages = $messageRepo->findBy(['borrowing' => $borrowing]);

		$form = $this->createForm(MessengerAppFormType::class, $message);
		$form->handleRequest($request);

        return $this->render('borrowing_message_app/index.html.twig', [

        ]);
    }
}
