<?php


namespace App\Http\Service;

class GraphqlShotsService
{

    function find($id)
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
            CURLOPT_POSTFIELDS => "{\"query\":\"query Find {\\n  smc_shots(where: {id: {_eq: $id}, start: {_eq: true}, finished: {_eq: false}}) {\\n    start\\n  }\\n}\\n\"}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
                "x-hasura-admin-secret: " . $pass
            ],
        ]);
        $response = curl_exec($curl);
        curl_close($curl);
        $dados = json_decode($response, true);
       if ($dados["data"]["smc_shots"] == []){
           return 0;
       }
        return $dados["data"]["smc_shots"][0]['start'];
    }

    function findControl()
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
            CURLOPT_POSTFIELDS => "{\"query\":\"query Find {\\n  smc_shots(where: {start: {_eq: true}, finished: {_eq: false}, control: {_eq: false}}) {\\n   alvo\\n    client\\n    control\\n    createdAt\\n    datefinalize\\n    datestart\\n    finished\\n    id\\n    name\\n    namecli\\n    start\\n  }\\n}\\n\"}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
                "x-hasura-admin-secret: " . $pass
            ],
        ]);

        $response = curl_exec($curl);
        curl_close($curl);
        $dados = json_decode($response, true);
        return $dados["data"]["smc_shots"];
    }

    function updateControlFalse($id) {

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
            CURLOPT_POSTFIELDS => "{\"query\":\"mutation Short {\\n  update_smc_shots(where: {id: {_eq: $id}}, _set: {control: false}) {\\n    affected_rows\\n\\t\\treturning {\\n      id\\n    }\\n  }\\n}\"}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
                "x-hasura-admin-secret: " . $pass
            ],
        ]);

        $response = curl_exec($curl);
        //dd($response);
        curl_close($curl);
        $dados = json_decode($response, true);
        return $dados["data"]["update_smc_shots"]["returning"][0]['id'];
    }

    function updateControlTrue($id) {

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
            CURLOPT_POSTFIELDS => "{\"query\":\"mutation Short {\\n  update_smc_shots(where: {id: {_eq: $id}}, _set: {control: true}) {\\n    affected_rows\\n\\t\\treturning {\\n      id\\n    }\\n  }\\n}\"}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
                "x-hasura-admin-secret: " . $pass
            ],
        ]);

        $response = curl_exec($curl);
        //dd($response);
        curl_close($curl);
        $dados = json_decode($response, true);
        return $dados["data"]["update_smc_shots"]["returning"][0]['id'];
    }

    function updateFinaliza($id) {

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
            CURLOPT_POSTFIELDS => "{\"query\":\"mutation Short {\\n  update_smc_shots(where: {id: {_eq: $id}}, _set: {finished: true}) {\\n    affected_rows\\n\\t\\treturning {\\n      id\\n    }\\n  }\\n}\"}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
                "x-hasura-admin-secret: " . $pass
            ],
        ]);

        $response = curl_exec($curl);
        //dd($response);
        curl_close($curl);
        $dados = json_decode($response, true);
        return $dados["data"]["update_smc_shots"]["returning"][0]['id'];
    }

}

