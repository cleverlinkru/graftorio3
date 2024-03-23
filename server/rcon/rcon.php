<?php

class Rcon
{
    public static function send(string $rcon_port, string $rcon_pwd, string $command, array $params = [])
    {
        return shell_exec(sprintf(
            "python3 ./rcon/script.py %s %s %s %s",
            $rcon_port,
            $rcon_pwd,
            $command,
            implode(',', $params)
        ));
    }
}
