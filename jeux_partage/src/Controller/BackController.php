<?php

namespace App\Controller;

use App\Entity\Category;
use App\Form\CategoryFormType;
use App\Repository\CategoryRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

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

    /**
     * 
     * @Route("/back/categories", name="admin_category")
     * @Route("/back/category/{id}/remove", name="back_remove_category")
     */
    public function backCategory(EntityManagerInterface $manager, CategoryRepository $repoCategory, Category $category = null): Response
    {
        $colonnes = $manager->getClassMetadata(Category::class)->getFieldNames();
        if($category)
        {

            if($category->getGames()->isEmpty())
            {
                $manager->remove($category);
                $manager->flush();

                $this->addFlash('success', "La catégorie a bien été supprimé");
            }
            else
            {
                $this->addFlash('danger', "Impossible de supprimer la catégorie des jeux lui sont associés");
                
            }
            
            return $this->redirectToRoute('admin_category');
        }

            $category = $repoCategory->findAll();

            //dump($category);

            return $this->render('back/admin_category.html.twig',[
                'colonnes'=> $colonnes,
                'categorieBdd' => $category

        ]);
    }

    /**
     * 
     * @Route("/back/category/{id}/edit", name="back_edit_catgory")
     */
    public function backFormCategory(Request $request, EntityManagerInterface $manager, Category $category = null): Response
    {
        if(!$category)
        {
            $category = new Category;
        }

        $formCategory = $this->createForm(CategoryFormType::class, $category);


         $formCategory->handleRequest($request);

        return $this->render('back/back_form_category.html.twig');
    }
}
