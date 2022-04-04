module Model exposing (..)
import Character exposing (Character)
import  Endmodel exposing (EndModel)
import Game exposing (..)
import Trans exposing (..)



type Model = Begin Float
           | Start Float Float Float
           | Intro Int Float
           | Game GameModel
           | Trans TransModel
           | Last Int Float (List Int)
           | End EndModel
           | Die Int Float
           | Choose Int Float
           | EndLeave Int Float
           | EndStay Int Float


