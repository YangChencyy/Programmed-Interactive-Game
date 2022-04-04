module Block exposing (..)
import Character exposing (Key(..), Character)




type alias Block =
               {  i     : Int
                , j     : Int
                , typ   : Int
                , x     : Float
                , y     : Float
                , len   : Float
                , move  : Bool
                , v_x   : Float
                , v_y   : Float
                , xlink : String
                , step  : Int
                , id    : Int
               }


type alias Grid =
               List Block


generate : Float -> Float -> Grid -> Int -> Int -> Int -> Int -> List Int -> Int -> Grid
generate wid hei grid i_temp j_temp i_max j_max list day =
    let
        typ =
            Maybe.withDefault 0 (List.head (List.drop (j_temp * (i_max + 1) + i_max - i_temp) list))

        len =
            wid / toFloat (i_max + 1)

        x =
            -wid / 2 + len / 2 + len * toFloat (i_max - i_temp)

        y =
            hei / 2 - len / 2 - len * toFloat j_temp

        xlink = imageBlock typ day

        id = i_temp * i_max + j_temp + 1

        newBlock =
            Block (i_max - i_temp) j_temp typ x y len False 0 0 xlink 1  id

        newMap = List.append [newBlock] grid
        
    in

        if i_temp == i_max && j_temp == j_max then
            newMap
        else if i_temp == i_max then
            generate wid hei newMap 0 (j_temp + 1) i_max j_max list day
        else
            generate wid hei newMap (i_temp + 1) j_temp i_max j_max list day


gt : Key -> Key -> Bool
gt key1 key2 =
    if key1 == Up then
        False
    else if key1 == Second then
        True
    else
        if key2 == Up then
            True
        else
            False


imageBlock : Int -> Int -> String
imageBlock typ day =
    if typ == 0 || typ == 9 || typ == 10 then
        "picture/block/white.png"
    else if typ == 1 then
        if day == 1 then
            "picture/block/block1.png"
        else if day == 2 then
            "picture/block/block2.png"
        else if day == 3 then
            "picture/block/block3.png"
        else if day == 4 then
            "picture/block/block4.png"
        else
            "picture/block/block5.png"
    else if typ == 2 then
        "picture/block/device.png"
    else if typ == 3 then
        if day == 2 then
            "picture/block/crack2.png"
        else if day == 3 then
            "picture/block/crack3.png"
        else if day == 4 then
            "picture/block/crack4.png"
        else if day == 5 then
            "picture/block/crack5.png"
        else
            "picture/block/crack2.png"
    else if typ == 4 then
        "picture/block/candle.png"
    else if typ == 5 then
        "picture/block/flower.png"
    else if typ == 6 then
        "picture/block/flower.png"
    else if typ >= 50 && typ < 75 then
        "picture/block/clue.png"
    else
        "picture/block/white.png"


rotate : Block -> Block
rotate block =
    {block | x = block.y, y = -block.x}