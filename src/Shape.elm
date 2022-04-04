module Shape exposing (..)
import Block exposing (..)
import Svg exposing (..)
import List exposing (..)
import Svg.Attributes exposing (x, y, height, width, fill, xlinkHref, cx, cy, r, id, transform)
import Svg
import Svg.Attributes as SvgAttrs
import Game exposing (GameModel, Kind(..), kx, ky)
import Svg.Keyed as Keyed
import Svg.Lazy exposing (lazy6, lazy8)




svgAll : GameModel -> List (Svg msg)
svgAll model =
    case model.mod of
        Day ->
            let
                lis = List.sortWith xAddyComparison model.lis
            in

            let
                (downLeft, upRight) = List.partition (\someBlock -> someBlock.x + someBlock.y < model.cha.x + model.cha.y) lis
            in

            List.concat [imagePreload, (imageDayListFront Day 0 [] downLeft), [imageCharacter model], (imageDayListHind Day 0 [] upRight)]

        Rotate ->
            let
                lis = List.sortWith xAddyComparison (List.filter (\x -> x.typ/=0) model.lis)
            in

            let
                (downLeft, upRight) = List.partition (\someBlock -> someBlock.x + someBlock.y <= model.cha.x + model.cha.y) lis
            in

            List.concat [imagePreload, (imageDayListFront Rotate model.ang [] downLeft), [imageCharacter model], (imageDayListHind Rotate model.ang [] upRight)]

        Darken ->
            let
                lis = List.sortWith xMinusyComparison (List.filter (\x -> x.typ/=0) model.lis)
            in

            let
                (upRight, downLeft) = List.partition (\someBlock -> someBlock.x - someBlock.y <= model.cha.x - model.cha.y) lis
            in

            List.concat [imagePreload, (imageDayListFront Darken 90 [] downLeft), [imageCharacter model], (imageDayListHind Darken 90 [] upRight)]      


        Night ->
            let
                --lis = List.filter (\x -> x.typ/=0) model.lis
                lis = List.sortWith specialComparison (List.filter (\x -> x.typ/=0) model.lis) 
            in
            
            List.concat [imagePreload, (imageNightList lis), [imageCharacter model], (maskShape model), (imageArrow model)]

specialComparison : Block -> Block -> Order
specialComparison a b =
    if a.typ> 50 && b.typ> 50 then
       if a.typ <b.typ then
           LT
       else
           GT
    else if a.typ> 50 then
        GT
    else if b.typ> 50 then
        LT
    else if a.typ /=5 && a.typ /=6 && b.typ /=5 && b.typ /=6 then
        case compare (a.x + a.y) (b.x + b.y) of
        LT ->
            LT

        EQ ->
            case compare a.x b.x of
                LT ->
                    LT
                EQ ->
                    EQ
                GT ->
                    GT
        GT ->
            GT
    else if a.typ /= 5 && a.typ /= 6 then
        LT
    else if b.typ /= 6 && b.typ /= 6 then
        GT
    else if a.typ == 5 && b.typ == 5 then
        case compare a.y b.y of
            LT ->
                LT
            EQ ->
                EQ
            GT ->
                GT
    else if a.typ == 6 && b.typ == 6 then
        case compare a.x b.x of
            LT ->
                LT
            EQ ->
                EQ
            GT ->
                GT
    else if a.typ == 5 && b.typ == 6 then
        LT
    else
        GT   

           
    


xAddyComparison : Block -> Block -> Order
xAddyComparison a b =
    case compare (a.x + a.y) (b.x + b.y) of
        LT ->
            LT

        EQ ->
            case compare a.x b.x of
                LT ->
                    LT
                EQ ->
                    EQ
                GT ->
                    GT
        GT ->
            GT


xMinusyComparison : Block -> Block -> Order
xMinusyComparison a b =
    case compare (a.x - a.y) (b.x - b.y) of
        LT ->
            GT

        EQ ->
            case compare a.x b.x of
                LT ->
                    LT
                EQ ->
                    EQ
                GT ->
                    GT

        GT ->
            LT



maskShape : GameModel -> List (Svg msg)
maskShape model =
     [  defs []
             [  Svg.mask [ id "circlemask"]
                        [  rect [  x "-500"
                                 , y "-300"
                                 , width "1000"
                                 , height "600"
                                 , fill "white"
                                ]
                                []
                         , circle [  cx (String.fromFloat model.cha.x)
                                   , cy (String.fromFloat -model.cha.y)
                                   , r (String.fromFloat model.cha.candle)
                                   , fill "black"
                                  ]
                                  []
                        ]
            ]
      , rect [  x "-500"
             , y "-300"
             , width "1000"
             , height "600"
              , fill "black"
              , SvgAttrs.mask "url(#circlemask)"
             ]
             []
     ]



imageDayListFront : Kind -> Int -> List (Svg msg) -> List Block ->List (Svg msg) 
imageDayListFront kind ang grid bank =
    case List.head bank of
        Just a ->
            let
                string =
                    if kind == Darken then
                        "rotate(" ++ String.fromInt -ang ++ "," ++ String.fromFloat (a.x) ++ "," ++ String.fromFloat (-a.y) ++ ")"             
                    else
                        "translate(" ++ String.fromFloat (0.0) ++ "," ++ String.fromFloat (0.0) ++ ") rotate(" ++ String.fromInt -ang ++ ")"          
            in  
            let a_ = [ Svg.image [ SvgAttrs.x "-500"
                                 , SvgAttrs.y "-500"
                                 , SvgAttrs.height "1"
                                 , SvgAttrs.width "1"
                                 , SvgAttrs.id (String.fromInt (-a.id))
                                 , xlinkHref "picture/light/light_indark.png"
                                 ]
                                 []

                     , Svg.image [ SvgAttrs.x ((String.fromFloat (a.x - a.len / 2)))
                                 , SvgAttrs.y ((String.fromFloat -((a.y + a.len * (ky - 1) / 2) + a.len / 2)))
                                 , SvgAttrs.height (String.fromFloat (a.len * ky))
                                 , SvgAttrs.width (String.fromFloat (a.len * kx))
                                 , SvgAttrs.id (String.fromInt a.id)
                                 , xlinkHref a.xlink
                                 , transform string
                                 ]
                                 []
                     ]
            in
            case a.typ of
                0 ->
                    imageDayListFront kind ang grid ( List.drop 1 bank )
                _ ->
                    imageDayListFront kind ang ( List.concat [ grid, a_ ] ) ( List.drop 1 bank )
        _ ->
            grid

imageDayListHind : Kind -> Int -> List (Svg msg) -> List Block ->List (Svg msg) 
imageDayListHind kind ang grid bank = 
    case List.head bank of
        Just a ->
            let
                string =
                    if kind == Darken then
                        "rotate(" ++ String.fromInt -ang ++ "," ++ String.fromFloat (a.x) ++ "," ++ String.fromFloat (-a.y) ++ ")"             
                    else
                        "translate(" ++ String.fromFloat (0.0) ++ "," ++ String.fromFloat (0.0) ++ ") rotate(" ++ String.fromInt -ang ++ ")"          
            in  
            let a_ = [ Svg.image [ SvgAttrs.x ((String.fromFloat (a.x - a.len / 2)))
                                 , SvgAttrs.y ((String.fromFloat -((a.y + a.len * (ky - 1) / 2) + a.len / 2)))
                                 , SvgAttrs.height (String.fromFloat (a.len * ky))
                                 , SvgAttrs.width (String.fromFloat (a.len * kx))
                                 , SvgAttrs.id (String.fromInt a.id)
                                 , xlinkHref a.xlink        
                                 , transform string
                                 ]
                                 []

                     , Svg.image [ SvgAttrs.x "-500"
                                 , SvgAttrs.y "-500"
                                 , SvgAttrs.height "1"
                                 , SvgAttrs.width "1"
                                 , SvgAttrs.id (String.fromInt (-a.id))
                                 , xlinkHref "picture/light/light_indark.png"
                                 ]
                                 []
                     ]
            in
            case a.typ of
                0 ->
                    imageDayListHind kind ang grid ( List.drop 1 bank )
                _ ->
                    imageDayListHind kind ang ( List.concat [ grid, a_ ] ) ( List.drop 1 bank )
        _ ->
            grid

imageNightList : List Block -> List (Svg msg)
imageNightList lis =
    List.map imageNight lis


imageNight : Block -> Svg msg
imageNight unit =
    lazy6 svgNight unit.xlink unit.len unit.len unit.x unit.y unit.id


imageCharacter : GameModel -> Svg msg
imageCharacter model =
      lazy8 svgCharacter model.cha.wid model.cha.hei model.cha.x model.cha.y model.cha.ang model.ang model.cha.xlink model.mod


imageArrow : GameModel -> List (Svg msg)
imageArrow model =
    svgArrow 8.0 8.0 model.cha.x model.cha.y arrowDist model.lis


svgArrow : Float -> Float -> Float -> Float -> Float -> List Block -> List (Svg msg)
svgArrow wid hei x y dist bank =
    case List.head bank of
        Just someBlock ->
            let
                (x_, y_) = (someBlock.x, someBlock.y)
            in

            let
                alpha = atan2  (y_ - y) (x_ - x)
            in

            let
                dist_ =((y_ - y) ^ 2 + (x_ - x) ^ 2) ^ 0.5
            in

            let
                rad =
                    if dist_ >= 5 * dist then
                        dist
                    else if dist_ >= 2.5 * dist then
                        4 * dist - 0.6 * dist_
                    else
                        dist_
            in

            case someBlock.typ of
                9 ->
                    [ Svg.image [  SvgAttrs.x ((String.fromFloat (x + rad * cos(alpha) - wid * 1.3 / 2)))
                                , SvgAttrs.y ((String.fromFloat -(y + rad * sin(alpha) + hei * 1.3/2)))
                                , SvgAttrs.height (String.fromFloat (hei * 1.3))
                                , SvgAttrs.width (String.fromFloat (wid * 1.3))
                                , xlinkHref "picture/light/light_indark.png"
                                , transform ("rotate(" ++ String.fromFloat (90 - alpha / pi * 180.0) ++ "," ++ String.fromFloat (x + rad * cos(alpha)) ++ "," ++ String.fromFloat (-(y + rad * sin(alpha))) ++ ")")
                                ]
                               []
                    ]

                _ ->
                    svgArrow wid hei x y dist (List.drop 1 bank)
                    

        _ ->
            [ Svg.image [  SvgAttrs.x "-500"
                        , SvgAttrs.y "-500"
                        , SvgAttrs.height "0"
                        , SvgAttrs.width "0"
                        , xlinkHref "picture/light/light_indark.png"
                        ]
                        []
            ]


svgCharacter : Float -> Float -> Float -> Float -> Int -> Int -> String -> Kind -> Svg msg
svgCharacter wid hei x y cha_ang model_ang xlink mod =
   case mod of
       Day ->
           let
               x_ = x * cos(pi / 180.0 * toFloat model_ang) - y * sin(pi / 180.0 * toFloat model_ang)
           in

           let
               y_ = x * sin(pi / 180.0 * toFloat model_ang) + y * cos(pi / 180 * toFloat model_ang)
           in

           Svg.image [  SvgAttrs.x ((String.fromFloat (x_ - wid * kx / 2)))
                      , SvgAttrs.y ((String.fromFloat -(y_ + hei * ky / 2)))
                      , SvgAttrs.height (String.fromFloat (hei * ky))
                      , SvgAttrs.width (String.fromFloat (wid * kx))
                      , SvgAttrs.id "Cha"
                      , xlinkHref xlink
                      , transform ("rotate(" ++ String.fromInt -(cha_ang + model_ang) ++ "," ++ String.fromFloat (x_) ++ "," ++ String.fromFloat (-y_) ++ ")")
                     ]
                     []

       Rotate ->
           let
               x_ = x * cos(pi / 180.0 * toFloat model_ang) - y * sin(pi / 180.0 * toFloat model_ang)
           in

           let
               y_ = x * sin(pi / 180.0 * toFloat model_ang) + y * cos(pi / 180 * toFloat model_ang)
           in

           Svg.image [  SvgAttrs.x ((String.fromFloat (x_ - wid * kx / 2)))
                      , SvgAttrs.y ((String.fromFloat -(y_ + hei * ky / 2)))
                      , SvgAttrs.height (String.fromFloat (hei * ky))
                      , SvgAttrs.width (String.fromFloat (wid * kx))
                      , SvgAttrs.id "Cha"
                      , xlinkHref xlink
                      , transform ("rotate(" ++ String.fromInt -(cha_ang) ++ "," ++ String.fromFloat (x_) ++ "," ++ String.fromFloat (-y_) ++ ")")
                     ]
                     []

       Night ->
           Svg.image [  SvgAttrs.x ((String.fromFloat (x - wid / 2)))
                      , SvgAttrs.y ((String.fromFloat -(y + hei / 2)))
                      , SvgAttrs.height (String.fromFloat (hei))
                      , SvgAttrs.width (String.fromFloat (wid))
                      , SvgAttrs.id "Cha"
                      , xlinkHref xlink
                     ]
                     []

       _ ->
           let
               x_ = x * cos(pi / 180.0 * toFloat model_ang) - y * sin(pi / 180.0 * toFloat model_ang)
           in

           let
               y_ = x * sin(pi / 180.0 * toFloat model_ang) + y * cos(pi / 180 * toFloat model_ang)
           in

           Svg.image [  SvgAttrs.x ((String.fromFloat (x_ - wid * kx / 2)))
                      , SvgAttrs.y ((String.fromFloat -(y_ + hei * ky / 2)))
                      , SvgAttrs.height (String.fromFloat (hei * ky))
                      , SvgAttrs.width (String.fromFloat (wid * kx))
                      , SvgAttrs.id "Cha"
                      , xlinkHref xlink
                      , transform ("rotate(" ++ String.fromInt -(cha_ang+model_ang) ++ "," ++ String.fromFloat (x_) ++ "," ++ String.fromFloat (-y_) ++ ")")
                     ]
                     []


svgNight : String -> Float -> Float -> Float -> Float -> Int -> Svg msg
svgNight xlink wid hei x y id =
    let (kx_, ky_) = (1.01, 1)
    in

    Svg.image [ SvgAttrs.x ((String.fromFloat (x - wid / 2)))
              , SvgAttrs.y ((String.fromFloat -((y + hei * (ky_ - 1) / 2) + hei / 2)))
              , SvgAttrs.height (String.fromFloat (hei * ky_))
              , SvgAttrs.width (String.fromFloat (wid * kx_))
              , SvgAttrs.id (String.fromInt id)
              , xlinkHref xlink
              ]
              []

arrowDist : Float
arrowDist = 30.0


imagePreload : List (Svg msg)
imagePreload = [ Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/day_left.png"
                           ]
                           []

               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/day_left_1.png"
                           ]
                           []

               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/day_left_2.png"
                           ]
                           []
                
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/day_right.png"
                           ]
                           []

               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/day_right_1.png"
                           ]
                           []
                       
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/day_right_2.png"
                           ]
                           []

               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_left.png"
                           ]
                           []
                
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_left_1.png"
                           ]
                           []

               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_left_2.png"
                           ]
                           []

               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_right.png"
                           ]
                           []
               
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_right_1.png"
                           ]
                           []
               
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_right_2.png"
                           ]
                           []

               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_up.png"
                           ]
                           []
               
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_up_1.png"
                           ]
                           []
                       
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_up_2.png"
                           ]
                           []

               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_down.png"
                           ]
                           []
                       
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_down_1.png"
                           ]
                           []
               
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/character/night_down_2.png"
                           ]
                           []
                       
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/background/clue_dairy.png"
                           ]
                           []
               
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/background/clue_memory.png"
                           ]
                           []
                       
               , Svg.image [ SvgAttrs.x "-500"
                           , SvgAttrs.y "-500"
                           , SvgAttrs.height "1"
                           , SvgAttrs.width "1"
                           , xlinkHref "picture/background/clue_object.png"
                           ]
                           []
               ]         