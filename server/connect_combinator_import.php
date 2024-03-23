<?php

require_once "rcon/rcon.php";
$env = parse_ini_file('../.env');

Rcon::send(
    $_GET['port'],
    $env['RCON_PWD'],
    '/connect_combinator_import',
    [$_GET['combinator_key'], $_GET['signal_type'], $_GET['signal_name'], $_GET['count']],
);
