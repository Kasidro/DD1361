
module DkToSv where

import Char

data EndStatement = End

data DanishNumWords = En |
                      Et | 
                      To |
                      Tre |
                      Fire |
                      Fem |
                      Seks |
                      Syv |
                      Otte |
                      Ni |
                      Ti |
                      Ellve |
                      Tolv |
                      Tretten |
                      Fjorten |
                      Femten |
                      Seksten |
                      Sytten |
                      Otten |
                      Nitten |
                      Tyve |
                      Tredvie |
                      Fyrre |
                      Tres |
                      Fjerds |
                      Firs |
                      Fems |
                      Halv

main = do str <- readFile "dk.txt"
          putStrLn (compile (lexer str))
          print "hej"

-- Givet input:
--   en og tyve
--   to og tyve
-- 
-- Ska lexer returnera:
--   [En, Tyve, End, To, Tyve]
lexer :: String -> [DanishNumWords]

compile :: [DanishNumWords] -> [Int]
