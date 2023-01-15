<?php


namespace App\Http\Library;


class ManipularDatasLibrary
{

    function getRetornaDataAtual()
    {
        date_default_timezone_set('America/Sao_Paulo');

        return date('Y-m-d');
    }

    function getRetornaDiasDiferenca($data)
    {
        date_default_timezone_set('America/Sao_Paulo');
        $hoje = date('Y-m-d');

        if ($data >= $hoje) { return 0;}

        // converte as datas para o formato timestamp
        $d1 = strtotime($hoje);
        $d2 = strtotime($data);

        // verifica a diferença em segundos entre as duas datas e divide pelo número de segundos que um dia possui
        $dataFinal = ($d1 - $d2) /86400;

        // caso a data 2 seja menor que a data 1
        $dataFinal < 0 ? $dataFinal : ($dataFinal * -1);
        return $dataFinal;
    }

}
