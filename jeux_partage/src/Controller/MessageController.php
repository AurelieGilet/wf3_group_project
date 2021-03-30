<?php

namespace App\Controller;

use App\Entity\User;
use App\Entity\Message;
use App\Entity\Borrowing;
use App\Form\MessengerAppFormType;
use App\Repository\MessageRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class MessageController extends AbstractController
{
	/**
     * @Route("/messagerie/emprunt/{id}", name="messenger_borrowing")
     */
    public function message(MessengerAppFormType $form, Borrowing $borrowing = null): Response
    {

		$message = new Message;

		$form = $this->createForm(MessengerAppFormType::class, $message);
	
        return $this->render('message/borrowing_message_app.html.twig', [
			'borrowing' => $borrowing,
			'form' => $form->createView()
        ]);
    }

	/**
	 * @Route("/messages/emprunt/{id}", name="messenger_ajax_request")
	 */
	public function showMessages(MessageRepository $messageRepo, Borrowing $borrowing = null): Response
	{
		$messages = $messageRepo->findBy(['borrowing' => $borrowing]);
		dump($messages);

		return $this->render('message/_messages.html.twig', [
			'messages' => $messages
		]);
		
	}

	/**
	 * @Route("/messages/emprunt/envoi/{id}", name="messenger_ajax_send")
	 */
	public function sendMessage(Borrowing $borrowing = null, User $user = null, Request $request, EntityManagerInterface $manager)    
	{
      $user = $this->getUser();

      $message = new Message;

      $form = $this->createForm(MessengerAppFormType::class, $message);
      $form->handleRequest($request);

			if($form->isSubmitted() && $form->isValid())
			{
				$message->setBorrowing($borrowing);
				$message->setAuthor($user);
				$message->setCreatedAt(new \DateTime);

				$manager->persist($message);
				$manager->flush();

				return $this->redirectToRoute('messenger_borrowing', ['id' => $borrowing->getId() ]);
			}

		return new Response('Cette URL est incorrecte, merci de retourner sur le site principal', 400);
  }
  
	/**
	 * @Route("/messagerie", name="messenger")
	 */
	public function redirectMessenger()
	{
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			return $this->redirectToRoute('account_games_borrowed');
		}
	}
}
