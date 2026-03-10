<?php

namespace App\Twig\Runtime;

use Twig\Extension\RuntimeExtensionInterface;
use Twig\TwigFilter;

class AppExtensionRuntime implements RuntimeExtensionInterface
{
    public function __construct()
    {
        // Inject dependencies if needed
    }

    public function doSomething($value)
    {
    }

    public static function getLength(array $table): string
    {
        return "le tableau posséde " . count($table) ." articles";
    }

    public static function somme(int $nb1, int $nb2) : string
    {
        return $nb1 + $nb2;
    }
}
