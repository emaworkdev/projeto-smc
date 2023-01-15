<?php

namespace App\Console\Commands;

use App\Http\Library\ManipularDatasLibrary;
use App\Http\Service\Empresa01Service;
use App\Http\Service\GraphqlShotsService;
use Exception;
use Illuminate\Console\Command;

class DisparosComando extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'disparos:smc';

    /**
     * The console command description.

     * @var string
     */
    protected $description = 'disparos maturação de chip';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        try {
            $dataF = new ManipularDatasLibrary();
            $graphShot = new GraphqlShotsService();
            $empresa = new Empresa01Service();

            $shots = $graphShot->findControl();

            if (isset($shots)) {
                if ($shots != []) {
                    foreach ($shots as $obj) {
                        //Verifica se a data de hoje é maior que a data de finalização dos disparos
                        if ($dataF->getRetornaDiasDiferenca($obj['datefinalize']) == 0) {
                            //continua
                            $empresa->processar($obj);
                        } else {
                            //finaliza Disparos
                            $ret1 = $graphShot->updateControlTrue($obj['id']);
                            $ret2 = $graphShot->updateFinaliza($obj['id']);
                        }
                    }
                }
            }
        } catch (Exception $e) {
            echo 'Exceção capturada: ',  $e->getMessage(), "\n";
        }
    }
}
