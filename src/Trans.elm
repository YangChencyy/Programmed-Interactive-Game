module Trans exposing (..)
import Character exposing (Key(..))




type alias TransModel =
               {  lan    : Int
                , x      : Float
                , right  : Key
                , left   : Key
                , step   : Int
                , xlink  : String
                , candle : Float
                , clueList  : List Int
                , day    : Int
                , total  : Int
                , now    : Int
                , opa1    : Float
                , opa2    : Float
               }