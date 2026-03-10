<?php

namespace App\Controller;

use App\Repository\BudgetRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/budget', name: 'app_budget_')]
final class BudgetController extends AbstractController
{
    public function __construct(private EntityManagerInterface $manager, private BudgetRepository $budgetRepository){

    }

#[Route('/', name: 'list', methods: ['GET'])]
    public function index(Request $request): Response{
        $budgets = $this->budgetRepository->findAll();
        return $this->render('budget/index.html.twig', [
            'controller_name' => 'BudgetController',
            'budgets' => $budgets,
        ]);
    }

    #[Route('/create', name: 'create')]
    public function create(): Response{

        return $this->render('budget/create.html.twig');
    }

    #[Route('/{id}', name: 'show', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function show($id): Response{
            $budget = $this->budgetRepository->find($id);
            dd($budget);

          return $this->render('budget/show.html.twig', [
            'controller_name' => 'BudgetController',
            'id' => $id,
        ]);
    }

    #[Route('/{id}/edit', name: 'edit')]
    public function edit($id): Response{
        return $this->render('budget/edit.html.twig', [

        ]);
    }

    #[Route('/{id}', name: 'delete')]
    public function delete($id): void{

    }


}
