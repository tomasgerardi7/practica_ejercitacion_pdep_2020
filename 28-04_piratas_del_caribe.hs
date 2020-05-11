
data Piratas = Pirata {
    apodo :: String,
    tesoro :: [(String, Int)]
} deriving (Show,Eq)

-- data Tesoros = Tesoro {
--     nombre :: String,
--     valor :: Int
-- } deriving (Show,Eq)

jackSparrow :: Piratas
-- jackSparrow = Pirata "Jack Sparrow" [Tesoro "Brujula" 10000, Tesoro "Frasco de arena" 0]
jackSparrow = Pirata "Jack Sparrow" [("Brujula", 10000),("Frasco de arena", 0)]

davidJones :: Piratas
-- davidJones = Pirata "David Jones" [Tesoro "Cajita musical" 1]
davidJones = Pirata "David Jones" [("Cajita musical", 1)]

anneBonny :: Piratas 
-- anneBonny = Pirata "Anne Bonny" [Tesoro "Doblones" 100, Tesoro "Frasco de arena" 1]
anneBonny = Pirata "Anne Bonny" [("Doblones", 100),("Frasco de arena", 1)]


cantidadDeTesorosDelPirata :: Piratas -> String
cantidadDeTesorosDelPirata pirata = "Cantidad de tesoros de " ++ apodo pirata ++ ": " ++ show(length (tesoro pirata))

esPirataAfortunado :: Piratas -> String
esPirataAfortunado pirata | sumatoria (tesoro pirata) > 10000 = apodo pirata ++ " es afortunado"
                          | otherwise = apodo pirata ++ " no es afortunado"

sumatoria :: [(String, Int)] -> Int
sumatoria (x:xs) =  snd x + sumatoria xs 