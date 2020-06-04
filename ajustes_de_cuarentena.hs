data Empleado = UnEmpleado {
    nombre :: String,
    rol :: String,
    sueldo :: Int
} deriving (Eq)

instance Show Empleado where
    show (UnEmpleado nombre rol sueldo) = "Nombre: " ++ nombre ++ ", puesto: " ++ rol ++ ", sueldo: " ++ show sueldo
    
data Propuesta = UnaPropuesta {
    rolNuevo :: String,
    sueldoNuevo :: (Int -> Int)
} 
    
empleado :: Empleado
empleado = UnEmpleado "Jorge" " " 50000.00

-- Parte 1

-- Punto 1.
aplicarPropuesta :: Empleado -> Propuesta -> Empleado
aplicarPropuesta emp prop = emp { rol = rolNuevo prop, sueldo = (sueldoNuevo prop) (sueldo emp)}

sueldoPostPropuesta :: Empleado -> Propuesta -> Int
sueldoPostPropuesta emp = sueldo.aplicarPropuesta emp 

esPropuestaIlegal :: Empleado -> Propuesta -> Bool
esPropuestaIlegal emp prop = sueldo emp > sueldoPostPropuesta emp prop

-- Punto 2.
-- Aca tira ERROR
esPropuestaDudosa :: [Empleado]-> Propuesta -> Bool
esPropuestaDudosa emp prop = any ((>).(sueldoPostPropuesta emp prop)) (map sueldo emp)

-- Punto 3.
ordenarSegun _ [] = []
ordenarSegun f (x:xs) = (ordenarSegun f [a | a <- xs, (f a) >= (f x)]) ++ [x] ++ (ordenarSegun f [a | a <- xs, (f a) <= (f x)])

mejorPropuesta :: [Propuesta] -> Empleado -> Propuesta
mejorPropuesta prop emp = head (ordenarSegun (sueldoPostPropuesta emp) prop)

cuantoGanariaAhora :: [Propuesta] -> Empleado -> Int
cuantoGanariaAhora prop emp = sueldoPostPropuesta emp (mejorPropuesta prop emp) 

-- Punto 4.
guitaAhorrada :: Propuesta -> Empleado -> Int
guitaAhorrada prop emp = sueldo emp - sueldoPostPropuesta emp prop

nosAhorramosGuita :: Propuesta -> [Empleado] -> Int
nosAhorramosGuita prop emp = sum (map (guitaAhorrada prop) emp)

-- Punto 5.
-- TRANSFORMACION A
empleadosConTitulo::String->[Empleado]->[Empleado]
empleadosConTitulo titulo = filter ((==titulo).rol)

conLosOjosCerrados::[Empleado]->[Empleado]
conLosOjosCerrados lista =  
    (take 1 (empleadosConTitulo "Ingeniero Capo Master" lista)) ++ (empleadosConTitulo "Backend Developer" lista)

-- TRANSFORMACION B
reducirSueldo :: Int -> Empleado -> Empleado
reducirSueldo nro emp = empleado {sueldo = (sueldo emp) - nro}

reduccionViolenta :: Int -> [Empleado] -> [Empleado]
reduccionViolenta nro emp = map (reducirSueldo nro) emp

-- TRANSFORMACION C
aplicarMejorPropuesta :: [Propuesta] -> Empleado -> Empleado
aplicarMejorPropuesta prop emp = aplicarPropuesta emp (mejorPropuesta prop emp)

propuestaGeneral :: [Propuesta] -> [Empleado] -> [Empleado]
propuestaGeneral prop emp = map (aplicarMejorPropuesta prop) emp

-- TRANSFORMACION D
sueldoTotales :: [Empleado] -> Int
sueldoTotales emp = sum (map sueldo emp)

promedio :: [Empleado] -> Int
promedio emp = div (sueldoTotales emp) (length emp)

menosQueElPromedio :: [Empleado] -> Empleado -> Bool
menosQueElPromedio emps emp = (sueldo emp) < (promedio emps)

soloLosQueCobranPoco :: [Empleado] -> [Empleado]
soloLosQueCobranPoco emp = filter (menosQueElPromedio emp) emp

-- Parte 2










