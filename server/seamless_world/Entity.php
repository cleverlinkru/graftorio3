<?php

require_once 'Game.php';
require_once 'Accumulator.php';

class Entity
{
    public static function getInstance(
        string $type,
        int $posX,
        int $posY,
        string $invName = '',
        int $invCount = 0,
    ): self {
        switch ($type) {
            case 'export-accumulator':
            case 'import-accumulator':
                return new Accumulator($type, $posX, $posY, $invName, $invCount);
        }
        return new self($type, $posX, $posY, $invName, $invCount);
    }

    public function setGame(Game $game)
    {
        $this->game = $game;
    }

    public function isOnBorder(): bool
    {
        return $this->isOnBorderByX() || $this->isOnBorderByY();
    }

    public function isOnBorderByX(): bool
    {
        if (!$this->game) {
            return false;
        }

        return $this->posX == $this->game->maxX || $this->posX == $this->game->minX;
    }

    public function isOnBorderByY(): bool
    {
        if (!$this->game) {
            return false;
        }

        return $this->posY == $this->game->maxY || $this->posY == $this->game->minY;
    }

    public function getShiftedPosX(): int
    {
        if (!$this->game) {
            return $this->posX;
        }

        return $this->posX + $this->game->shiftX * $this->game->mapW;
    }

    public function getShiftedPosY(): int
    {
        if (!$this->game) {
            return $this->posY;
        }

        return $this->posY + $this->game->shiftY * $this->game->mapH;
    }

    public function getLongShiftedPosX(): int
    {
        if (!$this->game) {
            return $this->posX;
        }

        $res = $this->getShiftedPosX();
        if ($this->isOnBorderByX()) {
            if ($this->posX < 0) {
                $res -= 1;
            } else {
                $res += 1;
            }
        }

        return $res;
    }

    public function getLongShiftedPosY(): int
    {
        if (!$this->game) {
            return $this->posY;
        }

        $res = $this->getShiftedPosY();
        if ($this->isOnBorderByY()) {
            if ($this->posY < 0) {
                $res -= 1;
            } else {
                $res += 1;
            }
        }

        return $res;
    }

    public function compatible(Entity $entity): bool
    {
        $type1 = $this->type;
        $type2 = $entity->type;

        return (
            $type1 == 'export-chest' && $type2 == 'import-chest'||
            $type1 == 'import-chest' && $type2 == 'export-chest' ||
            $type1 == 'export-pipe' && $type2 == 'import-pipe'||
            $type1 == 'import-pipe' && $type2 == 'export-pipe' ||
            $type1 == 'export-accumulator' && $type2 == 'import-accumulator'||
            $type1 == 'import-accumulator' && $type2 == 'export-accumulator'
        );
    }

    protected ?Game $game = null;

    protected function __construct(
        public string $type,
        public int $posX,
        public int $posY,
        public string $invName = '',
        public int $invCount = 0,
    ) {
    }
}
