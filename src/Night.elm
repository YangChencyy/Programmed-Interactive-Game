module Night exposing (..)
import Endmodel exposing (init_end)
import Game exposing (GameModel, Kind(..), init_model1, init_model2, init_model3, init_model4, init_model5)
import Block exposing (..)
import Day exposing (changeShow, checkCollide, goDown, goLeft, goRight, goUp, pickClues, saveToStorage)
import Message exposing (Msg(..))
import Model exposing (Model(..))
import Character exposing (Character, Key(..), cha_init1, cha_init2, cha_init3, cha_init4, cha_init5)
import Trans exposing (..)



msg_night : Msg -> GameModel -> (Model, Cmd Msg)
msg_night msg model =
    case msg of
        MoveRight on ->
            model
            |>goRight on
            |>saveToStorage

        MoveLeft on ->
            model
            |>goLeft on
            |>saveToStorage

        MoveUp on ->
            model
            |>goUp on
            |>saveToStorage

        MoveDown on ->
            model
            |>goDown on
            |>saveToStorage


        Tick time ->
            model
            |> animate_night 60
            |> checkWinNight

        Pause ->
            if model.pause then
                (Game {model| pause = False},Cmd.none)
            else
                (Game {model| pause = True ,onShow=0},Cmd.none)

        Resume ->
            {model|pause = False}
            |>saveToStorage

        Clue number elapsed ->
            model
            |> changeShow number
            |> saveToStorage

        Restart ->
            model
            |> restartDay
            |> saveToStorage
        _ ->
            (Game model, Cmd.none)


animate_night : Float -> GameModel -> GameModel
animate_night elapsed model =
    let
        (wall, road_) =
              List.partition (\a -> a.typ == 1 || a.typ == 2 || a.typ == 3) model.lis

        (monsters, roadwithoutmonster) =
            List.partition (\a -> a.typ >= 5 && a.typ <= 6) road_

        newmonsters =
            List.map (moveMonster wall) monsters
        (clues, roadwmac) =
            List.partition (\a -> a.typ >= 75 && a.typ <= 99) roadwithoutmonster
        (clueList, pause, (clues_, onShow)) =
            pickClues model clues
        road =
            List.concat [newmonsters, clues_, roadwmac]

        vx =
            if gt model.cha.right model.cha.left then
                model.wid / toFloat model.imax / 8 / 2
            else if gt model.cha.left model.cha.right then
                -model.wid / toFloat model.imax / 8 / 2
            else
                0

        vy =
            if gt model.cha.up model.cha.down then
                model.wid / toFloat model.imax / 8 / 2
            else if gt model.cha.down model.cha.up then
                -model.wid/toFloat model.imax / 8 / 2
            else
                0

        step_ =
            if model.cha.step >= 23 then
                0
            else
                if vx == 0 && vy == 0 then
                    0
                else
                   model.cha.step + 1

        xlink =
            if vx > 0 then
                if vy > 0 then
                    if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                        "picture/character/night_up.png"
                    else if modBy 24 step_ >= 18 then
                        "picture/character/night_up_1.png"
                    else
                        "picture/character/night_up_2.png"

                else if vy < 0 then
                    if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                        "picture/character/night_down.png"
                    else if modBy 24 step_ >= 18 then
                        "picture/character/night_down_1.png"
                    else
                        "picture/character/night_down_2.png"

                else
                    if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                        "picture/character/night_right.png"
                    else if modBy 24 step_ >= 18 then
                        "picture/character/night_right_1.png"
                    else
                        "picture/character/night_right_2.png"

            else if vx < 0 then

                if vy > 0 then
                    if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                        "picture/character/night_up.png"
                    else if modBy 24 step_ >= 18 then
                        "picture/character/night_up_1.png"
                    else
                        "picture/character/night_up_2.png"
                else if vy < 0 then
                    if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                        "picture/character/night_down.png"
                    else if modBy 24 step_ >= 18 then
                        "picture/character/night_down_1.png"
                    else
                        "picture/character/night_down_2.png"
                else
                    if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                        "picture/character/night_left.png"
                    else if modBy 24 step_ >= 18 then
                        "picture/character/night_left_1.png"
                    else
                        "picture/character/night_left_2.png"

            else
                if vy > 0 then
                    if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                        "picture/character/night_up.png"
                    else if modBy 24 step_ >= 18 then
                        "picture/character/night_up_1.png"
                    else
                        "picture/character/night_up_2.png"
                else if vy < 0 then
                    if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                        "picture/character/night_down.png"
                    else if modBy 24 step_ >= 18 then
                        "picture/character/night_down_1.png"
                    else
                        "picture/character/night_down_2.png"
                else
                    if (model.cha.xlink == "picture/character/night_right.png" || model.cha.xlink == "picture/character/night_right_1.png" || model.cha.xlink == "picture/character/night_right_2.png") then
                        "picture/character/night_right.png"
                    else if (model.cha.xlink == "picture/character/night_left.png" || model.cha.xlink == "picture/character/night_left_1.png" || model.cha.xlink == "picture/character/night_left_2.png") then
                        "picture/character/night_left.png"
                    else if (model.cha.xlink == "picture/character/night_up.png" || model.cha.xlink == "picture/character/night_up_1.png" || model.cha.xlink == "picture/character/night_up_2.png") then
                        "picture/character/night_up.png"
                    else
                        "picture/character/night_down.png"


        x_ =
            if model.cha.x + vx > model.wid / 2 - model.wid /toFloat model.imax / 2 then
                    model.wid / 2 - model.wid /toFloat model.imax / 2
            else if model.cha.x + vx < -model.wid / 2 + model.wid /toFloat model.imax / 2 then
                    -model.wid / 2 + model.wid /toFloat model.imax / 2
            else
                    model.cha.x + vx

        y_ =
            if model.cha.y + vy > model.hei / 2 - model.hei /toFloat model.jmax / 2 then
                    model.hei / 2 - model.hei /toFloat model.jmax / 2
            else if model.cha.y + vy < -model.hei / 2 + model.hei /toFloat model.jmax / 2 then
                    -model.hei / 2 + model.hei /toFloat model.jmax / 2
            else
                    model.cha.y + vy

        (x__, y__) =
            checkCollide model.cha.x model.cha.wid model.cha.hei x_ y_ wall

        cha = model.cha

        newCha =
            {cha| x = x__, y = y__, v_x = vx, v_y = vy, xlink = xlink, candle = round5(model.cha.candle - 0.01), step = step_, clueList=clueList}

        newCha_ =
            catchCharacter newCha road

        newList =
            List.concat [wall,road]


    in

    {model | lis = newList, cha = newCha_, onShow = onShow ,pause = pause}


moveMonster : Grid -> Block -> Block
moveMonster wall monster =
    let
        vx =
            if monster.typ == 5 then
                if monster.v_x == 0 then
                    monster.len / 16
                else
                    monster.v_x
            else
                0

        vy =
            if monster.typ == 6 then
                if monster.v_y == 0 then
                    monster.len / 16
                else
                    monster.v_y
            else
                0

        x_ =
            monster.x + vx

        y_ =
            monster.y + vy

        (x__, y__) =
            checkCollide monster.x monster.len monster.len x_ y_ wall

        vx_ =
            if x__ /= x_ then
                -vx
            else
                vx

        vy_ =
            if y__ /= y_ then
                -vy
            else
                vy

        x___ =
            x__ + vx_
        y___ =
            y__ + vy_

        (x____, y____) =
            checkCollide x__ monster.len monster.len x___ y___ wall

        vx__ =
            if vx /= vx_ then
                if x____ /= x___ then
                    -vx_
                else
                    vx_
            else
                vx_

        vy__ =
            if vy /= vy_ then
                if y____ /= y___ then
                    -vy_
                else
                    vy_
            else
                vy_

        step_ =
            if monster.step >= 43 then
                1
            else
                if vx_ == 0 && vy_ == 0 then
                    1
                else
                   monster.step + 1

        xlink_ =
            if monster.typ == 5 then
                if vx_ > 0 then
                    if step_ < 6 then
                        "picture/character/ghost_right_up_1.png"
                    else if step_ >= 6 && step_ < 12 then
                        "picture/character/ghost_right_up_2.png"
                    else if step_ >= 12 && step_ < 18 then
                        "picture/character/ghost_right_up_3.png"
                    else if step_ >= 18 && step_ < 24 then
                        "picture/character/ghost_right_up_4.png"
                    else if step_ >= 24 && step_ < 30 then
                        "picture/character/ghost_right_up_5.png"
                    else if step_ >= 30 && step_ < 36 then
                        "picture/character/ghost_right_up_6.png"
                    else
                        "picture/character/ghost_right_up_7.png"

                else if vx_ < 0 then
                    if step_ < 6 then
                        "picture/character/ghost_left_down_1.png"
                    else if step_ >= 6 && step_ < 12 then
                        "picture/character/ghost_left_down_2.png"
                    else if step_ >= 12 && step_ < 18 then
                        "picture/character/ghost_left_down_3.png"
                    else if step_ >= 18 && step_ < 24 then
                        "picture/character/ghost_left_down_4.png"
                    else if step_ >= 24 && step_ < 30 then
                        "picture/character/ghost_left_down_5.png"
                    else if step_ >= 30 && step_ < 36 then
                        "picture/character/ghost_left_down_6.png"
                    else
                        "picture/character/ghost_left_down_7.png"

                else
                    "picture/character/ghost_left_down_1.png"

            else if monster.typ == 6 then
                if vy_ > 0 then
                    if step_ < 6 then
                        "picture/character/ghost_left_down_1.png"
                    else if step_ >= 6 && step_ < 12 then
                        "picture/character/ghost_left_down_2.png"
                    else if step_ >= 12 && step_ < 18 then
                        "picture/character/ghost_left_down_3.png"
                    else if step_ >= 18 && step_ < 24 then
                        "picture/character/ghost_left_down_4.png"
                    else if step_ >= 24 && step_ < 30 then
                        "picture/character/ghost_left_down_5.png"
                    else if step_ >= 30 && step_ < 36 then
                        "picture/character/ghost_left_down_6.png"
                    else
                        "picture/character/ghost_left_down_7.png"
                else
                    if step_ < 6 then
                        "picture/character/ghost_right_up_1.png"
                    else if step_ >= 6 && step_ < 12 then
                        "picture/character/ghost_right_up_2.png"
                    else if step_ >= 12 && step_ < 18 then
                        "picture/character/ghost_right_up_3.png"
                    else if step_ >= 18 && step_ < 24 then
                        "picture/character/ghost_right_up_4.png"
                    else if step_ >= 24 && step_ < 30 then
                        "picture/character/ghost_right_up_5.png"
                    else if step_ >= 30 && step_ < 36 then
                        "picture/character/ghost_right_up_6.png"
                    else
                        "picture/character/ghost_right_up_7.png"
            else
                monster.xlink

    in

    {monster| v_x = vx__, x = x__, v_y = vy__, y = y__, step = step_, xlink = xlink_}


catchCharacter : Character -> Grid -> Character
catchCharacter cha road =
    let
        catch =
            List.filter (\a ->  a.typ >= 5 && a.typ <= 6 && abs(a.x - cha.x) < (a.len / 2 + cha.wid / 2)/1.6 && abs(a.y - cha.y) < (a.len / 2 + cha.hei / 2)/1.3) road
        start =
            List.filter (\a -> a.typ == 10) road
        (xs, ys) =
            case List.head start of
                Just head ->
                    (head.x, head.y)
                _ ->
                    (cha.x, cha.y)

        (x, y, candle) =
            case List.head catch of
                Just monster ->
                    (xs, ys, cha.candle - 3)
                _ ->
                    (cha.x, cha.y, cha.candle)

        newcha =
            {cha | x = x, y = y, candle = candle}
    in

    newcha


round5 : Float -> Float
round5 float=
    let
        n = 100000 * float

        n_ = floor n

        n__ = toFloat n_

        float_ =
            if n == n__ then
                float
            else
                if modBy 10 n_ < 5 then
                    n__ / 100000
                else
                    (n__ + 1) / 100000
    in

    float_


checkWinNight : GameModel -> (Model, Cmd Msg)
checkWinNight model =
    let
        end =
            List.filter (\a -> a.typ == 9 && abs(a.x - model.cha.x) < a.len / 2 && abs(a.y - model.cha.y) < a.len / 2) model.lis

        win =
            case List.head end of
                Just head ->
                    True

                _ ->
                    False

        transmodel =
            case model.day of
                1 ->
                    TransModel model.lan 5 Up Up 0 "url(picture/character/day_right.png) 0% 0% / 100% 100%" model.cha.candle model.cha.clueList 2 3 0 1 1

                2 ->
                    TransModel model.lan 5 Up Up 0 "url(picture/character/day_right.png) 0% 0% / 100% 100%" model.cha.candle model.cha.clueList 3 2 0 1 1

                3 ->
                    TransModel model.lan 5 Up Up 0 "url(picture/character/day_right.png) 0% 0% / 100% 100%" model.cha.candle model.cha.clueList 4 1 0 1 1

                _ ->
                    TransModel model.lan 5 Up Up 0 "url(picture/character/day_right.png) 0% 0% / 100% 100%" model.cha.candle model.cha.clueList 5 2 0 1 1
    in

    if model.cha.candle < model.cha.hei / 2 then
        (Game (restartDay model), Cmd.none)
    else if win && model.day == 5 then
        (Last model.lan 0 model.cha.clueList, Cmd.none)
    else if win then
        (Trans transmodel, Cmd.none)
    else
        (Game model, Cmd.none)



restartDay : GameModel -> GameModel
restartDay model =
    let
        cha1 = {cha_init1 | candle = model.candleinit, clueList = model.clueinit}

        cha2 = {cha_init2 | candle = model.candleinit, clueList = model.clueinit}

        cha3 = {cha_init3 | candle = model.candleinit, clueList = model.clueinit}

        cha4 = {cha_init4 | candle = model.candleinit, clueList = model.clueinit}

        cha5 = {cha_init5 | candle = model.candleinit, clueList = model.clueinit}
    in

    if model.day == 1 then
        {init_model1 | cha = cha1, lan = model.lan, clueinit = model.clueinit, candleinit = model.candleinit}
    else if model.day == 2 then
        {init_model2 | cha = cha2, lan = model.lan, clueinit = model.clueinit, candleinit = model.candleinit}
    else if model.day == 3 then
        {init_model3 | cha = cha3, lan = model.lan, clueinit = model.clueinit, candleinit = model.candleinit}
    else if model.day == 4 then
        {init_model4 | cha = cha4, lan = model.lan, clueinit = model.clueinit, candleinit = model.candleinit}
    else
        {init_model5 | cha = cha5, lan = model.lan, clueinit = model.clueinit, candleinit = model.candleinit}




