module View exposing (..)
import Character exposing (Character)
import End exposing (endView)
import Html exposing (Html, audio, button, div, input, p, text)
import Html.Attributes exposing (autoplay, controls, loop, src, style)
import Html.Events exposing (onClick)
import Shape exposing (svgAll)
import Svg exposing (svg)
import Svg.Attributes
import Clue exposing (..)
import Model exposing (..)
import Message exposing (..)
import Game exposing (..)
import Trans exposing (..)




view : Model -> Html Msg
view allmodel =
    let
        alldiv =
            case allmodel of
                Game model ->
                    gameView model

                Begin opa ->
                    beginView opa

                Start opa1 opa2 opa3 ->
                    startView opa1 opa2 opa3

                Trans model ->
                    transView model

                Intro lan opa ->
                    introView lan opa

                Last lan opa clueList ->
                    lastView lan opa

                End model ->
                    endView model

                Die lan opa ->
                    dieView lan opa

                Choose lan opa ->
                    chooseView lan opa

                EndLeave lan opa ->
                    endLeaveView lan opa

                EndStay lan opa ->
                    endStayView lan opa

        music =
            case allmodel of
                Begin opa ->
                    False

                Start opa1 opa2 opa3 ->
                    False

                _ ->
                    True


        play =
            if music then
                audio
                    [  autoplay True
                     , controls False
                     , src "audio/start.ogg"
                     , style "type" "audio/ogg"
                     , loop True
                    ]
                    [ ]
            else
                div [][]
    in

    div []
        [  alldiv
         , play
        ]

beginView : Float -> Html Msg
beginView opa =
    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" "#000"
         , style "position" "absolute"
        ]
        [  div [  style "height" "50%"
                , style "width" "30%"
                , style "left" "35%"
                , style "top" "20%"
                , style "position" "absolute"
                , style "background" "url(picture/background/logo.jpg) 0% 0% / 100% 100%"
                , style "opacity" (String.fromFloat opa)
                ]
                []
        ]


startView : Float -> Float -> Float -> Html Msg
startView opa1 opa2 opa3 =
    div [  style "height" "100%"
          , style "width" "100%"
          , style "left" "0"
          , style "top" "0"
          , style "background" "url(picture/background/start.png) 0% 0% / 100% 100%"
          , style "position" "absolute"
        ]
        [  div [  style "height" "30%"
                , style "width" "30%"
                , style "left" "15%"
                , style "top" "5%"
                , style "background" "url(picture/background/five.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" (String.fromFloat opa1)
               ]
               []
         , div [  style "height" "30%"
                , style "width" "30%"
                , style "left" "55%"
                , style "top" "5%"
                , style "background" "url(picture/background/days.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" (String.fromFloat opa2)
               ]
               []
         , div [  style "height" "45%"
                , style "width" "15%"
                , style "left" "15%"
                , style "top" "48%"
                , style "background" "url(picture/background/boy.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" (String.fromFloat opa3)
               ]
               []
         , div [  style "height" "42%"
                , style "width" "15%"
                , style "left" "70%"
                , style "top" "50%"
                , style "background" "url(picture/background/girl.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" (String.fromFloat opa3)
               ]
               []
         , button [  style "height" "8%"
                   , style "width" "12%"
                   , style "bottom" "37%"
                   , style "left" "43%"
                   , style "border" "none"
                   , style "background" "url(picture/background/startgame1.png) 0% 0% / 100% 100%"
                   , style "position" "absolute"
                   , style "cursor" "pointer"
                   , onClick Startgame1
                   , style "opacity" (String.fromFloat opa3)
                  ]
                  []
         , button [  style "height" "8%"
                   , style "width" "12%"
                   , style "bottom" "20%"
                   , style "left" "43%"
                   , style "border" "none"
                   , style "background" "url(picture/background/startgame2.png) 0% 0% / 100% 100%"
                   , style "position" "absolute"
                   , style "cursor" "pointer"
                   , onClick Startgame2
                   , style "opacity" (String.fromFloat opa3)
                  ]
                  []
        ]


transView : TransModel -> Html Msg
transView model =
    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" "url(picture/background/trans.png) 0% 0% / 100% 100%"
         , style "position" "absolute"
         , onClick Next
        ]
        [  div [  style "height" "19%"
                , style "width" "5%"
                , style "left" "90%"
                , style "top" "64.5%"
                , style "background" "url(picture/character/boy.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" (String.fromFloat model.opa1)
               ]
               []
         , div [  style "height" "45%"
                , style "width" "17%"
                , style "left" "83%"
                , style "top" "52%"
                , style "background" "url(picture/light/door.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" (String.fromFloat (1 - model.opa1))
               ]
               []
         , div [  style "height" "15%"
                , style "width" "4%"
                , style "left" ((String.fromFloat model.x) ++ "%")
                , style "top" "68.5%"
                , style "background" model.xlink
                , style "position" "absolute"
               ]
               []
         , div [  style "height" "30%"
                , style "width" "50%"
                , style "left" "25%"
                , style "top" "15%"
                , style "background" (imageText model)
                , style "position" "absolute"
               ]
               [ showText model.lan model.day model.now ]
         , div [  style "height" "100%"
                , style "width" "100%"
                , style "left" "0%"
                , style "top" "0%"
                , style "background" "#000"
                , style "position" "absolute"
                , style "opacity" (String.fromFloat model.opa2)
               ]
               []
         , div [  style "height" "1%"
                , style "width" "1%"
                , style "left" "0%"
                , style "top" "0%"
                , style "background" "url(picture/character/day_left.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" "0"
               ]
               []
          , div [  style "height" "1%"
                , style "width" "1%"
                , style "left" "0%"
                , style "top" "0%"
                , style "background" "url(picture/character/day_left_1.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" "0"
               ]
               []
          , div [  style "height" "1%"
                , style "width" "1%"
                , style "left" "0%"
                , style "top" "0%"
                , style "background" "url(picture/character/day_left_2.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" "0"
               ]
               []
          , div [  style "height" "1%"
                , style "width" "1%"
                , style "left" "0%"
                , style "top" "0%"
                , style "background" "url(picture/character/day_right.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" "0"
               ]
               []
          , div [  style "height" "1%"
                , style "width" "1%"
                , style "left" "0%"
                , style "top" "0%"
                , style "background" "url(picture/character/day_right_1.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" "0"
               ]
               []
          , div [  style "height" "1%"
                , style "width" "1%"
                , style "left" "0%"
                , style "top" "0%"
                , style "background" "url(picture/character/day_right_2.png) 0% 0% / 100% 100%"
                , style "position" "absolute"
                , style "opacity" "0"
               ]
               []
        ]


introView : Int -> Float -> Html Msg
introView lan opa =
    let
        (opa1, opa2) =
            if opa < 0.9 then
                (opa, 0)
            else if opa < 1.9 then
                (0.9, opa - 1)
            else
                (0.9, 0.9)

        (opa3, opa4) =
             if opa < 2 then
                 (0, 0)
             else if opa < 2.9 then
                 (opa - 2, 0)
             else if opa < 3.9 then
                 (0.9, opa - 3)
             else
                 (0.9, 0.9)

        text1 =
            if lan == 1 then
                "So suddenly, you open your eyes. You feel a burning in your head, and the world, is spinning.  You try, try to remember what was happening to you, but as you try, a deeper  dizzy feeling occurs to you. The disorderly figures, a revolving world......"
            else
                "你猛得睁开了眼，大脑此刻犹如被烈火焚烧，仿佛天旋地转间，人群的哄乱的喊叫声在渺远处回荡。你努力去回忆发生了什么，却只感受到更深的晕眩感。杂乱的人影，旋转的世界......"

        text2 =
            if lan == 1 then
                "“What...what is this place?”"
            else
                "“这里是……什么地方……”"

        text3 =
            if lan == 1 then
                "“What happening......Why, why I am here?”"
            else
                "“究竟发生了什么……我怎么会在这里……”"

        text4 =
            if lan == 1 then
                "Far away, a figure shows..."
            else
                "远处，似乎有个身影出现……"
    in

    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" "#000"
         , style "position" "absolute"
        ]
        [  div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "20%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa1)
                , style "user-select" "none"
               ]
               [text text1]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "45%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa2)
                , style "user-select" "none"
               ]
               [text text2]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "60%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa3)
                , style "user-select" "none"
               ]
               [text text3]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "75%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa4)
                , style "user-select" "none"
               ]
               [text text4]
        ]


lastView : Int -> Float -> Html Msg
lastView lan opa =
    let
        (opa1, opa2) =
            if opa < 0.9 then
                (opa, 0)
            else if opa < 1.9 then
                (0.9, opa - 1)
            else
                (0.9, 0.9)

        (opa3, opa4, opa5) =
             if opa < 2 then
                 (0, 0, 0)
             else if opa < 2.9 then
                 (opa - 2, 0, 0)
             else if opa < 3.9 then
                 (0.9, opa - 3, 0)
             else if opa < 4.9 then
                 (0.9, 0.9, opa - 4)
             else
                 (0.9, 0.9, 0.9)

        text1 =
            if lan == 1 then
                "Looking at the familiar but strange figure in front of you, you are filled with panic."
            else
                "看着眼前熟悉又陌生的身影，你的心底充满了恐慌。"

        text2 =
            if lan == 1 then
                "“Why, brother, why am I here?”"
            else
                "“哥哥，为什么，为什么我会在这里？”"

        text3 =
            if lan == 1 then
                "“Haven’t you already seen the truth? From now on, I cannot accompany you any longer.”"
            else
                "“你不是，已经看见真相了吗？以后，哥哥不能陪着你了。”"

        text4 =
            if lan == 1 then
                "“Why not? Is it because you are going to college?”"
            else
                "“为什么不能？是，是因为哥哥要去上大学了吗？”"

        text5 =
            if lan == 1 then
                "“Xiaoxiao, I hope so, too. However, this is death, not parting…”"
            else
                "“小小，哥哥也希望是这样啊。可是，是死别，不是生离……”"
    in

    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" "#000"
         , style "position" "absolute"
        ]
        [  div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "15%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "22px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa1)
               ]
               [text text1]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "30%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "22px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa2)
               ]
               [text text2]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "45%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "22px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa3)
               ]
               [text text3]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "60%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "22px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa4)
               ]
               [text text4]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "75%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "22px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa5)
               ]
               [text text5]
        ]


chooseView : Int -> Float -> Html Msg
chooseView lan opa =
    let
        (opa1, opa2, opa3) =
            if opa < 0.9 then
                (opa, 0, 0)
            else if opa < 1.9 then
                (0.9, opa - 1, 0)
            else if opa < 2.9 then
                (0.9, 0.9, opa - 2)
            else
                (0.9, 0.9, 0.9)

        (opa4, opa5, opa6) =
             if opa < 3 then
                 (0, 0, 0)
             else if opa < 3.9 then
                 (opa - 3, 0, 0)
             else if opa < 4.9 then
                 (0.9, opa - 4, 0)
             else if opa < 5.9 then
                 (0.9, 0.9, opa - 5)
             else
                 (0.9, 0.9, 0.9)

        opa7 =
            if opa < 6 then
                0
            else if opa < 6.9 then
                opa - 6
            else
                0.9

        text1 =
            if lan == 1 then
                "You seem to know everything. Yes, the time for now is 2:28pm, May 12 2008."
            else
                "看来，你已经知道了一切。没错，现在的时间就是2008年5月12日下午两点二十八分。"

        text2 =
            if lan == 1 then
                "This place is the dream world your brother created for you when he was dying. You have become timid and introverted since your parents’ death and depended on him very much. How could someone who is so afraid of departing like you accept his death? Therefore, he hoped you could get rid of the childhood nightmare and gain a firm belief in living from the experience in the dream world…"
            else
                "这个世界就是你的哥哥在临死之际，为你创造的梦中世界。你从父母去世，就变得胆小内向，十分依赖他；连生离都难以接受的你，要怎么接受死别呢？所以他希望你能独自经历梦中世界的考验，摆脱童年的梦魇，获得坚定地活下去的信念……"

        text3 =
            if lan == 1 then
                "But now, what is your choice?"
            else
                "但现在，你要怎么选择呢？"

        text4 =
            if lan == 1 then
                "Thousands of days and nights passed, while the real world just went by a moment."
            else
                "梦中万千时日，不过现世须臾一瞬。"

        text5 =
            if lan == 1 then
                "If you stay, you can live with your brother forever; if you leave, the dream will collapse, but you will get a lifelong strong belief. You will not be bothered by the childhood nightmare any more. You will never be stunned by the future."
            else
                "你若留下，可以和哥哥永远生活在这片天地；你若离开，梦境将会崩塌，但你在梦境中获得的坚定信念将一生无法被斩断，未来再无幼时梦魇，不惧前路艰难。"

        text6 =
            if lan == 1 then
                "However, in order to save you, your brother did not stop digging a gap for you even if he was pierced by a steel bar and his hands became bloody… Once you leaved the dream, time in the real world would continue, and he would die soon."
            else
                "只是，你的哥哥在现实中为了救下你，为你寻找到出路，钢筋贯穿依然不忘用手挖开一条缝隙，直到双手鲜血淋漓……一旦离开梦境，梦醒之时，现实的时间将会继续流动，他便会即刻死去。"

        text7 =
            if lan == 1 then
                "Leave"
            else
                "离开"

        text8 =
            if lan == 1 then
                "Stay"
            else
                "留下"
    in

    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" "#000"
         , style "position" "absolute"
        ]
        [  div [  style "width" "70%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "15%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa1)
               ]
               [text text1]
         , div [  style "width" "70%"
                , style "height" "20%"
                , style "position" "absolute"
                , style "top" "22%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa2)
               ]
               [text text2]
         , div [  style "width" "70%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "39%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa3)
               ]
               [text text3]
         , div [  style "width" "70%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "46%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa4)
               ]
               [text text4]
         , div [  style "width" "70%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "53%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa5)
               ]
               [text text5]
         , div [  style "width" "70%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "66%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa6)
               ]
               [text text6]
         , button [ style "position" "absolute"
                  , style "height" "10%"
                  , style "width" "10%"
                  , style "top" "80%"
                  , style "left" "30%"
                  , style "background" "#991f1f"
                  , style "cursor" "pointer"
                  , style "text-align" "center"
                  , style "color" "#fff"
                  , style "font-family" "Arial"
                  , style "font-size" "18px"
                  , style "opacity" (String.fromFloat opa7)
                  , onClick Leave
                  ]
                  [ text text7 ]
         , button [ style "position" "absolute"
                  , style "height" "10%"
                  , style "width" "10%"
                  , style "top" "80%"
                  , style "right" "30%"
                  , style "background" "#991f1f"
                  , style "cursor" "pointer"
                  , style "text-align" "center"
                  , style "color" "#fff"
                  , style "font-family" "Arial"
                  , style "font-size" "18px"
                  , style "opacity" (String.fromFloat opa7)
                  , onClick Stay
                  ]
                  [ text text8 ]
        ]


endLeaveView : Int -> Float -> Html Msg
endLeaveView lan opa =
    let
        (opa1, opa2, opa3) =
            if opa < 0.9 then
                (opa, 0, 0)
            else if opa < 1.9 then
                (0.9, opa - 1, 0)
            else if opa < 2.9 then
                (0.9, 0.9, opa - 2)
            else if opa < 9 then
                (0.9, 0.9, 0.9)
            else
                (0, 0, 0)

        opa4 =
            if opa < 9 then
                0
            else if opa < 9.9 then
                opa - 9
            else
                0.9

        text1 =
            if lan == 1 then
                "You cannot stop crying, but your eyes grow firm. “I see, brother. I… I will go on.”"
            else
                "泪水止不住得从脸上流下，你的眼神渐渐变得坚定，“我明白了哥哥，我会……我会好好走下去的。”"

        text2 =
            if lan == 1 then
                "Brother smiled with relief. His figure turns into light spots all over the sky, and converges into a letter in your hands."
            else
                "哥哥欣慰得笑了，逐渐化作漫天的光点散开，逐渐汇聚成了你手中的一封信。"

        text3 =
            if lan == 1 then
                "Sister:"
            else
                "妹妹："

        text4 =
            if lan == 1 then
                "I only have these limited years to stay with you. I often ask myself if I am responsible enough…"
            else
                "这些年陪伴你的时光有限，我究竟是个尽责的哥哥么……"

        text5 =
            if lan == 1 then
                "What I am most afraid of is that I have to be separated from you some day. The second, is that it is too late to say goodbye to you when the time comes. Sadly, it is finally the time…"
            else
                "我最害怕的是将来某天，不得不与你分别；我第二怕的，是那天来临时，还来不及与你好好道别。可惜，这天终究还是来了……"

        text6 =
            if lan == 1 then
                "I was once confused. We lived at the price of our parents’ death. I do not know what kind of person we become would be worth their effort. One day I came through. I found that the biggest hope from our family is safety and happiness."
            else
                "我也曾经有过迷茫，背负着父母的生命，不知道我和你要成为什么样的人，才对得起他们的付出。后来我想通了，家人对我们最大的期待，就是平安和开心。"


        text7 =
            if lan == 1 then
                "Like mom and dad, they smiled at us even in the last moment of their life, even they were old, even they were suffering… They hoped the last figure in our mind is them smiling."
            else
                "就像爸爸妈妈当年那样，在生命最后一刻，也要笑着看向我们。明明一把年纪，承受着苦难，却依然希望他们印在我们心中最后的样子，是笑着的。"

        text8 =
            if lan == 1 then
                "It is their smile that supports me till now."
            else
                "他们的微笑，让我勇敢地走到了今天。"

        text9 =
            if lan == 1 then
                "I am the same to you———I love you so deeply."
            else
                "我对你也是一样。我深刻地爱着你。"

        text10 =
            if lan == 1 then
                "No matter where I am."
            else
                "无论，我在哪里。"

        text11 =
            if lan == 1 then
                "May you be tenacious of the nightmares. May you be strong and be free of past memories in your bright future."
            else
                "愿你心意坚韧，不被昔时梦魇所扰。愿你未来之路，不受追忆所拌。"

        text12 =
            if lan == 1 then
                "Nightmares will not last forever———life never stops moving on."
            else
                "噩梦会醒，生活终将前行。"
    in

    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" "#000"
         , style "position" "absolute"
        ]
        [  div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "8%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa1)
               ]
               [text text1]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "18%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa2)
               ]
               [text text2]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "30%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "18px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa3)
               ]
               [ p[] [text text3]
               , p[] [text text4]
               , p[] [text text5]
               , p[] [text text6]
               , p[] [text text7]
               , p[] [text text8]
               , p[] [text text9]
               , p[] [text text10]
               ]
         , div [  style "width" "60%"
                , style "height" "20%"
                , style "position" "absolute"
                , style "top" "30%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "24px"
                , style "color" "#fff"
                , style "text-align" "center"
                , style "opacity" (String.fromFloat opa4)
               ]
               [ p[] [text text11]
               , p[] [text ""]
               , p[] [text text12]
               ]
        ]


endStayView : Int -> Float -> Html Msg
endStayView lan opa =
    let
        (opa1, opa2) =
            if opa < 0.9 then
                (opa, 0)
            else if opa < 1.9 then
                (0.9, opa - 1)
            else
                (0.9, 0.9)

        text1 =
            if lan == 1 then
                "”I...I don't want you to be here alone, brother...“"
            else
                " “我，我不要留哥哥一个人，我要陪着哥哥……”"

        text2 =
            if lan == 1 then
                "Brother looks at you with a slight complexity. And finally it turns into a helpless smile, “You, sigh. Still don't grow up? All right...Then stay here and let your brother continue to accompany you, forever.”"
            else
                "哥哥眼神复杂，最后又化为了无奈的笑容，“你，唉。还是长不大吗？也好……那就留在这里，让哥哥继续陪着你吧。”"
    in

    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" "#000"
         , style "position" "absolute"
        ]
        [  div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "35%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "24px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa1)
               ]
               [text text1]
         , div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "45%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "24px"
                , style "color" "#fff"
                , style "opacity" (String.fromFloat opa2)
               ]
               [text text2]
        ]



dieView : Int -> Float -> Html Msg
dieView lan opa =
    let
        opa1 =
            if opa < 0.9 then
                opa
            else
                0.9

        text_ =
            if lan == 1 then
                "You would be left in this world forever..."
            else
                "你永远地留在了这个世界……"
    in

    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" "#000"
         , style "position" "absolute"
        ]
        [  div [  style "width" "60%"
                , style "height" "15%"
                , style "position" "absolute"
                , style "top" "35%"
                , style "left" "20%"
                , style "font-family" "Arial"
                , style "font-size" "24px"
                , style "color" "#fff"
                , style "text-align" "center"
                , style "opacity" (String.fromFloat opa1)
               ]
               [text text_]
        ]


gameView : GameModel -> Html Msg
gameView model =
    let
        url = imageBackground model
    in

    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "background" url
         , style "position" "absolute"
         , style "z-index" "-100"
        ]
        [  div [  style "height" "100%"
                , style "width" "100%"
                , style "position" "absolute"
                , style "left" "0%"
                , style "top" "0"
               ]
               [  renderAll model
               ]
         , div []
               [  dayToNight model
               ]
         , showClues model.pause model.onShow model.lan model.cha.clueList
        ]


renderAll : GameModel -> Html Msg
renderAll model =
    svg
        [  Svg.Attributes.width "100%"
         , Svg.Attributes.height "100%"
         , Svg.Attributes.style " "
         , Svg.Attributes.viewBox  ( "-400 -230 800 460" )
         , Svg.Attributes.preserveAspectRatio("none")
        ]
        (svgAll model)


dayToNight : GameModel -> Html Msg
dayToNight model =
    div [  style "height" "100%"
         , style "width" "100%"
         , style "left" "0"
         , style "top" "0"
         , style "position" "absolute"
         , style "background" "#000"
         , style "opacity" (String.fromFloat model.opacity)
        ]
        []


imageBackground : GameModel -> String
imageBackground model =
    if model.mod == Night then
        "url(picture/background/night.jpg) 0% 0% / 100% 100%"
    else
        if model.day == 1 then
            "url(picture/background/day1.jpg) 0% 0% / 100% 100%"
        else if model.day == 2 then
            "url(picture/background/day2.jpg) 0% 0% / 100% 100%"
        else if model.day == 3 then
            "url(picture/background/day3.jpg) 0% 0% / 100% 100%"
        else if model.day == 4 then
            "url(picture/background/day4.jpg) 0% 0% / 100% 100%"
        else
            "url(picture/background/day5.jpg) 0% 0% / 100% 100%"


imageText : TransModel -> String
imageText model =
    if model.day == 1 then
        if model.now == 0 then
            "url(picture/text/trans1.png) 0% 0% / 100% 100%"
        else if model.now == 4 then
            "url(picture/text/white.png) 0% 0% / 100% 100%"
        else
            "url(picture/text/trans2.png) 0% 0% / 100% 100%"
    else if model.day == 2 then
            if model.now == 1 then
                "url(picture/text/trans1.png) 0% 0% / 100% 100%"
            else if model.now == 3 then
                "url(picture/text/white.png) 0% 0% / 100% 100%"
            else
                "url(picture/text/trans2.png) 0% 0% / 100% 100%"
    else if model.day == 3 then
            if model.now == 0 then
                "url(picture/text/trans1.png) 0% 0% / 100% 100%"
            else if model.now == 2 then
                "url(picture/text/white.png) 0% 0% / 100% 100%"
            else
                "url(picture/text/trans2.png) 0% 0% / 100% 100%"
    else if model.day == 4 then
            if model.now == 0 then
                "url(picture/text/trans2.png) 0% 0% / 100% 100%"
            else
                "url(picture/text/white.png) 0% 0% / 100% 100%"
    else if model.day == 5 then
            if model.now == 0 then
                "url(picture/text/trans1.png) 0% 0% / 100% 100%"
            else if model.now == 2 then
                "url(picture/text/white.png) 0% 0% / 100% 100%"
            else
                "url(picture/text/trans2.png) 0% 0% / 100% 100%"
    else
         if model.now == 0 then
             "url(picture/text/trans1.png) 0% 0% / 100% 100%"
         else if model.now == 1 then
             "url(picture/text/trans2.png) 0% 0% / 100% 100%"
         else
             "url(picture/text/white.png) 0% 0% / 100% 100%"


showText : Int -> Int -> Int -> Html Msg
showText lan day now =
    if lan == 1 then
        if day == 1 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "33%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "color" "#000"
                     , style "user-select" "none"
                     ]
                    [ p [style "font-size" "18px"] [text "Who are you? Where am I? Why, I cannot remember anything?"]
                    , p [style "text-align" "center", style "font-size" "12px"] [text "(Click here to continue)"]]

            else if now == 1 then
                div [  style "width" "85%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "23%"
                     , style "left" "8%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "I am a guard here. Your name is Xiao Xiao. In this world, the day is the reverse of the night. You can try to get your memories back by collecting clues in the maze. Also, by checking the objects you find, thinking about what is happening in the REAL WORLD. You need to press Enter to go into night at the exit of the day."]
           else if now == 2 then
                div [  style "width" "85%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "23%"
                     , style "left" "8%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "You can only see part of the world at night by your candles. In the first night, I will give you some candles, when the light gets faded, you will be lost in the night. Pay attention to the white flowers in the day, they will be the ghosts at night. The blue light at night pointing to the exit of the maze at night. "]
           else if now == 3 then
                div [  style "width" "85%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "20%"
                     , style "left" "8%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "But remember, compared with getting out of the maze, it's much much more important to find out all the memories and clues, which looks as a white light in the maze. You can always press C to check the memories and objects you find, click the clue on the screen to exit each clue and press C or click screen again to exit the Clue list; and press R to restart the day. But remember, you, only get FIVE DAYS. Good luck."]
            else
                div[][]
        else if day == 2 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "37%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "You need to collect candles by yourself in the following days."]
            else if now == 1 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "37%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#000"
                     , style "user-select" "none"
                    ]
                    [text "What are those...ghosts in the night?"]
           else if now == 2 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "34%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "I can't tell you now. But maybe, you would find a way to trap them to protect yourself tomorrow."]
           else
               div[][]
        else if day == 3 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "38%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#000"
                     , style "user-select" "none"
                    ]
                    [text "Are you...are you my brother?"]
            else if now == 1 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "26%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "Just keep going. You would gradually find out. From now on, the world may be felt reversed by your sense. Near the gravity device, press Space to change the gravity of yourself. Take good use of that."]
            else
                div[][]
        else if day == 4 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "35%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "It seems that you have already got parts of the memories back. Go on and find the truth."]
            else
                div[][]
        else if day == 5 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "37%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#000"
                     , style "user-select" "none"
                    ]
                    [text "What is going on in the real world...?"]
            else if now == 1 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "35%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "The last day may be more difficult than you think. Keep going. I'm waiting for you at the end."]
            else
                div[][]
        else
            div[][]
    else
        if day == 1 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "33%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "color" "#000"
                     , style "user-select" "none"
                    ]
                    [p [style "font-size" "18px"] [text "你是谁？这里是什么地方？我怎么，什么都不记得了？"]
                    ,p [style "text-align" "center", style "font-size" "12px"] [text "(点击继续)"]
                    ]
            else if now == 1 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "23%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "我是守关者。你叫小小。在这个世界，黑夜是白天的倒转。你可以通过寻找线索来找寻自己失去的记忆，通过找到的物件信息来判断真实的世界在发生什么。你需要在在白天的出口处按enter进入夜晚。"]
           else if now == 2 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "25%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "到了晚上，你只能看到烛光找到的世界的一部分，第一夜，我会给你一些蜡烛的，光熄灭的的时候，你将会被黑暗吞噬。同时，晚上你身边的光球将指向迷宫出口的地方。注意白天的白花，在晚上会变成鬼魂，小心他们。"]
           else if now == 3 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "28%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "但记住，比起走出这里，更重要的是找寻到自己的记忆和线索。你可以随时按C键查看已经找回的记忆和物品，点击当前线索退出单条线索、再次按C或者点击屏幕退出线索界面；按R键重新开始这一天。你只有五天五夜。"]
            else
                div[][]
        else if day == 2 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "38%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "接下来你需要自己在白天收集蜡烛了。"]
            else if now == 1 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "38%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#000"
                     , style "user-select" "none"
                    ]
                    [text "那夜里的那些鬼魂……是什么？"]
           else if now == 2 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "35%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "我不能告诉你。但也许，你明天可以找到办法把它们困住来保护自己。"]
           else
               div[][]
        else if day == 3 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "38%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#000"
                     , style "user-select" "none"
                    ]
                    [text "你是，你是哥哥吗？？"]
            else if now == 1 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "30%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "继续往后走吧。有些事你渐渐会明白的。从明天起，世界也许会在你的感知下发生颠倒。在重力装置边上，你可以通过按空格键来改变自己的重力，好好运用它吧。"]
            else
                div[][]
        else if day == 4 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "38%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "看来你已经找回了部分的记忆和线索，继续找寻真相吧。"]
            else
                div[][]
        else if day == 5 then
            if now == 0 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "38%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#000"
                     , style "user-select" "none"
                    ]
                    [text "外面究竟发生了什么……？"]
            else if now == 1 then
                div [  style "width" "80%"
                     , style "height" "50%"
                     , style "position" "absolute"
                     , style "top" "38%"
                     , style "left" "10%"
                     , style "font-family" "Arial"
                     , style "font-size" "18px"
                     , style "color" "#fff"
                     , style "user-select" "none"
                    ]
                    [text "最后一天可能比你想象得更加艰难，加油吧，我在最后等着你。"]
            else
                div[][]
        else
            div[][]


