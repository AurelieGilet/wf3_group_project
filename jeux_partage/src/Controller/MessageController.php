<?php

namespace App\Controller;

use App\Entity\User;
use App\Entity\Message;
use App\Entity\Borrowing;
use App\Form\MessengerAppFormType;
use App\Repository\BorrowingRepository;
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
    public function message(MessengerAppFormType $form, MessageRepository $messageRepo, Message $message = null, BorrowingRepository $borrowingRepo, Borrowing $borrowing = null, User $user = null, Request $request, EntityManagerInterface $manager ): Response
    {
		if (!$this->getUser())
		{
			return $this->redirectToRoute('security_login');
		}
		else
		{
			$user = $this->getUser();
			$messages = $messageRepo->findBy(['borrowing' => $borrowing]);

			dump($borrowing);

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

			return $this->render('message/borrowing_message_app.html.twig', [
				'messages' => $messages,
				'borrowing' => $borrowing,
				'form' => $form->createView()
			]);
		}
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
