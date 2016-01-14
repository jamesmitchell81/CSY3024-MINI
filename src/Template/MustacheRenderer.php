<?php

namespace MINI\Template;

// Reference
// https://github.com/PatrickLouys/no-framework-tutorial

use Mustache_Engine;

class MustacheRenderer implements View
{
    private $engine;

    public function __construct(Mustache_Engine $engine)
    {
        $this->engine = $engine;
    }

    public function render($template, $data = [])
    {
        return $this->engine->render($template, $data);
    }
}