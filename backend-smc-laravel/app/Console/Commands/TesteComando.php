<?php

namespace App\Console\Commands;

use App\Http\Service\S3AwsService;
use Illuminate\Console\Command;

class TesteComando extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'teste:comando';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Teste de Comando';

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
        shell_exec('touch teste.txt');
		echo "criei um arquivo";

    }
}
