module Day exposing (..)
import Game exposing (GameModel, Kind(..), init_model1, init_model2, init_model3, init_model4, init_model5)
import Block exposing (..)
import Message exposing (Msg(..))
import Model exposing (Model(..))
import Character exposing (Character, Key(..), cha_init1, cha_init2, cha_init3, cha_init4, cha_init5)



saveToStorage : GameModel -> ( Model, Cmd Msg )
saveToStorage model =
    (Game model, Cmd.none)


msg_day : Msg -> GameModel -> ( Model, Cmd Msg )
msg_day msg model =
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

        CheckWin ->
            model
            |> checkWinDay
            |>saveToStorage

        ChangeGravity ->
            model
            |>changeGravity
            |>saveToStorage

        Pause ->
            if model.pause then
                (Game {model| pause = False},Cmd.none)
            else
                (Game {model| pause = True ,onShow=0},Cmd.none)

        Resume ->
            {model | pause = False}
            |>saveToStorage

        Clue number elapsed->
            model
            |> changeShow number
            |> saveToStorage

        Restart ->
            model
            |> restartDay
            |> saveToStorage

        Tick time ->
            model
            |> animate_day 60
            |> saveToStorage

        _ ->
            (Game model, Cmd.none)


animate_day : Float -> GameModel -> GameModel
animate_day elapsed model =
      let
          (wall, road_) =
              List.partition (\a -> a.typ == 1 || a.typ == 2 || a.typ == 3) model.lis

          (downwall, other) =
              if model.g < 0 then
                  List.partition (\a -> model.cha.y - a.y <= a.len / 2 + model.cha.hei / 2 && model.cha.y - a.y > 0 && (abs (model.cha.x - a.x)) < a.len / 2 + model.cha.wid / 2) wall
              else
                  List.partition (\a -> a.y - model.cha.y <= a.len / 2 + model.cha.hei / 2 && a.y - model.cha.y > 0 && (abs (model.cha.x - a.x)) < a.len / 2 + model.cha.wid / 2) wall

          downwall_ = crackFloor model downwall

          newWall = List.concat [other, downwall_]

          allWall = moveWall model newWall

          (candle, road__) =
               List.partition (\a -> a.typ == 4) road_

          (cha_can, candle_) =
              pickCandle model candle

          (clues, road___) =
              List.partition (\a -> a.typ >= 50 && a.typ < 75) road__

          (clueList, pause, (clues_, onShow)) =
              pickClues model clues

          road = List.concat [candle_ , road___, clues_]

          vx =
              if gt model.cha.right model.cha.left then
                  model.wid / toFloat model.imax / 8 / 1.5
              else if gt model.cha.left model.cha.right then
                  -model.wid / toFloat model.imax / 8 / 1.5
              else
                0

          vy =
              if model.cha.up /= Up && model.cha.jump then
                  sqrt(4.2 * (model.hei / toFloat model.jmax) * abs(model.g))
              else if List.length downwall_ == 0 && (model.cha.ang == 0 || model.cha.ang == 180){-&& model.cha.v_y > -(model.wid / toFloat model.imax - model.cha.wid)-} then
                  model.cha.v_y - abs model.g
              else if List.length downwall_ == 0 then
                  model.cha.v_y
              else
                  0

          jump =
              if model.cha.up /= Up && model.cha.jump then
                  False
              else if List.length downwall /= 0 && model.cha.up == Up then
                  True
              else
                  model.cha.jump

          x_ =
              if model.cha.ang == 0 || model.cha.ang == 180 then
                  if model.cha.x + vx > model.wid / 2 - model.wid /toFloat model.imax / 2 then
                        model.wid / 2 - model.wid /toFloat model.imax / 2
                  else if model.cha.x + vx < -model.wid / 2 + model.wid /toFloat model.imax / 2 then
                        -model.wid / 2 + model.wid /toFloat model.imax / 2
                  else
                  model.cha.x + vx
              else
                  model.cha.x

          y_ =
              if model.g < 0 && model.cha.ang == 0 then
                  model.cha.y + vy
              else if model.g > 0 && model.cha.ang == 180 then
                  model.cha.y - vy
              else
                  model.cha.y

          ang_ =
              if (model.g < 0 && model.cha.ang == 0) || (model.g > 0 && model.cha.ang == 180) then
                  model.cha.ang
              else
                  modBy 360 (model.cha.ang + 4)

          upwall =
              if model.g > 0 then
                  List.filter (\a -> (model.cha.y - a.y) <= a.len / 2 + model.cha.hei / 2 && (model.cha.y - a.y) > 0 && (abs (model.cha.x - a.x)) < a.len / 2 + model.cha.wid / 2 ) allWall
              else
                  List.filter (\a -> -(model.cha.y - a.y) <= a.len / 2 + model.cha.hei / 2 && -(model.cha.y - a.y) > 0 && (abs (model.cha.x - a.x)) < a.len / 2 + model.cha.wid / 2 ) allWall

          vy_ =
              if List.length upwall /= 0 then
                  0
              else
                  vy

          (x__, y__) = checkCollide model.cha.x model.cha.wid model.cha.hei x_ y_ allWall

          newcharacter =
              model.cha

          newList = List.concat [road, allWall]

          step_ =
              if model.cha.step >= 23 then
                  0
              else
                    if vx == 0 then
                        0
                    else
                        model.cha.step + 1

          xlink =
              if model.g < 0 then
                  if vx > 0 then
                      if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                          "picture/character/day_right.png"
                      else if modBy 24 step_ >= 18 then
                          "picture/character/day_right_1.png"
                      else
                          "picture/character/day_right_2.png"
                  else if vx < 0 then
                      if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                          "picture/character/day_left.png"
                      else if modBy 24 step_ >= 18 then
                          "picture/character/day_left_1.png"
                      else
                          "picture/character/day_left_2.png"
                  else
                      if (model.cha.xlink == "picture/character/day_right.png" || model.cha.xlink == "picture/character/day_right_1.png" || model.cha.xlink == "picture/character/day_right_2.png") then
                          "picture/character/day_right.png"
                      else
                          "picture/character/day_left.png"

              else
                  if vx < 0 then
                      if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                          "picture/character/day_right.png"
                      else if modBy 24 step_ >= 18 then
                          "picture/character/day_right_1.png"
                      else
                          "picture/character/day_right_2.png"
                  else if vx > 0 then
                      if modBy 24 step_ < 6 || (modBy 24 step_ < 18 && modBy 24 step_ >= 12) then
                          "picture/character/day_left.png"
                      else if modBy 24 step_ >= 18 then
                          "picture/character/day_left_1.png"
                      else
                          "picture/character/day_left_2.png"
                  else
                      if (model.cha.xlink == "picture/character/day_right.png" || model.cha.xlink == "picture/character/day_right_1.png" || model.cha.xlink == "picture/character/day_right_2.png") then
                          "picture/character/day_right.png"
                      else
                          "picture/character/day_left.png"

          cha_ =
              {newcharacter | x = x__, y = y__, v_x = vx, v_y = vy_, jump = jump, ang = ang_, candle = cha_can, xlink = xlink, clueList = clueList, step = step_}
      in

      {model | cha = cha_, lis = newList, pause = pause, onShow = onShow}


goRight : Key -> GameModel -> GameModel
goRight on model =
    let
        on_ =
            if on == First then
                if model.cha.left == First then
                    Second
                else
                    on
            else
                on

        off =
            if on == Up then
                if model.cha.left == Second then
                    First
                else
                   model.cha.left
            else
                model.cha.left

        character =
            model.cha

        cha_ =
            {character | right = on_, left = off}
    in

    {model | cha = cha_}


goLeft : Key -> GameModel -> GameModel
goLeft on model =
    let
        on_ =
            if on == First then
                if model.cha.right == First then
                    Second
                else
                    on
            else
                on
        off =
            if on == Up then
                if model.cha.right == Second then
                    First
                else
                   model.cha.right
            else
                model.cha.right

        character =
            model.cha

        cha_ =
            {character | left = on_, right = off}
    in

    {model | cha = cha_}


goUp : Key -> GameModel -> GameModel
goUp on model =
    let
        on_ =
            if on == First then
                if model.cha.down == First then
                    Second
                else
                    on
            else
                on
        off =
            if on == Up then
                if model.cha.down == Second then
                    First
                else
                   model.cha.down
            else
                model.cha.down

        character =
            model.cha

        cha_ =
            {character | up = on_ , down = off}
    in

    {model | cha = cha_}


goDown : Key -> GameModel -> GameModel
goDown on model =
    let
        on_ =
            if on == First then
                if model.cha.up == First then
                    Second
                else
                    on
            else
                on
        off =
            if on == Up then
                if model.cha.up == Second then
                    First
                else
                   model.cha.up
            else
                model.cha.up

        character =
            model.cha

        cha_ =
            {character | down = on_, up = off}
    in

    {model | cha = cha_}


changeGravity : GameModel -> GameModel
changeGravity model =
    let
        device =
            List.filter (\a -> a.typ == 2 && ((abs (a.x - model.cha.x) <= 1.5 * a.len && abs(a.y - model.cha.y) <= a.len / 2 - model.cha.hei / 2) || (abs (a.y - model.cha.y) <= 1.5 * a.len && abs (a.x - model.cha.x) <= a.len / 2 - model.cha.wid / 2))) model.lis

        g =
            if List.length device == 0 then
                model.g
            else
                -model.g
    in

    {model|g = g}


checkCollide : Float -> Float -> Float -> Float -> Float -> Grid -> (Float, Float)
checkCollide x wid hei x_ y_ allWall=
    let
        wall_ =
          List.filter (\a -> abs(a.x - x) < a.len / 2 + wid / 2 && abs(a.y - y_) < a.len / 2 + hei / 2) allWall

        y__ =
            case List.head wall_ of
                Just head ->
                    if y_ - head.y > 0 then
                        head.y + head.len / 2 + hei / 2
                    else
                        head.y - head.len / 2 - hei / 2

                _ -> y_

        wall__ =
            List.filter (\a -> abs(a.x - x_) < a.len / 2 + wid / 2 && abs(a.y - y__) < a.len / 2 + hei / 2) allWall

        x__ =
            case List.head wall__ of
                Just head ->
                    if x_ - head.x > 0 then
                        head.x + head.len / 2 + wid / 2
                    else
                        head.x - head.len / 2 - wid / 2

                _ -> x_
    in

    (x__, y__)


crackFloor : GameModel -> Grid -> Grid
crackFloor model downwall=
    let
        (crack, other) =
            if model.mod == Day then
                List.partition (\a -> a.typ == 3) downwall
            else
               ([], downwall)

        crack_ = List.map startCrack crack

        newdown = List.concat [other, crack_]
    in

    newdown


startCrack : Block -> Block
startCrack block =
    {block| move = True}


moveWall : GameModel -> Grid -> Grid
moveWall model wall =
    let
        (move, state) =
            List.partition (\a -> a.move) wall

        move_ =
            List.map (moveBlock model.g wall) move

        wall_ =
            List.concat [state, move_]
    in

        wall_


moveBlock : Float -> Grid -> Block -> Block
moveBlock g wall block =
    let
        vy = block.v_y + g

        vx = block.v_x

        block_ = {block| x = block.x + vx, y = block.y + vy, v_y = vy, v_x = vx}

        downwall =
            if g < 0 then
                List.filter (\a -> (block_.y - a.y) <= block_.len && (block_.y - a.y) > 0 && (abs (block_.x - a.x)) < block_.len) wall
            else
                List.filter (\a -> -(block_.y - a.y) <= block_.len && -(block_.y - a.y) > 0 && (abs (block_.x - a.x)) < block_.len) wall

        block__ =
            case List.head downwall of
                Just downblock ->
                    if g<0 then
                        {block_|move = False, v_y = 0, y = downblock.y + downblock.len}
                    else
                        {block_|move = False, v_y = 0, y = downblock.y - downblock.len}

                _ -> block_
    in

    block__


pickCandle : GameModel -> Grid -> (Float, Grid)
pickCandle model candle =
    let
        (picked, left) =
            List.partition (\a -> abs(a.x - model.cha.x) < a.len / 2 + model.cha.wid / 2 && abs(a.y - model.cha.y) < a.len / 2 + model.cha.hei / 2) candle

        cha_cand =
            if List.length picked /= 0 then
                    model.cha.candle + 20
            else
                    model.cha.candle
        picked_ =
            List.map (\block -> {block | typ = 18, xlink = "picture/block/white.png"}) picked
        can_ =
            if cha_cand > 100 then
                100
            else
                cha_cand
        candle_ = List.append picked_ left
    in

    (can_, candle_)


pickClues : GameModel -> Grid -> (List Int, Bool, (Grid, Int))
pickClues model clues =
    let
        (picked, other) =
            List.partition (\a -> abs(a.x - model.cha.x) < model.cha.wid / 3 && abs(a.y - model.cha.y) < model.cha.hei / 3 ) clues

        clueList =
            case List.head picked of
                Just head ->
                    head.typ :: model.cha.clueList

                _ ->
                    model.cha.clueList

        onShow =
            case List.head picked of
                Just head ->
                    head.typ
                _ ->
                    0

        picked_ =
                List.map (\block -> {block | typ = 18, xlink = "picture/block/white.png"}) picked

        mod =
            if List.length picked == 0 then
                False
            else
                True

        clue_ = List.append other picked_
    in

    (clueList, mod, (clue_, onShow))


checkWinDay : GameModel -> GameModel
checkWinDay model =
    let
        cha_ = model.cha

        cha__ = {cha_ | ang = cha_.ang + (model.ang // 4) * 4}

        end =
            List.filter (\a -> a.typ == 10 && abs(a.x - model.cha.x) < a.len / 2 && abs(a.y - model.cha.y) < a.len / 2) model.lis

        model_ =
            case List.head end of
                Just head ->
                    {model | cha = cha__, mod = Rotate}

                _ ->
                    model
    in

    model_


changeShow : Int -> GameModel ->  GameModel
changeShow number model =
    {model | onShow = number , pause=True}


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

