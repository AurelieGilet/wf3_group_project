<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;

class RegistrationFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('username', TextType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
            ->add('email', TextType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
            ->add('password', PasswordType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
            ->add('confirm_password', PasswordType::class, [
                'row_attr' => ['class' => 'col-lg-5']
            ])
			->add('save', SubmitType::class, [
				'row_attr' => ['class' => 'col-lg-10 d-flex justify-content-center']
			])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => User::class,
			'validation_groups' => ['registration']
        ]);
    }
}
