<?php

namespace App\DataFixtures;

use App\Entity\Budget;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\Persistence\ObjectManager;

class BudgetFixtures extends Fixture
{

    public function load(ObjectManager $manager): void
    {
        for($i = 1; $i <= 10; $i++){
            $budget = new Budget();
            $budget->setName('budget n°'.$i);
            $budget->setDetail('budget n°'.$i);
            $budget->setBalance(0+$i);
            $budget->setCurrency("€");
            $date = new \DateTimeImmutable('now');
            $date = $date->modify('-'.$i.'days');
            $budget->setCreatedAt($date);
            $budget->setUpdatedAt(null);
            $budget->setIsActive(true);

            $manager->persist($budget);
        }


        $manager->flush();

        $manager->flush();
    }
}
