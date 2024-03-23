<?php

require_once "rcon/rcon.php";
require_once "seamless_world/Config.php";
require_once "seamless_world/Game.php";
require_once "seamless_world/Entity.php";

$config = new Config();

foreach ($config->games as $gameConfig) {
    $res = Rcon::send(
        $gameConfig->port,
        Config::getEnv()['RCON_PWD'],
        '/seamless_world_export',
    );

    $res = explode("\n", $res);
    if ($res[count($res) - 1] == '') {
        unset($res[count($res) - 1]);
    }

    if (!isset($res[0])) {
        continue;
    }

    $mapSettingsRes = explode(',', $res[0]);

    $game = new Game(
        gameConfig: $gameConfig,
        shiftX: intval($mapSettingsRes[0]),
        shiftY: intval($mapSettingsRes[1]),
        mapW: intval($mapSettingsRes[2]),
        mapH: intval($mapSettingsRes[3]),
    );

    $i = 1;
    while ($i < count($res)) {
        $type = $res[$i];
        $posRes = explode(',', $res[$i + 1]);
        $posX = $posRes[0];
        $posY = $posRes[1];
        $invRes = explode(',', $res[$i + 2]);
        $invName = $invRes[0] ?? '';
        $invCount = intval($invRes[1] ?? 0);
        $i += 3;

        $entity = Entity::getInstance($type, $posX, $posY, $invName, $invCount);
        switch ($type) {
            case 'export-chest':
            case 'export-pipe':
            case 'export-accumulator':
                $game->addExportEntity($entity);
                break;
            case 'import-chest':
            case 'import-pipe':
            case 'import-accumulator':
                $game->addImportEntity($entity);
                break;
        }
    }

    $games[] = $game;
}

$gamesForImport = [];
foreach ($games as $gameForExport) {
    foreach ($gameForExport->exportEntities as $exportEntity) {
        $exportPosX = $exportEntity->getLongShiftedPosX();
        $exportPosY = $exportEntity->getLongShiftedPosY();

        foreach ($games as $gameForImport) {
            foreach ($gameForImport->importEntities as $importEntity) {
                if (!$exportEntity->compatible($importEntity)) {
                    continue;
                }

                $importPosX = $importEntity->getShiftedPosX();
                $importPosY = $importEntity->getShiftedPosY();

                if (
                    $exportPosX == $importPosX &&
                    $exportPosY == $importPosY
                ) {
                    $key = sprintf('%s-%s', $gameForImport->shiftX, $gameForImport->shiftY);
                    if (!isset($gamesForImport[$key])) {
                        $gamesForImport[$key] = [
                            'game' => $gameForImport,
                            'links' => [],
                        ];
                    }
                    $gamesForImport[$key]['links'][] = [
                        'exportEntity' => $exportEntity,
                        'importEntity' => $importEntity,
                    ];
                }
            }
        }
    }
}

foreach ($gamesForImport as $gameFormImport) {
    foreach ($gameFormImport['links'] as $link) {
        $params[] = $link['importEntity']->type;
        $params[] = $link['importEntity']->posX;
        $params[] = $link['importEntity']->posY;
        $params[] = $link['exportEntity']->invName;
        $params[] = $link['exportEntity']->invCount;
    }

    Rcon::send(
        $gameFormImport['game']->gameConfig->port,
        Config::getEnv()['RCON_PWD'],
        '/seamless_world_import',
        $params ?? [],
    );
}
