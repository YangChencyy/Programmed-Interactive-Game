module Main exposing (..)
import Endmodel exposing (init_end)
import Game exposing (..)
import Browser
import Browser.Events exposing (onAnimationFrameDelta, onKeyDown, onKeyPress, onKeyUp)
import Html.Events exposing (keyCode)
import Json.Decode as Decode
import View exposing (..)
import Update exposing (..)
import Message exposing (..)
import Model exposing (..)
import Character exposing (Key(..))
import Trans exposing (..)



main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : () -> (Model, Cmd Msg)
init _ =
    (Begin 0, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ case model of
            Game gamemodel ->
                if gamemodel.pause then
                    onAnimationFrameDelta (Clue gamemodel.onShow)
                else
                    onAnimationFrameDelta Tick
            _ ->
                onAnimationFrameDelta Tick
         , onKeyUp (Decode.map (key Up) keyCode)
         , onKeyDown (Decode.map (key First) keyCode)
         , onKeyPress (Decode.map pressKey keyCode)
        ]


key : Key -> Int -> Msg
key on keycode =
    case keycode of
        37 ->
            MoveLeft on

        39 ->
            MoveRight on

        38 ->
            MoveUp on

        40 ->
            MoveDown on

        87 ->
            MoveUp on

        65 ->
            MoveLeft on

        83 ->
            MoveDown on

        68 ->
            MoveRight on

        67 ->
            if on == First then
                Pause
            else
                Noop
        82 ->
            Restart

        _ ->
            Noop


pressKey : Int -> Msg
pressKey keycode =
    case keycode of
        32 ->
            ChangeGravity

        13 ->
            CheckWin

        _ ->
            Noop