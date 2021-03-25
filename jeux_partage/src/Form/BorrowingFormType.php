<?php

namespace App\Form;

use App\Entity\Borrowing;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class BorrowingFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            // ->add('startDate', DateType::class, [
            //     'row_attr' => ['class' => 'col-lg-3']
			// ])
			->add('save', SubmitType::class, [
				'row_attr' => ['class' => 'col-lg-3 text-center']
			])
            // ->add('endDate')
            // ->add('returnDate')
            // ->add('lender')
            // ->add('borrower')
            // ->add('game')
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Borrowing::class,
        ]);
    }
}
