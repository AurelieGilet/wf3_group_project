<?php

namespace App\Form;

use App\Entity\Category;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class CategoryFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name', TextType::class, [
                'row_attr' => ['class' => 'col-10 col-sm-7 col-md-5 col-xl-4 col-xxl-2']
            ])
			->add('save', SubmitType::class, [
				'row_attr' => ['class' => 'col-md-12 d-flex justify-content-center']
			])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Category::class,
			'validation_groups' => ['category_registration']
        ]);
    }
}
