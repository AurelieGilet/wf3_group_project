<?php

namespace App\Controller;

use App\Entity\User;
use App\Repository\UserRepository;
use App\Form\AdminRegistrationFormType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class BackController extends AbstractController
{
    /**
     * @Route("/admin", name="admin")
     */
    public function index(): Response
    {
        return $this->render('back/index.html.twig');
    }

    
    /**
     * @Route("/admin/users", name="admin_users")
     * @Route("/admin/user/{id}/delete", name="admin_delete_user")
     */
    public function adminUsers(UserRepository $repoUsers, EntityManagerInterface $manager, User $user = null): Response
    {
        $colonnes = $manager->getClassMetadata(User::class)->getFieldNames();

        $users = $repoUsers->findAll();

        if($user)
        {
            $nomUtilisateur = $user->getUsername();

            $manager->remove($user);
            $manager->flush();

            $this->addFlash("success", "Le membre " . $nomUtilisateur . " a bien été supprimé");

            return $this->redirectToRoute("admin_users");
        }

        return $this->render("back/admin_users.html.twig", [
            "colonnes" => $colonnes,
            "users" => $users
        ]);
    }

    
    /**
     * @Route("/admin/user/{id}/edit", name="admin_edit_user")
     */
    public function editUser(Request $request, EntityManagerInterface $manager, User $user): Response
    {
        $formUser = $this->createForm(AdminRegistrationFormType::class, $user);
        
        $formUser->handleRequest($request);

        if($formUser->isSubmitted() && $formUser->isValid())
        {
            $manager->persist($user);
            $manager->flush();

            $this->addFlash("success", "Le membre" . $user->getUsername() . " a bien été modifié");

            return $this->redirectToRoute("admin_users");
        }

        return $this->render("back/admin_edit_user.html.twig", [
            "formUser" => $formUser->createView()
        ]);
    }

}
