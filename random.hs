
f1 m x y z = z (m x) (m y)
f2 x y m = x . y. m
f3 f x y  = f y x
f4 (x, y) f m = (f x (fst m), f y (snd m))
f5 f = head.filter f
f6 f x m = (f m).x
f7 x y = x
f8 a1 a2 a3 = a1 a3 == a2 a3
f9 a1 a2 a3 = a1 (a3 + 1) == a2 (a3 + 1)
f10 x y c | c x = y
         | otherwise = x
f11 x m = ((>0).m) x
f12 x y f  =  f x > f y
f13 x = "¡" ++ show x ++ "!"
f14 f g = sum.map f.filter g
fCondicional f1 f2 f3 x
    | f1 x = f2 x
    | otherwise = f3 x
    where  transformarCond f1 f2 f3 l = map (fCondicional f1 f2 f3) l
f15 = (.)(.)(.)

sumarSegun f list = foldl ((+).(f)) 0 list
