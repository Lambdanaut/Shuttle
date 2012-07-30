module Mechanics where

type Pos = (Int,Int)

data Dir = N | NE | E | SE | S | SW | W | NW deriving (Show, Read, Enum, Ord, Eq)

all_directions = [N ..]
