<?php

namespace MINI\Template;

use Twig_Environment;

class TwigRenderer implements View
{
  private $engine;

  public function __construct(Twig_Environment $engine)
  {
    $this->engine = $engine;
  }

  public function render($template, $data = [])
  {
    return $this->engine->render("$template.html", $data);
  }

}