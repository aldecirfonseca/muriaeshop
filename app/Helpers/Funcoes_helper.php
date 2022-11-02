<?php

function formatValor($valor, $decimais = 2)
{
    return number_format($valor, $decimais, ",", ".");
}
