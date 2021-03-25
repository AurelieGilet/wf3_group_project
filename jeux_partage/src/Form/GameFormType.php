<?php

namespace App\Form;

use App\Entity\Game;
use App\Entity\Category;
use App\Repository\GameRepository;
use App\Repository\CategoryRepository;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Validator\Constraints\File;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;

class GameFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('category', EntityType::class, [
				'class' => Category::class, 
				'choice_label' => 'name'
			])
			
			// ->add('category', ChoiceType::class, [
			// 	'choices' => [
			// 		'Adresse' => 'adresse',
			// 		'Cartes' => 'cartes',
			// 		'Connaissance' => 'connaissance',
			// 		'Coopération' => 'cooperation',
			// 		'Dés' => 'des',
			// 		'Lettres' => 'lettres',
			// 		'Logique' => 'logique',
			// 		'Statégie' => 'strategie',
			// 	],

			// ])

			->add('public', ChoiceType::class, [
				'choices' => [
					'6 ans et +' => '6+',
					'8 ans et +' => '8+',
					'10 ans et +' => '10+',
					'12 ans et +' => '12+',
				],

			])
            ->add('minPlayers')
            ->add('maxPlayers', IntegerType::class, [
				'required' => false
			])
            ->add('description')
			->add('image', FileType::class, [
				'label' => "Photo du jeu",
				'mapped' => false, 
				'required' => false, 
				'data_class' => null,
				'constraints' => [ 
					new File([
						'maxSize' => '2M',
						'mimeTypes' => [
							'image/jpeg',
							'image/png',
							'image/jpg',
						],
						'mimeTypesMessage' => "Types de fichiers acceptés : jpg, jpeg et png"
					])
				]
			])
            // ->add('owner')
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Game::class,
			'validation_groups' => ['game_registration']
        ]);
    }
}
