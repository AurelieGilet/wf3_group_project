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
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class SecurityController extends AbstractController
{
    /**
     * @Route("/inscription", name="security_registration")
     */
    public function registration(Request $request, EntityManagerInterface $manager, UserPasswordEncoderInterface $encoder): Response
    {
        $user = new User;
        $form = $this->createForm(RegistrationFormType::class, $user, [ 'validation_groups' => ['registration'] 
	]);

        $form->handleRequest($request);

        // dump($request);

        if($form->isSubmitted() && $form->isValid())
        {
            $hash = $encoder->encodePassword($user, $user->getPassword() );

            $user->setPassword($hash);
			
			$roles = ["ROLE_USER"];

			$user->setRoles($roles);

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
	 * @Route("/connexion", name="security_login")
	 */
	public function login(AuthenticationUtils $authenticationUtils): Response
	{
		$error = $authenticationUtils->getLastAuthenticationError();
		$lastUsername = $authenticationUtils->getLastUsername();

		dump($authenticationUtils);

		return $this->render('security/login.html.twig', [
			'error' => $error,
			'lastUsername' => $lastUsername
		]);
		
	}

	/**
	 * @Route("/deconnexion", name="security_logout")
	 */
	public function logout()
	{

	}

	/**
	 * @Route("/compte/profil", name="security_profil")
	 */
	public function profilUpdate(Request $request, EntityManagerInterface $manager, User $user = null): Response
	{
		$user = $this->getUser();

		$form = $this->createForm(ProfilFormType::class, $user, [
			'validation_groups' => ['profil'] 
		]);
		$form->handleRequest($request);

		if($form->isSubmitted() && $form->isValid())
		{
			$manager->persist($user);
			$manager->flush();

			$this->addFlash('success', "Votre profil a bien été mis à jour");
		}

		return $this->render('security/profil.html.twig', [
			'form' => $form->createView()
		]);
		
	}
    
}
