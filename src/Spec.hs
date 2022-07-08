module Spec where

import Library
import PdePreludat
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests de scoring sobre los datos de una persona" $ do
    it "El scoring de una persona con cantidad par de amigues debería ser su edad multiplicada por su nivel de stress" $ do
      obtenerScoring juan `shouldBe` 250
    it "El scoring de una persona mayor de 40 debería ser su edad multiplicada por la cantidad de amigues" $ do
      obtenerScoring paulina `shouldBe` 41
    it "El scoring de una persona con cantidad impar de amigues y menor de 40 es el doble del largo de su nombre" $ do
      obtenerScoring rigoberta `shouldBe` 18
  describe "Tests de funciones nombre firme y persona interesante" $ do
    it "Tiene nombre firme una persona cuyo nombre empieza con 'P'" $ do
      tieneNombreFirme personaNombreFirme `shouldBe` True
    it "No tiene nombre firme una persona cuyo nombre no empieza con 'P'" $ do
      tieneNombreFirme personaNombreNoFirme `shouldBe` False
    it "Una persona con menos de dos amigues no es interesante" $ do
      esPersonaInteresante personaConUnAmigo `shouldBe` False
    it "Una persona con dos o más amigues es interesante" $ do
      esPersonaInteresante personaConDosAmigos `shouldBe` True
  describe "Tests de Destinos" $ do
    it "Una persona que se va de vacaciones a Mar del Plata en enero debe aumentar su nivel de stress en 10" $ do
      (nivelDeStress . marDelPlata 1) personaDeVeinteDeStress `shouldBe` 30
    it "Una persona menor de 20 y más stress que edad que va a Mar del Plata en marzo debe reducirle su edad a su stress" $ do
      (nivelDeStress . marDelPlata 3) jovenStresadoMarzo `shouldBe` 32
    it "Una persona menor de 20 y menos stress que edad que va a Mar del Plata en marzo debe volver con 0 stress" $ do
      (nivelDeStress . marDelPlata 3) jovenPocoStresadoMarzo `shouldBe` 0
    it "Una persona mayor de 20 y más stress que edad que va a Mar del Plata en marzo debe volver con su stress reducido en 20" $ do
      (nivelDeStress . marDelPlata 3) personaDeCuarentaYCinco `shouldBe` 30
    it "Una persona que se va a Las Toninas con plata y un nivel de stress impar debería volver con la mitad de stress redondeado hacia arriba" $ do
      (nivelDeStress . lasToninas True) personaMuyStresada `shouldBe` 38
    it "Una persona que se va a Las Toninas sin plata debe volver con su nivel de stress reducido en su edad o 20, lo que sea mayor" $ do
      (nivelDeStress . lasToninas False) personaMuyStresada `shouldBe` 55
    it "Una persona que va a Puerto Madryn debe volver sin stress" $ do
      (nivelDeStress . puertoMadryn) personaSinAmigues `shouldBe` 0
    it "Una persona sin amigues que va a Puerto Madryn debe volver con un amigue" $ do
      (cantidadDeAmigues . puertoMadryn) personaSinAmigues `shouldBe` 1
    it "Una persona que va a la Adela debe volver con la misma cantidad de stress" $ do
      (nivelDeStress . laAdela) personaSuperStresada `shouldBe` 80
  describe "Tests de Preferencias" $ do
    it "La preferencia desenchufarse para alguien que va a Mar del Plata en enero no se cumple" $ do
      desenchufarse (marDelPlata 1) personaDesenchufar `shouldBe` False
    it "La Preferencia desenchufarse para alguien que va a Mar del Plata marzo se cumple" $ do
      desenchufarse (marDelPlata 3) personaDesenchufar `shouldBe` True
    it "Preferencia enchufarse especial esperando un stress final de 20 para una persona menor de 20 y más stress que edad que viaja a Mar del Plata en Marzo, se cumple" $ do
      enchufarseEspecial 20 (marDelPlata 3) personaEnchufarse `shouldBe` True
    it "Preferencia enchufarse esperando un nivel de stress 20 para una persona mayor de 20 años y más stress que edad que viaja a Mar del Plata en Marzo no se cumple" $ do
      enchufarseEspecial 20 (marDelPlata 3) personaEnchufarseEstresada `shouldBe` False
    it "Preferencia socializar para una persona que viaja a Puerto Madryn se cumple" $ do
      socializar puertoMadryn personaSocializar `shouldBe` True
    it "Preferencia socializar para una persona que viaja a La Adela no se cumple" $ do
      socializar laAdela personaSocializar `shouldBe` False
    it "Preferencia sinPretensiones para una persona que viaja a La Adela se cumple" $ do
      sinPretensiones laAdela personaSinPretensiones `shouldBe` True
  describe "Tests de Preferencias de Contingentes" $ do
    it "Mar del Plata en Marzo es apto para un contingente con gente que quiere tener menos stress" $ do
      destinoAptoContingente (marDelPlata 3) contingenteMarDelPlataBajarStress `shouldBe` True
    it "Mar del Plata en Enero no es apto para un contingente con gente que tiene la preferencia socializar" $ do
      destinoAptoContingente (marDelPlata 3) contingenteMarDelPlataContieneSocializar `shouldBe` False
  describe "Tests de Destino Piola" $ do
    it "Mar del Plata en Marzo es un destino piola para un contingente" $ do
      esDestinoPiola (marDelPlata 3) contingenteDestinoPiola `shouldBe` True
    it "Mar del Plata en Enero no es un destino piola para un contingente" $ do
      esDestinoPiola (marDelPlata 1) contingenteDestinoPiola `shouldBe` False
  describe "Tests de Stress de un Paquete Turístico" $ do
    it "Una persona que inicialmente tiene 90 de stress que usa un paquete turístico que incluye Mar del Plata en Marzo vuelve con un stress final de 50" $ do
      stressPostPaquete personaPaquete paqueteTuristico `shouldBe` 50
    it "Una persona que hace uso de un paquete turístico vacío vuelve con el mismo nivel de stress" $ do
      stressPostPaquete personaPaquete [] `shouldBe` nivelDeStress personaPaquete
  describe "Tests sobre si alguna persona la pasa bien en un contingente" $ do
    it "En un contingente en el que el amigue de al menos una persona está presente, alguien debería pasarla bien" $ do
      algunoLaPasaBien contingenteConJuan `shouldBe` True
    it "En un contingente en el que ningún amigue de las personas está presente, nadie debería pasarla bien" $ do
      algunoLaPasaBien contingenteSinJuan `shouldBe` False
  describe "Tests sobre Contingente TOC" $ do
    it "Un contingente de una persona con scoring par es contingente TOC" $ do
      chequeoContingenteTOC [personaScoringPar] `shouldBe` True
    it "Un contingente de una persona con scoring impar es contingente TOC" $ do
      chequeoContingenteTOC [personaScoringImpar] `shouldBe` True
    it "Un contingente con scorings pares en sus posiciones pares es un Contingete TOC" $ do
      chequeoContingenteTOC contingenteTOCVerdadero `shouldBe` True
    it "Un contingente con al menos un scoring impar en sus posiciones pares no es un Contingete TOC" $ do
      chequeoContingenteTOC contingenteTOCFalso `shouldBe` False