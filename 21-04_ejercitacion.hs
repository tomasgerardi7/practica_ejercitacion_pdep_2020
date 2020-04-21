-- 1. Buscar el maximo número primo
-- NOTA: Un numero es primo si y solamente si es divisible por 1 y por si mismo

buscarPrimoMax :: Int->[Int]->[Int]
buscarPrimoMax nro lista | (mod nro  1 == 0) && (mod nro nro == 0) = nro:lista
                         | otherwise = buscarPrimoMax (nro + 1) lista


