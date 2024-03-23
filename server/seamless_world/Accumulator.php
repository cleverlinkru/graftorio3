<?php

require_once "Entity.php";

class Accumulator extends Entity
{
    public function isOnBorderByX(): bool
    {
        if (!$this->game) {
            return false;
        }

        return $this->posX == $this->game->maxX || $this->posX == $this->game->minX + 1;
    }

    public function isOnBorderByY(): bool
    {
        if (!$this->game) {
            return false;
        }

        return $this->posY == $this->game->maxY || $this->posY == $this->game->minY + 1;
    }

    public function getLongShiftedPosX(): int
    {
        if (!$this->game) {
            return $this->posX;
        }

        $res = $this->getShiftedPosX();
        if ($this->isOnBorderByX()) {
            if ($this->posX < 0) {
                $res -= 2;
            } else {
                $res += 2;
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
                $res -= 2;
            } else {
                $res += 2;
            }
        }

        return $res;
    }
}
