module F1 where

import Char

--
-- Fibonacci number
--
fib n | n == 0 = 0
      | n == 1 = 1
      | n > 1  = (fib (n - 1)) + (fib (n - 2))

--
-- Svenska --> Rovarsprak
-- 
rovarsprak (h:t) = if isVowel h then h:(rovarsprak t) else h : 'o' : h : rovarsprak t
rovarsprak [] = ""

isVowel c = elem c "AEIOUYaeiouy"

isConst c = not (isVowel c)

--
-- Rovarsprak --> Svenska
--
svenska (h:'o':c:t) = h:(svenska t)
svenska []          = ""
svenska (h:t)       = h:(svenska t)

--
-- Merge sort
--
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge l  [] = l
merge [] l  = l
merge (h1:t1) (h2:t2) = if h1 <= h2
			   then h1:(merge t1 (h2:t2))
			   else merge (h2:t2) (h1:t1)

--
-- Maxord
--
maxord :: String -> Int
maxord [] = 0
maxord s  = maxord_h s 0 0

maxord_h :: String -> Int -> Int -> Int
maxord_h (h:t) m c = if isAlpha h then (maxord_h t m (c + 1)) else (maxord_h t (max m c) 0)
maxord_h [] m c    = max m c

--
-- ackfib
--
ackfib n = ackfib_h n 0 1 0 

ackfib_h n a b c = if n == c then b else ackfib_h n b (a + b) (c + 1)
 
