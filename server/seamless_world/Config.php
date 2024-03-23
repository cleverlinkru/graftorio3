<?php

require_once 'GameConfig.php';

class Config
{
    public $games = [];

    public static function getConfig(): array
    {
        if (self::$config === null) {
            self::$config = require_once "config/seamless_world.php";
        }
        return self::$config;
    }

    public static function getEnv(): array
    {
        if (self::$env === null) {
            self::$env = parse_ini_file('../.env');
        }
        return self::$env;
    }

    public function __construct()
    {
        foreach (self::getConfig() as $gameConfig) {
            $this->games[] = new GameConfig($gameConfig);
        }
    }

    private static $config = null;

    private static $env = null;
}
