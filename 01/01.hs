module Solve_01 where

-- Get all the digits of a number
toDigits :: Integer -> [Integer]
toDigits n
  | n <= 0 = []
  -- Might be faster to reverse toDigitsRev since i've heard ++ is bad
  -- For proformance
  | otherwise = toDigits (n `div` 10) ++ [n `mod` 10]

-- Get all the digits of a number reversed
toDigitsRev :: Integer -> [Integer]
toDigitsRev n
  | n <= 0 = []
  | otherwise = n `mod` 10 : toDigitsRev (n `div` 10)

-- Using recursion
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther lst = reverse $ fn (reverse lst)
  where fn :: [Integer] -> [Integer]
        fn []       = []
        fn (x:[])   = [x]
        fn (x:y:zs) = x : y*2 : (fn zs)

{- Using foldl
doubleEveryOther xs = reverse $ snd $
  foldl fn (True, []) xs 
  where fn (dub, out) item =
          if dub then (False, item * 2:out)
          else        (True, item:out)
-}

sumDigits :: [Integer] -> Integer
-- Using functional composition
sumDigits = sum . concat . map toDigits

{- Using recursion
sumDigits [] = 0
sumDigits (x:xs) = (sum $ toDigits x) + sumDigits xs
-}

validate :: Integer -> Bool
validate n = mod result 10 == 0
  -- doubleEveryOther already doubles from the end so i don't need toDigitsRev
  -- there MIGHT be a better to do this since doubleEveryOther's implementation
  -- is pretty bad (uses reverse two times)
  where result = sumDigits $ doubleEveryOther $ toDigits n


---- THE TOWERS OF HANOI -----
type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]

-- hardcode 1 and 2
hanoi 1 a _ c = [(a,c)]
hanoi 2 a b c = [(a,b), (a,c), (b,c)]

hanoi n a b c =
  (hanoi (n-1) a c b)  ++
  [(a, c)]             ++
  (hanoi (n-1) b a c)


validateHanoi :: Int -> [Move] -> Bool
validateHanoi = undefined
