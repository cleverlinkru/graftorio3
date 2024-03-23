<?php

require_once 'GameConfig.php';

class Game
{
    public array $exportEntities = [];

    public array $importEntities = [];

    public int $maxX;

    public int $minX;

    public int $maxY;

    public int $minY;

    public function __construct(
        public GameConfig $gameConfig,
        public int $shiftX,
        public int $shiftY,
        public int $mapW,
        public int $mapH,
    ) {
        $this->maxX = floor($this->mapW / 2) - 1;
        $this->minX = -ceil($this->mapW / 2);
        $this->maxY = floor($this->mapH / 2) - 1;
        $this->minY = -ceil($this->mapH / 2);
    }

    public function addExportEntity(Entity $entity)
    {
        $entity->setGame($this);
        if ($entity->isOnBorder() && $entity->invCount) {
            $this->exportEntities[] = $entity;
        }
    }

    public function addImportEntity(Entity $entity)
    {
        $entity->setGame($this);
        if ($entity->isOnBorder()) {
            $this->importEntities[] = $entity;
        }
    }
}
