<?php

require_once 'Config.php';

class GameConfig
{
    public $port;

    public function __construct(array $gameConfig)
    {
        $this->port = intval(Config::getEnv()[$gameConfig['port']]);
    }
}
