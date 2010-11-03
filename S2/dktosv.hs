
module DkToSv where

import Char

class DanishNumWord w where
    value :: w -> Int

data En2Ni = En |
             Et | 
             To |
             Tre |
             Fire |
             Fem |
             Seks |
             Syv |
             Otte |
             Ni deriving Show

instance DanishNumWord En2Ni where
    value En = 1
    value Et = 1
    value To = 2
    value Tre = 3
    value Fire = 4
    value Fem = 5
    value Seks = 6
    value Syv = 7
    value Otte = 8
    value Ni = 9

data Ti2Nitten = Ti |
                 Ellve |
                 Tolv |
                 Tretten |
                 Fjorten |
                 Femten |
                 Seksten |
                 Sytten |
                 Otten |
                 Nitten deriving Show

instance DanishNumWord Ti2Nitten where
    value Ti = 10
    value Ellve = 11
    value Tolv = 12
    value Tretten = 13
    value Fjorten = 14
    value Femten = 15
    value Seksten = 16
    value Sytten = 17
    value Otten = 18
    value Nitten = 19

data Tyve2Fyrre = Tyve |
                  Tredvie |
                  Fyrre

instance DanishNumWord Tyve2Fyrre where
    value Tyve = 20
    value Tredvie = 30
    value Fyrre = 40

-- data DanishNumWords = Tres |
--                      Fjerds |
--                      Firs |
--                      Fems |
--                      Halv |
--                      End deriving Show

main = do str <- readFile "dk.txt"
          print (compile (lexer str))
          print "hej"

-- Givet input:
--   en og tyve
--   to og tyve
-- 
-- Ska lexer returnera:
--   [En, Tyve, End, To, Tyve]
lexer :: String -> [DanishNumWord]
lexer aString = []

-- Givet input:
--   [En, Tyve, End, To, Tyve]
--
-- Ska compile returnera:
--   [21, 22]
compile :: [DanishNumWord] -> [Int]
compile (En2Ni : Halv : mult : t) = value(en2ni) + (value mult) - 10
compile (En2Ni:t)                 = value h : compile t
compile []                        = []

--value :: DanishNumWords -> Int
--value Tres = 60
--value Fjerds = 80
--value Firs = 80
--value Fems = 100
