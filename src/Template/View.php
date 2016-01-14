<?php

namespace MINI\Template;

// Reference
// https://github.com/PatrickLouys/no-framework-tutorial

interface View
{
  public function render($template, $data = []);
}