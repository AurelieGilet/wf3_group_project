<?php

namespace App\Controller;
use App\Entity\User;
use App\Entity\Category;
use App\Entity\Game;
use App\Entity\Borrowing;
use App\Form\RegistrationFormType;
use App\Form\CategoryFormType;
use App\Form\GameFormType;
use App\Form\BorrowingFormType;
use App\Repository\UserRepository;
use App\Repository\CategoryRepository;
use App\Repository\GameRepository;
use App\Repository\BorrowingRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

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
    public function adminArticles(EntityManagerInterface $manager, ArticleRepository $repoArticle, Article $article = null): Response
    {

        $colonnes = $manager->getClassMetadata(Article::class)->getFieldNames();

        dump($colonnes);
        dump($article);

        $articles = $repoArticle->findAll(); 

        dump($articles);

        if($article)
        {
            $id = $article->getId();

            $manager->remove($article);
            $manager->flush(); 

            $this->addFlash('success', "L'article n°$id a bien été supprimé !");

            return $this->redirectToRoute('admin_articles');
        }

        return $this->render('admin/admin_articles.html.twig', [
            'colonnes' => $colonnes,
            'articlesBdd' => $articles 
        ]);
    }

    /**
    
     * @Route("/admin/{id}/edit-article", name="admin_edit_article")
     */
    public function adminEditArticle(Article $article, Request $request, EntityManagerInterface $manager)
    {
        dump($article);


        $formArticle = $this->createForm(ArticleFormType::class, $article);

        dump($request);

        $formArticle->handleRequest($request);

        if($formArticle->isSubmitted() && $formArticle->isValid())
        {

            $manager->persist($article);
            $manager->flush(); 

            $this->addFlash('success', "L'article n°" . $article->getId() . " a bien été modifié");

            return $this->redirectToRoute('admin_articles');
        }

        return $this->render('admin/admin_edit_article.html.twig', [
            'idArticle' => $article->getId(),
            'formArticle' => $formArticle->createView()
        ]);
    }

    /**
     * @Route("/admin/categories", name="admin_category")
     * @Route("/admin/category/{id}/remove", name="admin_remove_category")
     */
    public function adminCategory(EntityManagerInterface $manager, CategoryRepository $repoCategory, Category $category = null): Response
    {
        $colonnes = $manager->getClassMetadata(Category::class)->getFieldNames();

        dump($colonnes);
        dump($category);

       
        if($category)
        {

            if($category->getArticles()->isEmpty())
            {
                $manager->remove($category);
                $manager->flush();

                $this->addFlash('success', "La catégorie a été supprimée avec succès !");
            }
            else 
            {
                $this->addFlash('danger', "Il n'est pas possible de supprimer la catégorie car des articles y sont toujours associés !");
            }

            return $this->redirectToRoute('admin_category');
        }

        $categoryBdd = $repoCategory->findAll();

        dump($categoryBdd);

        return $this->render('admin/admin_category.html.twig', [
            'colonnes' => $colonnes,
            'categoryBdd' => $categoryBdd
        ]);
    }

    /**
     * @Route("/admin/category/new", name="admin_new_category")
     * @Route("/admin/category/{id}/edit", name="admin_edit_category")
     */
    public function adminFormCategory(Request $request, EntityManagerInterface $manager, Category $category = null): Response
    {
        if(!$category)
        {
            $category = new Category;
        }

        $formCategory = $this->createForm(CategoryFormType::class, $category, [
            'validation_groups' => ['category']
        ]);

        dump($request);

        $formCategory->handleRequest($request); 

        dump($category);

        if($formCategory->isSubmitted() && $formCategory->isValid())
        {
            if(!$category->getId())
                $message = "La catégorie " . $category->getTitle() . " a été enregistrée avec succès !";
            else 
                $message = "La catégorie " . $category->getTitle() . " a été modifiée avec succès !";

            $manager->persist($category);

            $this->addFlash('success', $message);

            return $this->redirectToRoute('admin_category');
        }

        return $this->render('admin/admin_form_category.html.twig', [
            'formCategory' => $formCategory->createView()
        ]);  
    }

    /**
     * @Route("/admin/comments", name="admin_comments")
     * @Route("/admin/comment/{id}/remove", name="admin_remove_comment")
     */
    public function adminComment(EntityManagerInterface $manager, CommentRepository $repoComment, Comment $comment = null): Response
    {
        $colonnes = $manager->getClassMetadata(Comment::class)->getFieldNames();

        dump($colonnes);

        $commentsBdd = $repoComment->findAll();

        dump($commentsBdd);
        dump($comment);

        if($comment)
        {
            $id = $comment->getId();
            $auteur = $comment->getAuthor(); 

            $date = $comment->getCreatedAt();
            $dateFormat = $date->format('d/m/Y à H:i:s');
            dump($dateFormat);

            $manager->remove($comment);
            
            $this->addFlash('success', "Le commentaire n°$id posté par l'auteur $auteur le $dateFormat a été supprimé avec succès !");

            return $this->redirectToRoute('admin_comments');
        }

        return $this->render('admin/admin_comments.html.twig', [
            'colonnes' => $colonnes,
            'commentsBdd' => $commentsBdd
        ]);
    }

    /*
     * @Route("/admin/comment/{id}/edit", name="admin_edit_comment")
     */
    public function editComment(Comment $comment, EntityManagerInterface $manager, Request $request): Response
    {
        dump($comment);

        $formComment = $this->createForm(CommentFormType::class, $comment);

        dump($request);

        $formComment->handleRequest($request); 

        if($formComment->isSubmitted() && $formComment->isValid())
        {
            $id = $comment->getId();
            $auteur = $comment->getAuthor();
            $date = $comment->getCreatedAt();
            $dateFormat = $date->format('d/m/Y à H:i:s');

            $manager->persist($comment); 
            $manager->flush(); 

                    $this->addFlash("success", "Le commentaire n°$id posté par $auteur le $dateFormat a été modifié avec succès !");

        }

        return $this->render('admin/admin_edit_comment.html.twig', [
            'formComment' => $formComment->createView()
        ]);
    }

    /**
    
     * @Route("/admin/users", name="admin_users")
     * @Route("/admin/user/{id}/remove", name="admin_remove_user")
     */
    public function adminUsers(EntityManagerInterface $manager, UserRepository $repoUser, User $user = null): Response
    {
   
        $colonnes = $manager->getClassMetadata(User::class)->getFieldNames();

        dump($colonnes);


        $usersBdd = $repoUser->findAll();

        dump($usersBdd);
        dump($user);
        
       
        if($user)
        {
       
            $manager->remove($user);
         
            $manager->flush();

       
            $this->addFlash('success', "L'utilisateur a été supprimé avec succès !");

            return $this->redirectToRoute('admin_users');
        }

        return $this->render('admin/admin_users.html.twig', [
            'colonnes' => $colonnes,
            'usersBdd' => $usersBdd
        ]);
    }

    /**
     * @Route("/admin/user/{id}/edit", name="admin_edit_user")
     */
    public function adminUserEdit(User $user, EntityManagerInterface $manager, Request $request): Response
    {
        dump($user);

        $formUser = $this->createForm(AdminRegistrationFormType::class, $user);

        $formUser->handleRequest($request);

        if($formUser->isSubmitted() && $formUser->isValid())
        {
            $id = $user->getId();
            $username = $user->getUsername();

            $manager->persist($user);
            $manager->flush();

            $this->addFlash('success', "L'utilisateur $username ID$id a été modifié avec succès !");

            return $this->redirectToRoute('admin_users');
        }

        return $this->render('admin/admin_edit_user.html.twig', [
            'formUser' => $formUser->createView()
        ]);
    }
}

