module Message exposing (..)
import Character exposing (Key(..), Character)



type Msg = MoveLeft Key
         | MoveRight Key
         | MoveUp Key
         | MoveDown Key
         | ChangeGravity
         | CheckWin
         | Tick Float
         | Startgame1
         | Startgame2
         | Next
         | Clue Int Float
         | Pause
         | Resume
         | Restart
         | Endadd Int
         | Submit
         | Leave
         | Stay
         | Noop