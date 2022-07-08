module Library where

import PdePreludat

-- Parte 1
data Persona = Persona
  { nombre :: String,
    edad :: Number,
    nivelDeStress :: Number,
    preferencia :: [Preferencia],
    amigues :: [Persona]
  }
  deriving (Show)

largoDelNombre :: Persona -> Number
largoDelNombre persona = (length . nombre) persona

cantidadDeAmigues :: Persona -> Number
cantidadDeAmigues persona = (length . amigues) persona

multiplicarPorEdad :: Persona -> (Persona -> Number) -> Number
multiplicarPorEdad persona propiedad = edad persona * propiedad persona

doble :: Number -> Number
doble a = 2 * a

obtenerScoring :: Persona -> Number
obtenerScoring persona
  | (even . length . amigues) persona = multiplicarPorEdad persona nivelDeStress
  | ((> 40) . edad) persona = multiplicarPorEdad persona (length . amigues)
  | otherwise = (doble . largoDelNombre) persona

-- Elementos para tests de parte 1

juan =
  Persona
    { nombre = "Juan",
      edad = 25,
      amigues = [paulina, rigoberta],
      nivelDeStress = 10,
      preferencia = [desenchufarse]
    }

paulina = juan {nombre = "Paulina", edad = 41, amigues = [personaSinAmigues]}

rigoberta = paulina {nombre = "Rigoberta", edad = 31}

-- Parte 2
-- a
tieneNombreFirme :: Persona -> Bool
tieneNombreFirme persona = (('P' ==) . head . nombre) persona

-- b
esPersonaInteresante :: Persona -> Bool
esPersonaInteresante persona = ((>= 2) . cantidadDeAmigues) persona

-- Elementos para tests de parte 2
personaNombreFirme = paulina

personaNombreNoFirme = rigoberta

personaConUnAmigo = paulina

personaConDosAmigos = juan

-- Parte 3
stressValido :: Number -> Number
stressValido stress = (max 0 . min 100) stress

disminuyeEdadOVeinteDeStress :: Persona -> Number
disminuyeEdadOVeinteDeStress persona = nivelDeStress persona - (min 20 . edad) persona

type Destino = Persona -> Persona

marDelPlata :: Number -> Destino
marDelPlata mes persona
  | (< 3) mes = persona {nivelDeStress = (stressValido . (+ 10) . nivelDeStress) persona}
  | otherwise = persona {nivelDeStress = (stressValido . disminuyeEdadOVeinteDeStress) persona}

puertoMadryn :: Destino
puertoMadryn persona =
  persona
    { amigues = juanAmigueMadryn : amigues persona,
      nivelDeStress = 0
    }

lasToninas :: Bool -> Destino
lasToninas plata persona
  | plata = persona {nivelDeStress = ceiling (nivelDeStress persona / 2)}
  | otherwise = marDelPlata 7 persona

laAdela :: Destino
laAdela persona = persona

juanAmigueMadryn =
  Persona
    { nombre = "Juan",
      edad = 37,
      nivelDeStress = 80,
      amigues = [],
      preferencia = [desenchufarse]
    }

-- Elementos para tests de parte 3

personaDeVeinteDeStress = juan {nivelDeStress = 20}

jovenStresadoMarzo = juan {edad = 18, nivelDeStress = 50}

jovenPocoStresadoMarzo = juan {edad = 18, nivelDeStress = 15}

personaDeCuarentaYCinco = juan {edad = 45, nivelDeStress = 50}

personaMuyStresada = juan {nivelDeStress = 75}

personaSinAmigues = juan {amigues = [], nivelDeStress = 40}

personaSuperStresada = juan {nivelDeStress = 80}

-- Parte 4

type Preferencia = Destino -> Persona -> Bool

desenchufarse :: Preferencia
desenchufarse destino persona = ((< nivelDeStress persona) . (nivelDeStress . destino)) persona

enchufarseEspecial :: Number -> Preferencia
enchufarseEspecial stressDeseado destino persona = ((==) stressDeseado . (nivelDeStress . destino)) persona

socializar :: Preferencia
socializar destino persona = ((> cantidadDeAmigues persona) . cantidadDeAmigues . destino) persona

sinPretensiones :: Preferencia
sinPretensiones destino persona = True

-- Elementos para tests de parte 4

personaDesenchufar = juan

personaEnchufarse = juan {edad = 22, preferencia = [enchufarseEspecial 20], nivelDeStress = 40}

personaEnchufarseEstresada = personaEnchufarse {nivelDeStress = 45}

personaSocializar = personaEnchufarse {preferencia = [socializar]}

personaSinPretensiones = personaEnchufarse {preferencia = [sinPretensiones]}

-- Parte 5
-- a

aplicarPreferencia :: Persona -> Destino -> Preferencia -> Bool
aplicarPreferencia persona destino preferencia = preferencia destino persona

destinoApto :: Destino -> Persona -> Bool
destinoApto destino persona = any (aplicarPreferencia persona destino) (preferencia persona)

destinoAptoContingente :: Destino -> [Persona] -> Bool
destinoAptoContingente destino contingente = all (destinoApto destino) contingente

-- Elementos para tests de parte 5

ariel =
  Persona
    { nombre = "Ariel",
      edad = 21,
      nivelDeStress = 20,
      amigues = [],
      preferencia = [desenchufarse, socializar]
    }

pedro =
  Persona
    { nombre = "Pedro",
      edad = 38,
      nivelDeStress = 50,
      amigues = [],
      preferencia = [sinPretensiones, enchufarseEspecial 10]
    }

carola =
  Persona
    { nombre = "Carola",
      edad = 21,
      nivelDeStress = 45,
      amigues = [],
      preferencia = [socializar]
    }

contingenteMarDelPlataBajarStress = [ariel, pedro]

contingenteMarDelPlataContieneSocializar = [carola, pedro]

-- b
-- Destino es piola si el stress total del contingente es menor a 100

type Contingente = [Persona]

esDestinoPiola :: Destino -> Contingente -> Bool
esDestinoPiola destino contingente = ((< 100) . sumOf (nivelDeStress . destino)) contingente

pedro2 = pedro {nivelDeStress = 35}

contingenteDestinoPiola = [carola, pedro2]

-- Parte 6
-- a
-- Queremos saber con cuánto stress queda una persona después de ir a varios detinos

type Paquete = [Destino]

personaPaquete = juan {nombre = "Gustavo", nivelDeStress = 90, preferencia = [], edad = 25, amigues = []}

paqueteTuristico = [marDelPlata 3, laAdela, lasToninas False]

stressPostPaquete :: Persona -> Paquete -> Number
stressPostPaquete persona paquete = nivelDeStress (foldr ($) persona paquete)

-- b

-- Dado un contingente, queremos saber si alguna persona la pasa bien, esto ocurre
-- si algún amigue de esa persona forma parte del contingente.

-- Son las 3 de la mañana y no sé cómo, pero místicamente esto anda
-- "Si cualquier de estos nombres (individualmente) está en la lista aplanada de todos los amigues del contingente"

-- algunoLaPasaBien :: Contingente -> Bool
-- algunoLaPasaBien contingente = any (flip elem (map nombre contingente)) (concatMap (map nombre . amigues) contingente)

-- Y reescrito abajo a ver que onda queda más lindo, aunque tampoco termino de entenderlo

-- algunoLaPasaBien :: Contingente -> Bool
-- algunoLaPasaBien contingente = any (flip elem (concatMap (map nombre . amigues) contingente) . nombre) contingente

-- Defino la igualdad entre personas
instance Eq Persona where
  (==) persona1 persona2 = nombre persona1 == nombre persona2

algunoLaPasaBien :: Contingente -> Bool
algunoLaPasaBien contingente = any (any (flip elem contingente) . amigues) contingente

-- Elementos para tests de parte 6

juanAmiguero = juanAmigueMadryn

amigueDeJuan1 = juanAmiguero {nombre = "Jorge", amigues = [juanAmiguero]}

amigueDeJuan2 = amigueDeJuan1 {nombre = "Ringo"}

contingenteSinJuan = [amigueDeJuan1, amigueDeJuan2]

contingenteConJuan = [amigueDeJuan1, amigueDeJuan2, juan]

-- Parte 7

chequeoContingenteTOC :: Contingente -> Bool
chequeoContingenteTOC [] = True
chequeoContingenteTOC [_] = True
chequeoContingenteTOC (_ : segunda : resto) = (even . obtenerScoring) segunda && chequeoContingenteTOC resto

-- Elementos para tests de parte 7

fabiana = juanAmiguero {nombre = "Fabiana", nivelDeStress = 50, preferencia = [], edad = 41, amigues = [juanAmiguero]}

personaScoringImpar = fabiana

rigobertaTOC = juanAmiguero {nombre = "Rigoberta", nivelDeStress = 20, preferencia = [], edad = 31, amigues = [juanAmiguero]}

personaScoringPar = rigobertaTOC

veronica = juanAmiguero {nombre = "Verónica", nivelDeStress = 51, preferencia = [], edad = 11, amigues = [juanAmiguero]}

contingenteTOCSimple = [fabiana, rigobertaTOC]

contingenteTOCVerdadero = [fabiana, rigobertaTOC, veronica, juanAmiguero]

contingenteTOCFalso = [juanAmiguero, fabiana, rigobertaTOC]

-- Parte 8

contingenteInfinito :: Contingente
contingenteInfinito = juanAmiguero : repeat amigueDeJuan1