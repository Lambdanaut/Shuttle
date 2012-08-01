module Mechanics where

type Pos = (Int,Int)

data Dir = N | NE | E | SE | S | SW | W | NW deriving (Show, Read, Enum, Ord, Eq)

all_directions = [N ..]

dir_pos :: Dir -> (Int, Int)
dir_pos dir = case dir of
	N  -> (0,-1)
	NE -> (1,-1)
	E  -> (1,0)
	SE -> (1,1)
	S  -> (0,1)
	SW -> (-1,1)
	W  -> (-1,0)
	NW -> (-1,-1)
