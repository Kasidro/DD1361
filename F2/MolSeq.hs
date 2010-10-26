module MolSeq where

import Data.List(group, sort, transpose, unionBy)

class Evol a where
    distance :: a -> a-> Float
    
    distanceMatrix :: [a] -> [Float]
    distanceMatrix a = map (\(x, y) -> distance x y) combinations
        where combinations = [(c, d) | c <- a, d <- a]

--
-- MolSeqType
-- MolSeqType defines what type of molecule sequence type we are describing.
-- DNA may contain ACGT. Protein may contain ARNDCEQGHILKMFPSTWYV
data MolSeqType = DNA | Protein deriving (Show, Eq)

-- DNA
nucleotides = "ACGT"
-- Protein
aminoacids = sort "ARNDCEQGHILKMFPSTWYVX"

--
-- MolSeq
--
data MolSeq = MolSeq { seqName      :: String,
                       seqSequence  :: String,
                       seqType      :: MolSeqType } deriving Show

instance Evol MolSeq where
    distance a b = seqDistance a b

string2seq :: String -> String -> MolSeq
string2seq n s | contains s nucleotides = MolSeq n s DNA
               | contains s aminoacids  = MolSeq n s Protein
               | otherwise              = error "Strange sequence characters"

seqLength :: MolSeq -> Int
seqLength (MolSeq _ s _) = length s

seqDistance :: MolSeq -> MolSeq -> Float
seqDistance (MolSeq _ s1 DNA) (MolSeq _ s2 DNA) = dist
    where noMutations = mutations s1 s2
          mutationPct = fromIntegral(noMutations)/fromIntegral(length s1)
          
          dist = if noMutations == 0 then
                     0
                 else if mutationPct > 0.74 then
                     3.3
                 else
                     -3/4 * log(1 - 4 * mutationPct/3)

seqDistance (MolSeq _ s1 Protein) (MolSeq _ s2 Protein) = dist
    where noMutations = mutations s1 s2
          mutationPct = fromIntegral(noMutations)/fromIntegral(length s1)
          
          dist = if noMutations == 0 then
                     0
                 else if mutationPct >= 0.94 then
                     3.7
                 else
                     -19/20 * log(1 - 20 * mutationPct/19)

seqDistance (MolSeq _ _ _) (MolSeq _ _ _)               = error "Unable to calculate distance between DNA and Protein"

mutations :: String -> String -> Int
mutations (h1:t1) (h2:t2) = if h1 == h2 then (mutations t1 t2) else (mutations t1 t2) + 1
mutations []      []      = 0

--
-- Profile
--
data Profile = Profile { matrix   :: [[(Char, Float)]],
                         profType :: MolSeqType,
                         noSeqs   :: Int,
                         name     :: String } deriving Show

instance Evol Profile where
    distance a b = profileDistance a b

fromMolSeqs seqs = Profile m t l n
    where m = makeProfileMatrix seqs
          t = seqType (head seqs)
          l = length seqs
          n = seqName (head seqs)

makeProfileMatrix :: [MolSeq] -> [[(Char, Float)]]
makeProfileMatrix [] = error "Empty sequence list"
makeProfileMatrix sl = res
    where t = seqType (head sl)
          n = length sl
          
          defaults = if (t == DNA) then
                         zip nucleotides (replicate (length nucleotides) 0)                 -- Create a list with tuples with nucleotide -> 0
                     else 
                         zip aminoacids (replicate (length aminoacids) 0)                   -- Create a list with tuples with aminoacid -> 0
          
          strs = map seqSequence sl                                                         -- Creates a list with all sequences ["ACD", "AGG"]
          tmp1 = map (map (\x -> ((head x), (length x))) . group . sort) (transpose strs)   -- Transform the list from ["ACD", "AGG"] to [[('A', 1), ('C', 1'), ('D', 1)], [('A', 1), ('G', 2)]]
          equalFst a b = (fst a ) == (fst b)                                                -- Support function used by the next line
          tmp2 = map sort (map (\l -> unionBy equalFst l defaults) tmp1)                     -- Convert tmp1 to [[(Char, Int)]]
          fn3 d = map (\x -> (fst x, (fromIntegral(snd x))/(fromIntegral n))) d
          res = map fn3 tmp2

profileDistance :: Profile -> Profile -> Float
profileDistance p1 p2 = dist
    where fn1 a  b  = abs((snd a) - (snd b))
          fn2 l1 l2 = sum (zipWith fn1 l1 l2)
          dist      = sum (zipWith fn2 (matrix p1) (matrix p2))

--
-- Support functions
--
contains :: Eq a => [a] -> [a] -> Bool
contains (h:t) b = elem h b && contains t b
contains []    _ = True

