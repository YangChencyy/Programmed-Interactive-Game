module End exposing (..)
import Html.Attributes exposing (autoplay, controls, loop, src, style)
import Html.Events exposing (onClick)
import Endmodel exposing (EndModel)
import Message exposing (Msg)
import Model exposing (Model(..))
import Message exposing (..)
import Html exposing (Html, audio, button, div, input, p, text)
import Clue exposing (showClues)


update_end : Msg -> EndModel -> (Model, Cmd msg)
update_end msg model =
    if model.try == -1 then
        (Choose model.lan 0, Cmd.none)
    else if model.try == 3 then
        (Die model.lan 0, Cmd.none)
    else
        case msg of
            Endadd num ->
                model
                |> endadd num

            Submit ->
                checkEnd model

            Pause ->
                if model.pause then
                    (End {model| pause = False},Cmd.none)
                else
                    (End {model| pause = True ,onShow=0},Cmd.none)

            Clue number elapsed->
                (End {model | onShow = number , pause = True},Cmd.none)

            Resume ->
                (End {model | pause = False}, Cmd.none)

            _ ->
                (End model, Cmd.none)

endadd : Int -> EndModel -> (Model, Cmd msg)
endadd num model =
    case abs(num) of
        1 -> (End {model| yk = modBy 10(model.yk + 1)}, Cmd.none)
        13 -> (End {model| yk = modBy 10(model.yk - 1)}, Cmd.none)
        2 -> (End {model| yh = modBy 10(model.yh + 1)}, Cmd.none)
        14 -> (End {model| yh = modBy 10(model.yh - 1)}, Cmd.none)
        3 -> (End {model| yt = modBy 10(model.yt + 1)}, Cmd.none)
        4 -> (End {model| ys = modBy 10(model.ys + 1)}, Cmd.none)
        5 -> (End {model| mont = modBy 10(model.mont + 1)}, Cmd.none)
        6 -> (End {model| mons = modBy 10(model.mons + 1)}, Cmd.none)
        7 -> (End {model| dt = modBy 10(model.dt + 1)}, Cmd.none)
        8 -> (End {model| ds = modBy 10(model.ds + 1)}, Cmd.none)
        11 -> (End {model| mint = modBy 10(model.mint + 1)}, Cmd.none)
        12 -> (End {model| mins = modBy 10(model.mins + 1)}, Cmd.none)
        9 -> (End {model| ht = modBy 10(model.ht + 1)}, Cmd.none)
        10 -> (End {model| hs = modBy 10(model.hs + 1)}, Cmd.none)
        15 -> (End {model| yt = modBy 10(model.yt - 1)}, Cmd.none)
        16 -> (End {model| ys = modBy 10(model.ys - 1)}, Cmd.none)
        17 -> (End {model| mont = modBy 10(model.mont - 1)}, Cmd.none)
        18 -> (End {model| mons = modBy 10(model.mons - 1)}, Cmd.none)
        19 -> (End {model| dt = modBy 10(model.dt - 1)}, Cmd.none)
        20 -> (End {model| ds = modBy 10(model.ds - 1)}, Cmd.none)
        23 -> (End {model| mint = modBy 10(model.mint - 1)}, Cmd.none)
        24 -> (End {model| mins = modBy 10(model.mins - 1)}, Cmd.none)
        21 -> (End {model| ht = modBy 10(model.ht - 1)}, Cmd.none)
        22-> (End {model| hs = modBy 10(model.hs - 1)}, Cmd.none)
        _ -> (End model, Cmd.none)


endView : EndModel -> Html Msg
endView model =
    let
        text_ =
            case model.lan of
                1 ->
                    "Please enter the time in the real world"
                _ ->
                    "请输入现实世界的时间"
        text__ =
            case model.lan of
                1 ->
                    "You can recheck the clues you get by press C"
                _ ->
                    "你可以按C键再次查看你所找到的线索。"
    in

    div [ style "height" "100%"
        , style "width" "100%"
        , style "position" "absolute"
        , style "background" "#000"
        , style "top" "0"
        , style "left" "0"
        ]
        [ endCheck model
        , showClues model.pause model.onShow model.lan model.clueList
        , div [  style "height" "8%"
               , style "width" "50%"
               , style "position" "absolute"
               , style "bottom" "1%"
               , style "left" "25%"
               , style "color" "#fff"
               , style "font-family" "Arial"
               , style "font-size" "18px"
               , style "text-align" "center"
              ]
              [text text__]
        , div [  style "height" "8%"
               , style "width" "50%"
               , style "position" "absolute"
               , style "top" "7%"
               , style "left" "25%"
               , style "color" "#fff"
               , style "font-family" "Arial"
               , style "font-size" "24px"
               , style "text-align" "center"
              ]
              [text text_]
        ]


endCheck : EndModel -> Html Msg
endCheck model =
    let
        y_k = model.yk
        y_h = model.yh
        y_s = model.ys
        y_t = model.yt
        mon_t = model.mont
        mon_s = model.mons
        d_t = model.dt
        d_s = model.ds
        min_t = model.mint
        min_s = model.mins
        h_t = model.ht
        h_s = model.hs
        y =
            case model.lan of
                1 ->
                    "Y"
                _ ->
                    "年"

        m =
            case model.lan of
                1 ->
                    "M"
                _ ->
                    "月"

        d =
            case model.lan of
                1 ->
                    "D"
                _ ->
                    "日"

    in

    div [ style "height" "70%"
        , style "width" "50%"
        , style "position" "absolute"
        , style "top" "19%"
        , style "left" "25%"
        ]
        [ render_wheel y_k 5 1
        , render_wheel y_h 10 2
        , render_wheel y_t 15 3
        , render_wheel y_s 20 4
        , render_text y 25
        , render_wheel mon_t 31 5
        , render_wheel mon_s 36 6
        , render_text m 41
        , render_wheel d_t 47 7
        , render_wheel d_s 52 8
        , render_text d 57
        , render_wheel h_t 69 9
        , render_wheel h_s 74 10
        , render_text ":" 79
        , render_wheel min_t 85 11
        , render_wheel min_s 90 12
        , render_submit model.lan model.try
        , render_msg model.lan model.try
        ]



render_wheel : Int -> Int -> Int -> Html Msg
render_wheel show left add =
    div [ style "height" "200px"
        , style "width" "40px"
        , style "position" "absolute"
        , style "top" "0"
        , style "left" (String.fromInt left ++ "%")
        , style "background" "#fff"
        ]
        [ div [ style "position" "absolute"
              , style "height" "100px"
              , style "width" "40px"
              , style "top" "50px"
              , style "line-height" "100px"
              , style "left" "0"
              , style "font-size" "200%"
              , style "text-align" "center"
              , style "user-select" "none"
              ]
              [ text (String.fromInt show)]
        , button [ style "position" "absolute"
              , style "height" "50px"
              , style "width" "40px"
              , style "top" "0"
              , style "left" "0"
              , style "background" "#991f1f"
              , style "line-height" "50px"
              , style "cursor" "pointer"
              , style "border" "none"
              , style "font-size" "200%"
              , style "text-align" "center"
              , onClick (Endadd add)
              ]
              [text "+"]
        , button [ style "position" "absolute"
              , style "height" "50px"
              , style "width" "40px"
              , style "top" "150px"
              , style "left" "0"
              , style "background" "#991f1f"
              , style "line-height" "50px"
              , style "cursor" "pointer"
              , style "border" "none"
              , style "font-size" "200%"
              , style "text-align" "center"
              , onClick (Endadd (add+12))
              ]
              [text "-"]
        ]


render_text : String -> Int -> Html Msg
render_text s left =
    div [ style "height" "200px"
        , style "width" "40px"
        , style "position" "absolute"
        , style "top" "0"
        , style "left" (String.fromInt left ++ "%")
        ]
        [ div [ style "position" "absolute"
              , style "height" "50px"
              , style "width" "40px"
              , style "top" "75px"
              , style "line-height" "50px"
              , style "left" "0"
              , style "color" "#fff"
              , style "font-family" "Arial"
              , style "font-size" "200%"
              , style "text-align" "center"
              , style "user-select" "none"
              ]
              [ text s ]
        ]


render_submit : Int -> Int -> Html Msg
render_submit lan try =
    let
        text_ =
            case lan of
                1 ->
                    "Check"
                _->
                    "确定"
    in

    button [ style "position" "absolute"
           , style "height" "75px"
           , style "width" "25%"
           , style "bottom" "0"
           , style "left" "37.5%"
           , style "background" "#991f1f"
           , style "cursor" "pointer"
           , style "color" "#fff"
           , style "text-align" "center"
           , style "font-family" "Arial"
           , style "font-size" "150%"
           , style "line-height" "50px"
           , onClick Submit
           ]
           [ text text_ ]


render_msg : Int -> Int -> Html Msg
render_msg lan try =
    let
        text1 =
            case lan of
                1 ->
                    "Wrong"
                _ ->
                    "这不是正确的时间"

        text2 =
            case lan of
                1 ->
                    "Win!"
                _ ->
                    "恭喜!"
    in

    if try > 0 then
        div [ style "position" "absolute"
            , style "height" "50px"
            , style "width" "100%"
            , style "bottom" "130px"
            , style "left" "0"
            , style "color" "#fff"
            , style "text-align" "center"
            , style "font-family" "Arial"
            , style "font-size" "200%"
            , style "user-select" "none"
            ]
            [ text text1]
    else if try < 0 then
        div [ style "position" "absolute"
            , style "height" "50px"
            , style "width" "100%"
            , style "bottom" "130px"
            , style "left" "0"
            , style "color" "#fff"
            , style "text-align" "center"
            , style "font-family" "Arial"
            , style "font-size" "200%"
            , style "user-select" "none"
            ]
            [ text text2 ]
    else
        div [] []


checkEnd : EndModel -> (Model, Cmd msg)
checkEnd model =
    if model.yk == 2 && model.yh == 0 && model.yt == 0 && model.ys == 8 && model.mont == 0 && model.mons == 5 && model.dt == 1 && model.ds == 2 && ((model.ht == 1 && model.hs == 4) || (model.ht == 0 && model.hs == 2)) && model.mint == 2 && model.mins == 8 then
        (End {model | try = -1}, Cmd.none)
    else
        (End {model | try = model.try + 1}, Cmd.none)