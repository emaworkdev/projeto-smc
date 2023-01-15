<?php

namespace App\Http\Service;

class GraphqlWhatsappsService
{
    function findBy($padrao)
    {
        $url = env('API_HASURA');
        $pass = env('API_HASURA_CREDENCY');

        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => "{\"query\":\"query FindBy {\\n  smc_whatsapps(where: {isDefault: {_eq: $padrao}}) {\\n    id\\n    isDefault\\n    name\\n    session\\n    token\\n  number\\n  }\\n}\"}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
                "x-hasura-admin-secret: " . $pass
            ],
        ]);
        $response = curl_exec($curl);
        curl_close($curl);
        $dados = json_decode($response, true);
        return $dados["data"]["smc_whatsapps"];
    }

    function findByGeral()
    {
        $url = env('API_HASURA');
        $pass = env('API_HASURA_CREDENCY');

        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => "{\"query\":\"query FindGeral {\\n  smc_whatsapps {\\n    id\\n    isDefault\\n    name\\n    session\\n   token\\n  number\\n  }\\n}\"}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
                "x-hasura-admin-secret: " . $pass
            ],
        ]);
        $response = curl_exec($curl);
        curl_close($curl);
        $dados = json_decode($response, true);
        return $dados["data"]["smc_whatsapps"];
    }

}

