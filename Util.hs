module Util where

-- Functions for dealing with tripple tuples
fst :: (x,y,z) -> x
fst (x,_,_) = x
snd :: (x,y,z) -> y
snd (_,y,_) = y
thd :: (x,y,z) -> z
thd (_,_,z) = z
