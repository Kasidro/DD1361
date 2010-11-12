
module DkToSv where

import Char

--
-- Defines the vocabulary we use
--
class (Show, Read) => DanishNumWord w where
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
             Ni

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
                 Nitten

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

data Tres2Fems = Tres |
                 Fjerds |
                 Firs |
                 Fems

instance DanishNumWord Tres2Fems where
    value Tres = 60
    value Fjerds = 80
    value Firs = 80
    value Fems = 100

data SpecialNumWord = Halv |
                      End

instance DanishNumWord SpecialNumWord where
    value Halv = -10
    value End  = -1


--
-- Main program
--
main = do str <- readFile "dk.txt";
          putStrLn (show (compile (lexer str)));

-- Givet input:
--   en og tyve
--   to og tyve
-- 
-- Ska lexer returnera:
--   [En, Tyve, End, To, Tyve]
lexer :: String -> [DanishNumWord]
lexer (h:t) = []

-- Givet input:
--   [En, Tyve, End, To, Tyve]
--
-- Ska compile returnera:
--   [21, 22]
compile :: [DanishNumWord] -> [Int]
compile (En2Ni : End : t) = value En2Ni : compile t
compile []                = []
