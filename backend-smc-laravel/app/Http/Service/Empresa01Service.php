<?php

namespace App\Http\Service;

use App\Http\Library\FunctionsLibrary;

class Empresa01Service
{
    function processar($shot)
    {
        $graphShot = new GraphqlShotsService();
        $graphQuestion = new GraphqlQuestionsService();
        $graphSetting = new GraphqlsettingsService();
        $graphWhats = new GraphqlWhatsappsService();
        $http = new ClienteHttp();
        $funcao = new FunctionsLibrary();
        $respostas = $funcao->getRespostas();
        $total = count($respostas);
        $api1 = env('API_WPP');
        $api2 = env('API_WPP');

        $tmon = 60;
        $tmoff = 60;
        $p1 = 1;
        $p2 = 1;

        $settings = $graphSetting->findBy();

        if (isset($settings)) {
            foreach ($settings as $obj) {
                 if ($obj['key'] == "timeOn") {
                      if ($obj['value'] == true) {
                          $tmon = intval($obj['content']);
                          $p1 = ($tmon / $tmon);
                      }
                 }
                 if ($obj['key'] == "timeOff") {
                      if ($obj['value'] == true) {
                          $tmoff = intval($obj['content']);
                          $p2 = ($tmoff / $tmon);
                      }
                }
            }
        }

                //Pega a sessao alvo
                $whats = $graphWhats->findByGeral();

                if (isset($whats)) {
                    foreach ($whats as $obj) {
                        if ($obj['isDefault'] == true) {
                            $sessao01 = $obj['session'];
                            $token01 = $obj['token'];
                            $number01 = '55' . $obj['number'];
                        }
                        if ($obj['isDefault'] == false) {
                            $sessao02 = $obj['session'];
                            $token02 = $obj['token'];
                            $number02 = '55' . $obj['number'];
                        }
                    }

                    $url01 = $api1 . '/' . $sessao01 . '/send-message';
                    $url02 = $api2 . '/' . $sessao02 . '/send-message';

                    $questions = $graphQuestion->findAll();

                    if (isset($questions)) {
                        $graphShot->updateControlTrue($shot['id']);
                        $qt = 0;
                        foreach ($questions as $obj) {
                            $qt++;
                            //Vai verificar se o shots ainda está habilitado
                            $sh = $graphShot->find($shot['id']);
                            if ($sh == 0) {
                                break;
                            }
                            //envia whats
                            $message = [
                                "phone" => $number01,
                                "message" => $obj['name'],
                                "isGroup" => false
                            ];
                            $http->enviarPostWpp($url02, $token02, $message);

                            if (($obj['id'] % 2)) {
                                $it = $funcao->getRandomic(1, 6);
                                $ii = $it*10;
                                sleep($ii);
                                // pegar respostas para o whatsapp
                                $ponteiro = $funcao->getRandomic(1, $total);
                                //resp whats
                                $resp = [
                                    "phone" => $number02,
                                    "message" => $respostas[$ponteiro],
                                    "isGroup" => false
                                ];
                                $http->enviarPostWpp($url01, $token01, $resp);
                            }
                            $tt = $funcao->getRandomic($p1, $p2);
                            $tempo = $funcao->getSegundos($tt);
                            sleep($tempo);
                        }
                        $graphShot->updateControlFalse($shot['id']);
                    }
                }


    }
}


