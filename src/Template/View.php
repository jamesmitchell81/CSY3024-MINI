<?php

namespace MINI\Template;

interface View
{
  public function render($template, $data = []);
}