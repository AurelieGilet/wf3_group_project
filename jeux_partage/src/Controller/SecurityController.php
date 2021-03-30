<?php

namespace App\Controller;


use App\Entity\User;
use App\Form\ProfilFormType;
use App\Form\RegistrationFormType;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class SecurityController extends AbstractController
{
    /**
	 * Method to register users
     * @Route("/inscription", name="security_registration")
     */
    public function registration(Request $request, EntityManagerInterface $manager, UserPasswordEncoderInterface $encoder, AuthorizationCheckerInterface $authChecker): Response
    {
		if($authChecker->isGranted('ROLE_USER'))
		{
			return $this->redirectToRoute('security_login');
		}

        $user = new User;
        $form = $this->createForm(RegistrationFormType::class, $user, [
			'validation_groups' => ['registration']
		]);

        $form->handleRequest($request);

        if($form->isSubmitted() && $form->isValid())
        {
            $hash = $encoder->encodePassword($user, $user->getPassword());
			$roles = ["ROLE_USER"];

			$user->setPassword($hash);
			$user->setRoles($roles);
			$user->setIsRegistered(false);

            $manager->persist($user);
            $manager->flush();

			$this->addFlash('success', "Votre compte a bien été créé");

			return $this->redirectToRoute('security_login');
        }

        return $this->render('security/registration.html.twig', [
            'form' => $form->createView()
        ]);
    }

	/**
	 * Method to authenticate users
	 * @Route("/connexion", name="security_login")
	 */
	public function login(AuthenticationUtils $authenticationUtils, AuthorizationCheckerInterface $authChecker): Response
	{
		if($authChecker->isGranted('ROLE_USER'))
		{
			return $this->redirectToRoute('home');
		}
		$error = $authenticationUtils->getLastAuthenticationError();
		$lastUsername = $authenticationUtils->getLastUsername();

		return $this->render('security/login.html.twig', [
			'error' => $error,
			'lastUsername' => $lastUsername
		]);
	}

	/**
	 * Method to log out users
	 * @Route("/deconnexion", name="security_logout")
	 */
	public function logout()
	{

	}

	/**
	 * Method to complete registration in user account
	 * @Route("/compte/profil", name="security_profil")
	 */
	public function profilUpdate(Request $request, EntityManagerInterface $manager, User $user = null, AuthorizationCheckerInterface $authChecker): Response
	{
		if($authChecker->isGranted('ROLE_ADMIN'))
		{
			return $this->redirectToRoute('admin');
		}
		elseif(!$authChecker->isGranted('ROLE_USER') && !$authChecker->isGranted('ROLE_ADMIN')) 
		{
			return $this->redirectToRoute('security_login');
		}
		$user = $this->getUser();

		$form = $this->createForm(ProfilFormType::class, $user, [
			'validation_groups' => ['profil'] 
		]);
		$form->handleRequest($request);

		if($form->isSubmitted() && $form->isValid())
		{

			$user->setIsRegistered(true);

			$manager->persist($user);
			$manager->flush();

			$this->addFlash('success', "Votre profil a bien été mis à jour");
		}

		return $this->render('security/profil.html.twig', [
			'form' => $form->createView()
		]);
		
	}
    
}
