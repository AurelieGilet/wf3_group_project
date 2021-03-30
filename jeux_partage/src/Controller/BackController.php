<?php

namespace App\Controller;

use App\Entity\Game;
use App\Entity\User;
use App\Entity\Category;
use App\Entity\Borrowing;
use App\Form\GameFormType;
use App\Form\CategoryFormType;
use Doctrine\ORM\EntityManager;
use App\Repository\GameRepository;
use App\Repository\UserRepository;
use App\Repository\CategoryRepository;
use App\Form\AdminRegistrationFormType;
use App\Form\BorrowingFormType;
use App\Repository\BorrowingRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface;

class BackController extends AbstractController
{
    /**
     * @Route("/admin", name="admin")
     */
    public function index(AuthorizationCheckerInterface $authChecker): Response
    {
        return $this->render('back/index.html.twig');
    }

                // *************** GESTION USERS *******************
    /**
     * @Route("/admin/utilisateurs", name="admin_users")
     * @Route("/admin/utilisateur/{id}/suppression", name="admin_delete_user")
     */
    public function adminUsers(UserRepository $repoUsers, BorrowingRepository $borrowingRepo, GameRepository $gameRepo, EntityManagerInterface $manager, User $user = null): Response
    {
        $columns = $manager->getClassMetadata(User::class)->getFieldNames();

        $users = $repoUsers->findBy(array("isArchived" => false));

        $borrowings = $borrowingRepo->findBy(['returnDate' => NULL]);

		$borrowedGamesLenderId= array();
		foreach ($borrowings as $key => $value) {
			array_push($borrowedGamesLenderId, $value->getLender()->getId());
		}
		$borrowedGamesBorrowerId= array();
		foreach ($borrowings as $key => $value) {
			array_push($borrowedGamesBorrowerId, $value->getBorrower()->getId());
		}
		
        if($user != null)
        {
			$userName = $user->getUsername();
			$userId = $user->getId();
			if(in_array($userId, $borrowedGamesLenderId))
			{
				$this->addFlash("danger", "Impossible de supprimer le membre $userName : il a un prêt en cours");
			}
            elseif(in_array($userId, $borrowedGamesBorrowerId))
			{
				$this->addFlash("danger", "Impossible de supprimer le membre $userName : il a un emprunt en cours");
			}
			else
			{
				$games = $gameRepo->findBy(['owner' => $user]);

				foreach ($games as $key => $game) {
					$game->setIsArchived(true);
					$manager->persist($game);
                	$manager->flush();
				}

                $user->setIsArchived(true);
                $user->setEmail("deleted@mail.com");
				$manager->persist($user);
                $manager->flush();
    
				$this->addFlash("success", "Le membre $userName a bien été supprimé");
			}

            return $this->redirectToRoute("admin_users");
        }

        return $this->render("back/admin_users.html.twig", [
            "columns" => $columns,
            "users" => $users
        ]);
    }

    
    /**
     * @Route("/admin/utilisateur/{id}/modification", name="admin_edit_user")
     */
    public function editUser(Request $request, EntityManagerInterface $manager, User $user): Response
    {
        $formUser = $this->createForm(AdminRegistrationFormType::class, $user);
        
        $formUser->handleRequest($request);

        if($formUser->isSubmitted() && $formUser->isValid())
        {
            $manager->persist($user);
            $manager->flush();

            $this->addFlash("success", "Le membre " . $user->getUsername() . " a bien été modifié");

            return $this->redirectToRoute("admin_users");
        }

        return $this->render("back/admin_edit_user.html.twig", [
            "formUser" => $formUser->createView(),
            "user" => $user
        ]);
    }

    
                // *************** GESTION GAMES *******************
    /**
     * @Route("/admin/jeux", name="admin_games")
     * @Route("/admin/jeu/{id}/suppression", name="admin_delete_game")
     */

    public function adminGames(GameRepository $repoGames, BorrowingRepository $borrowingRepo, EntityManagerInterface $manager, Game $game = null): Response
    {
        $columns = $manager->getClassMetadata(Game::class)->getFieldNames();

        $games = $repoGames->findBy(array("isArchived" => false));

		$borrowings = $borrowingRepo->findBy(['returnDate' => NULL]);

		$borrowedGamesId= array();
		foreach ($borrowings as $key => $value) {
			array_push($borrowedGamesId, $value->getGame()->getId());
		}
		
        if($game != null)
        {
			$gameName = $game->getName();
			$gameId = $game->getId();
			if(in_array($gameId, $borrowedGamesId))
			{
				$this->addFlash("danger", "Impossible de supprimer le jeu $gameName : il est emprunté");
			}
			else
			{
				$game->setIsArchived(true);
				$manager->persist($game);
                $manager->flush();
    
				$this->addFlash("success", "Le jeu $gameName a bien été supprimé");
			}

            return $this->redirectToRoute("admin_games");
        }

        return $this->render("back/admin_games.html.twig", [
            "columns" => $columns,
            "games" => $games
        ]);
    }

    
    /**
     * @Route("/admin/jeu/{id}/modification", name="admin_edit_game")
     */
    public function editGame(Request $request, SluggerInterface $slugger, EntityManagerInterface $manager, Game $game): Response
    {
        $formGame = $this->createForm(GameFormType::class, $game);
        
        $formGame->handleRequest($request);

        if($formGame->isSubmitted() && $formGame->isValid())
        {
            /** @var UploadedFile $imageFile */
			$imageFile = $formGame->get('image')->getData();

			if($imageFile)
			{
				$gameName = $game->getName();
				$safeFilename = $slugger->slug($gameName);
				$filename = $safeFilename.'-'.uniqid().'-'.$imageFile->guessExtension();
				try {
					$imageFile->move(
						$this->getParameter('images_directory'),
						$filename
					);
				} catch (FileException $e) {
					
				}
				$game->setImage($filename);
			}

            $manager->persist($game);
            $manager->flush();

            $this->addFlash("success", "Le jeu " . $game->getName() . " a bien été modifié");

            return $this->redirectToRoute("admin_games");
        }

        return $this->render("back/admin_edit_game.html.twig", [
            "formGame" => $formGame->createView(),
            "game" => $game
        ]);
    }


                // ************* GESTION CATEGORIES *****************
    /**
     * @Route("/admin/categories", name="admin_categories")
     * @Route("/admin/categorie/{id}/suppression", name="admin_delete_category")
     */
    public function adminCategory(EntityManagerInterface $manager, CategoryRepository $repoCategory, Category $category = null): Response
    {
        $columns = $manager->getClassMetadata(Category::class)->getFieldNames();
        if($category)
        {
            $categoryName = $category->getName();
            if($category->getGames()->isEmpty())
            {
                $manager->remove($category);
                $manager->flush();

                $this->addFlash('success', "La catégorie $categoryName a bien été supprimée");

                return $this->redirectToRoute('admin_categories');
            }
            else
            {
                $this->addFlash('danger', "Impossible de supprimer la catégorie $categoryName : des jeux lui sont associés");

                return $this->redirectToRoute('admin_categories');
            }
                        
        }

        $categories = $repoCategory->findAll();

        return $this->render('back/admin_categories.html.twig',[
            'columns'=> $columns,
            'categories' => $categories
        ]);
    }

    /**
     * @Route("/admin/categorie/new", name="admin_new_category")
     */
    public function adminFormCategory(Request $request, EntityManagerInterface $manager, Category $category = null): Response
    {
        if(!$category)
        {
            $category = new Category;
        }

        $formCategory = $this->createForm(CategoryFormType::class, $category);

        $formCategory->handleRequest($request);

        if($formCategory->isSubmitted() && $formCategory->isValid())
        {
            if(!$category->getId())
			{
				$message = "La catégorie " . $category->getName() . " a bien été enregistrée ";
			}
                
            $this->addFlash('success', $message);

            return $this->redirectToRoute('admin_categories');
        }

        return $this->render('back/admin_form_category.html.twig', [
                'formCategory' => $formCategory->createView()
        ]);
    }

    /**
     * @Route("/admin/categorie/{id}/modification", name="admin_edit_category")
     * 
     */
    public function adminEditCategory(Request $request, EntityManagerInterface $manager, Category $category): Response
    {
        $formCategory = $this->createForm(CategoryFormType::class, $category);
        
        $formCategory->handleRequest($request);

        if($formCategory->isSubmitted() && $formCategory->isValid())
        {
            $manager->persist($category);
            $manager->flush();

            $this->addFlash("success", "La catégorie " . $category->getName() . " a bien été modifié");

            return $this->redirectToRoute("admin_categories");
        }

        return $this->render("back/admin_edit_category.html.twig", [
            "formCategory" => $formCategory->createView(),
            "category" => $category
        ]);
    }


                // ************* GESTION EMPRUNTS *****************

    /**
     * @Route("/admin/emprunts", name="admin_borrowings")
     */
    public function adminBorrowing(EntityManagerInterface $manager, BorrowingRepository $repoBorrowing, Borrowing $borrowing = null):Response
    {
        $schemaManager = $manager->getConnection()->getSchemaManager();
        // array of Doctrine\DBAL\Schema\Column
        $columns = $schemaManager->listTableColumns('borrowing');

        $columnNames = [];
        foreach($columns as $column)
        {
        	$columnNames[] = $column->getName();
        }

		$borrowings = $repoBorrowing->findAll();

		return $this->render('back/admin_borrowings.html.twig', [
            'columns' => $columnNames,
            'borrowings' => $borrowings
        ]);
    }
}
