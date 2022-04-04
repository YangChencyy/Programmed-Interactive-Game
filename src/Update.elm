module Update exposing (..)
import Day exposing (msg_day, saveToStorage)
import End exposing (update_end)
import Endmodel exposing (init_end)
import Model exposing (..)
import Message exposing (..)
import Block exposing (..)
import Model exposing (..)
import Game exposing (..)
import Night exposing (msg_night, round5)
import Character exposing (Character, Key(..), cha_init1, cha_init2, cha_init3, cha_init4, cha_init5)
import Trans exposing (..)




update : Msg -> Model -> (Model, Cmd Msg)
update msg allmodel =
    case allmodel of
        Begin opa ->
            if opa >= 1 then
                (Start 0 0 0, Cmd.none)
            else
                let
                    opa_ = opa + 0.004
                in
                (Begin opa_, Cmd.none)

        Start opa1 opa2 opa3 ->
            if opa1 < 1 then
                (Start (opa1 + 0.01) opa2 opa3, Cmd.none)
            else if opa2 < 1 then
                (Start opa1 (opa2 + 0.01) opa3, Cmd.none)
            else if opa3 < 1 then
                (Start opa1 opa2 (opa3 + 0.01), Cmd.none)
            else
                case msg of
                    Startgame1 ->
                        (Intro 1 0, Cmd.none)

                    Startgame2 ->
                        (Intro 2 0, Cmd.none)

                    _ ->
                        (allmodel, Cmd.none)

        Intro lan opa ->
            if opa >= 6 then
                let
                    transmodel_ =
                        case lan of
                            1 ->
                                TransModel 1 5 Up Up 0 "url(picture/character/day_right.png) 0% 0% / 100% 100%" 100 [] 1 4 0 1 1

                            _ ->
                                TransModel 2 5 Up Up 0 "url(picture/character/day_right.png) 0% 0% / 100% 100%" 100 [] 1 4 0 1 1
                in

                (Trans transmodel_, Cmd.none)

            else
                (Intro lan (opa + 0.01), Cmd.none)

        Trans model ->
            model
            |> msg_trans msg

        Game model ->
            case model.mod of
                Day ->
                    model
                    |> msg_day msg

                Night ->
                    model
                    |> msg_night msg

                Rotate ->
                    model
                    |> rotateMap
                    |> saveToStorage

                Darken ->
                    model
                    |> darkenMap
                    |> saveToStorage

        Last lan opa clueList ->
            if opa < 8 then
                (Last lan (opa + 0.008) clueList, Cmd.none)
            else
                (End {init_end | lan = lan, clueList = clueList}, Cmd.none)

        End model ->
                 update_end msg model

        Die lan opa ->
            if opa < 1 then
                (Die lan (opa + 0.01), Cmd.none)
            else
                (allmodel, Cmd.none)

        Choose lan opa ->
            if opa < 7 then
                (Choose lan (opa + 0.01), Cmd.none)
            else
                case msg of
                    Leave ->
                        (EndLeave lan 0, Cmd.none)

                    Stay ->
                        (EndStay lan 0, Cmd.none)

                    _ ->
                        (allmodel, Cmd.none)

        EndStay lan opa ->
            if opa < 2 then
                (EndStay lan (opa + 0.01), Cmd.none)
            else
                (allmodel, Cmd.none)

        EndLeave lan opa ->
            if opa < 10 then
                (EndLeave lan (opa + 0.008), Cmd.none)
            else
                (allmodel, Cmd.none)


rotateMap: GameModel -> GameModel
rotateMap model =  
    let
        opa = model.opacity + 0.002
    in
    
    let
        cha_ =model.cha
    in
    

    if cha_.ang /= 0 then
       let
           cha__ = {cha_ | ang = modBy 360 (cha_.ang + 4)}
       in

       {model | cha = cha__, opacity = opa}

    else if model.ang /= 90 then
            {model | ang = modBy 360 (model.ang + 1), opacity = opa}
    else
        let
            lis = List.map (\someBlock -> {someBlock | x = -someBlock.y, y = someBlock.x}) model.lis
        in
            
        let
            cha = model.cha
        in

        let
            cha___ = {cha | x = -cha.y, y = cha.x}
        in

            {model | lis = lis, cha = cha___, ang = 0, mod = Darken, opacity = opa}


darkenMap : GameModel -> GameModel
darkenMap model =
    let opa = model.opacity
    in


    if opa < 1 then
        {model | opacity = opa + 0.005}
    else 
        let
            lis = List.map (\someBlock -> {someBlock | x = round5 someBlock.x, y = round5 someBlock.y }) model.lis

            lis_ = goNight lis
        in

        let
            cha = model.cha
        in

        let
            cha_ = {cha | right=Up, left=Up, up=Up, down=Up, v_x=0, v_y=0}
        in

        {model | lis = lis_, cha = cha_, mod = Night,opacity = 0}


goNight : Grid -> Grid
goNight lis =
    let
        (wall, other) =
            List.partition (\a -> a.typ == 1 || a.typ == 2 || a.typ == 3) lis

        (monster, other_) =
            List.partition (\a -> a.typ >= 5 && a.typ <= 6) other

        (clues, other__) =
            List.partition (\a -> a.typ >= 75 && a.typ <= 99) other_

        (end, other___) =
            List.partition (\a -> a.typ == 9) other__

        nightwall = List.map (changeLink "picture/block/nightblock.png") wall

        nightmonster = List.map (changeLink "picture/block/monster.png") monster

        nightclue = List.map (changeLink "picture/block/clue.png") clues

        nightEnd = List.map (changeLink "picture/light/light_indark.png") end

        nightBlank = List.map (changeLink "picture/block/white.png") other___

        lis_ = List.concat [nightBlank, nightwall, nightmonster, nightclue, nightEnd]
    in

    lis_


changeLink : String -> Block -> Block
changeLink xlink block =
    {block | xlink = xlink}


msg_trans : Msg -> TransModel -> (Model, Cmd Msg)
msg_trans msg model =
    if model.opa2 > 0 then
        (Trans {model | opa2 = model.opa2 - 0.005}, Cmd.none)

    else if model.now < model.total then
        case msg of
            Next ->
                (Trans {model | now = model.now + 1}, Cmd.none)

            _ ->
                (Trans model, Cmd.none)

    else if model.x >= 88 then
        let
            cha1 = {cha_init1 | candle = model.candle, clueList = model.clueList}

            cha2 = {cha_init2 | candle = model.candle, clueList = model.clueList}

            cha3 = {cha_init3 | candle = model.candle, clueList = model.clueList}

            cha4 = {cha_init4 | candle = model.candle, clueList = model.clueList}

            cha5 = {cha_init5 | candle = model.candle, clueList = model.clueList}
        in

        if model.day == 1 then
            (Game {init_model1 | cha = cha1, lan = model.lan, clueinit = model.clueList, candleinit = model.candle}, Cmd.none)
        else if model.day == 2 then
            (Game {init_model2 | cha = cha2, lan = model.lan, clueinit = model.clueList, candleinit = model.candle}, Cmd.none)
        else if model.day == 3 then
            (Game {init_model3 | cha = cha3, lan = model.lan, clueinit = model.clueList, candleinit = model.candle}, Cmd.none)
        else if model.day == 4 then
            (Game {init_model4 | cha = cha4, lan = model.lan, clueinit = model.clueList, candleinit = model.candle}, Cmd.none)
        else
            (Game {init_model5 | cha = cha5, lan = model.lan, clueinit = model.clueList, candleinit = model.candle}, Cmd.none)

    else
        case msg of
            MoveRight on ->
                model
                |> goRight on

            MoveLeft on ->
                model
                |> goLeft on

            Tick time ->
                model
                |> animate_day 60

            _ ->
                (Trans model, Cmd.none)


goRight : Key -> TransModel -> (Model, Cmd Msg)
goRight on model =
    let
        on_ =
            if on == First then
                if model.left == First then
                    Second
                else
                    on
            else
                on

        off =
            if on == Up then
                if model.left == Second then
                    First
                else
                   model.left
            else
                model.left

        opa_ =
            if model.opa1 > 0 then
                model.opa1 - 0.01
            else
                0

        model_ =
            {model | right = on_, left = off, opa1 = opa_}
    in

    (Trans model_, Cmd.none)


goLeft : Key -> TransModel -> (Model, Cmd Msg)
goLeft on model =
    let
        on_ =
            if on == First then
                if model.right == First then
                    Second
                else
                    on
            else
                on
        off =
            if on == Up then
                if model.right == Second then
                    First
                else
                   model.right
            else
                model.right

        opa_ =
            if model.opa1 > 0 then
                model.opa1 - 0.01
            else
                0

        model_ =
            {model | left = on_, right = off, opa1 = opa_}
    in

    (Trans model_, Cmd.none)


animate_day : Float -> TransModel -> (Model, Cmd Msg)
animate_day elapsed model =
    let
        vx =
            if gt model.right model.left then
                0.5
            else if gt model.left model.right then
                -0.5
            else
                0

        x_ = model.x + vx

        step_ =
              if model.step >= 23 then
                  0
              else
                  if vx == 0 then
                      0
                  else
                      model.step + 1

        opa_ =
            if model.opa1 > 0 then
                model.opa1 - 0.01
            else
                0

        xlink_ =
            if vx > 0 then
                if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                    "url(picture/character/day_right.png) 0% 0% / 100% 100%"
                else if modBy 24 step_ >= 18 then
                    "url(picture/character/day_right_1.png) 0% 0% / 100% 100%"
                else
                    "url(picture/character/day_right_2.png) 0% 0% / 100% 100%"
            else if vx < 0 then
                if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                    "url(picture/character/day_left.png) 0% 0% / 100% 100%"
                else if modBy 24 step_ >= 18 then
                    "url(picture/character/day_left_1.png) 0% 0% / 100% 100%"
                else
                    "url(picture/character/day_left_2.png) 0% 0% / 100% 100%"
            else
                if (model.xlink == "url(picture/character/day_right.png) 0% 0% / 100% 100%" || model.xlink == "url(picture/character/day_right_1.png) 0% 0% / 100% 100%" || model.xlink == "url(picture/character/day_right_2.png) 0% 0% / 100% 100%") then
                    "url(picture/character/day_right.png) 0% 0% / 100% 100%"
                else
                    "url(picture/character/day_left.png) 0% 0% / 100% 100%"

        model_ =
            if x_ >= 5 then
                {model | x = x_, xlink = xlink_, step = step_, opa1 = opa_}
            else
                {model | x = 5, xlink = xlink_, step = step_, opa1 = opa_}

    in

    (Trans model_, Cmd.none)
