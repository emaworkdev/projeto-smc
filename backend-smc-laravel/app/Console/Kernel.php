<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        //
    ];

    protected function scheduleTimezone()
    {
        return 'America/Sao_Paulo';
    }

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     *
            everyMinute() -> 1 minutos
            everyFiveMinutes() -> 5 minutos
            everyTenMinutes() -> 10 minutos
            everyFifTenMinutes() -> 15 minutos
            everyThirtyMinutes() -> 30 minutos
            hourly() -> 1 hora
     *
     */
    protected function schedule(Schedule $schedule)
    {

        //$schedule->command('teste:comando')->everyMinute();
        $schedule->command('disparos:smc')->everyMinute();
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
