module Character exposing (..)



type Key =
         Up | First | Second

type alias Character =
               {  x      : Float
                , y      : Float
                , wid    : Float
                , hei    : Float
                , right  : Key
                , left   : Key
                , up     : Key
                , down   : Key
                , jump   : Bool
                , v_x    : Float
                , v_y    : Float
                , step   : Int
                , ang    : Int
                , xlink  : String
                , yInitDist : Float
                , candle : Float
                , clueList  : List Int
               }


cha_init1 : Character
cha_init1 = Character -210 180 20 20 Up Up Up Up True 0 0 1 0 "picture/character/day_right.png" 0 100 []

cha_init2 : Character
cha_init2 = Character -216 189 18 18 Up Up Up Up True 0 0 1 0 "picture/character/day_right.png" 0 100 []

cha_init3 : Character
cha_init3 = Character -212 187 16 16 Up Up Up Up True 0 0 1 0 "picture/character/day_right.png" 0 100 []

cha_init4 : Character
cha_init4 = Character -213.75 191.25 15 15 Up Up Up Up True 0 0 1 0 "picture/character/day_right.png" 0 100 []

cha_init5 : Character
cha_init5 = Character -216 198 12 12 Up Up Up Up True 0 0 1 0 "picture/character/day_right.png" 0 100 []

