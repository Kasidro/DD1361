
module DkToSv where

import Text.Regex

split s = splitRegex space s
    where space = mkRegex "[ \n]+"

dk2sv :: String -> Int
dk2sv aString = en2ni (split aString)

en2ni (w:rest) | w == "en"   = 1 + mer rest
               | w == "to"   = 2 + mer rest
               | w == "tre"  = 3 + mer rest
               | w == "fire" = 4 + mer rest
               | w == "fem"  = 5 + mer rest
               | w == "seks" = 6 + mer rest
               | w == "syv"  = 7 + mer rest
               | w == "otte" = 8 + mer rest
               | w == "ni"   = 9 + mer rest
               | otherwise   = ti2nitten (w:rest)

ti2nitten :: [String] -> Int
ti2nitten (w:rest) | w == "ti" = 10
                   | w == "ellve" = 11
                   | w == "tolv" = 12
                   | w == "tretten" = 13
                   | w == "fjorten" = 14
                   | w == "femten" = 15
                   | w == "seksten" = 16
                   | w == "sytten" = 17
                   | w == "arten" = 18
                   | w == "nitten" = 19
                   | otherwise = tyve2halvfems (w:rest)

tyve2halvfems :: [String] -> Int
tyve2halvfems (w:rest) | w == "tyve" = 20
                       | w == "tredive" = 30
                       | w == "fyrre" = 40
                       | w == "fyrretyve" = 40
                       | otherwise = halvtreds2halvfems (w:rest)

halvtreds2halvfems (w:rest) | w == "halv" = -10 + mult rest
                            | otherwise   = mult (w:rest)

mult (w:rest) | w == "tres"   = 60
              | w == "firs"   = 80
              | w == "fjerds" = 80
              | w == "fems"   = 100

mer :: [String] -> Int
mer [] = 0
mer (w:rest) | w == "og" = tyve2halvfems rest
             | otherwise    = 0
