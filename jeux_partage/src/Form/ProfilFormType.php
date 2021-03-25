<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;

class ProfilFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('username', TextType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
            ->add('firstname', TextType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
            ->add('lastname', TextType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
            ->add('address', TextType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
            ->add('zipcode', TextType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
            ->add('city', TextType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => User::class,
			'validation_groups' => ['profil']
        ]);
    }
}
