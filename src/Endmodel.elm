module Endmodel exposing (..)





type alias EndModel =
               {  lan : Int
                , clueList : List Int
                , yk : Int
                , yh : Int
                , yt : Int
                , ys : Int
                , mont : Int
                , mons : Int
                , dt : Int
                , ds : Int
                , ht : Int
                , hs : Int
                , mint : Int
                , mins : Int
                , pause : Bool
                , onShow : Int
                , try : Int
                }


init_end : EndModel
init_end = EndModel 1 [] 0 0 0 0 0 0 0 0 0 0 0 0 False 0 0