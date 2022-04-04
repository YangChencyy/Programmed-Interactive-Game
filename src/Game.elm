module Game exposing (..)
import Block exposing (..)
import Map exposing (..)
import Character exposing (Character, Key(..), cha_init1, cha_init2, cha_init3, cha_init4, cha_init5)



type alias GameModel =
               {  lis     : Grid
                , cha     : Character
                , wid     : Float
                , hei     : Float
                , imax    : Int
                , jmax    : Int
                , g       : Float
                , mod     : Kind
                , ang     : Int
                , opacity : Float
                , day     : Int
                , lan     : Int
                , pause   : Bool
                , onShow  : Int
                , clueinit : List Int
                , candleinit : Float
               }


type Kind = Day
          | Rotate
          | Darken
          | Night


kx = 2.71 / 2


ky = 2.71 / 2


init1 : Grid
init1 = generate 450 450 [] 0 0 14 14 map1 1


init2 : Grid
init2 = generate 442 442 [] 0 0 16 16 map2 2


init3 : Grid
init3 = generate 450 450 [] 0 0 17 17 map3 3


init4 : Grid
init4 = generate 450 450 [] 0 0 19 19 map4 4

init5 : Grid
init5 = generate 450 450 [] 0 0 24 24 map5 5


init_model1 : GameModel
init_model1 = GameModel init1 cha_init1 450 450 15 15 -0.5 Day 0 0 1 1 False 0 [] 100


init_model2 : GameModel
init_model2 = GameModel init2 cha_init2 442 442 17 17 -0.5 Day 0 0 2 1 False 0 [] 0


init_model3 : GameModel
init_model3 = GameModel init3 cha_init3 450 450 18 18 -0.5 Day 0 0 3 1 False 0 [] 0


init_model4 : GameModel
init_model4 = GameModel init4 cha_init4 450 450 20 20 -0.5 Day 0 0 4 1 False 0 [] 0


init_model5 : GameModel
init_model5 = GameModel init5 cha_init5 450 450 25 25 -0.5 Day 0 0 5 1 False 0 [] 0

