<?php

namespace App\Http\Service;

class GraphqlsettingsService
{
    function findBy()
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
            CURLOPT_POSTFIELDS => "{\"query\":\"query findBy {\\n  smc_settings(order_by: {id: asc}) {\\n    id\\n    description\\n    key\\n    value\\n    content\\n  }\\n}\"}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
                "x-hasura-admin-secret: " . $pass
            ],
        ]);
        $response = curl_exec($curl);
        curl_close($curl);
        $dados = json_decode($response, true);
        return $dados["data"]["smc_settings"];
    }

}

