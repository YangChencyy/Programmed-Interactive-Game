module Clue exposing (..)
import Html exposing (Html, audio, button, div, input, p, text)
import Html.Attributes exposing (autoplay, controls, loop, src, style)
import Html.Events exposing (onClick)
import Message exposing (..)




showClues : Bool -> Int -> Int -> List Int -> Html Msg
showClues pause onShow lan clueList =
    if pause then
        div [  style "width" "100%"
             , style "height" "100%"
             , style "position" "absolute"
             , style "top" "0"
             , style "left" "0"

            ]
            [  div [  style "width" "100%"
                    , style "height" "100%"
                    , style "position" "absolute"
                    , style "top" "0"
                    , style "left" "0"
                    , style "background" "#000"
                    , style "opacity" "0.9"
                    , onClick Resume
                   ]
                   []
             , div [  style "width" (String.fromFloat (1 / 12 * 100) ++ "%")
                    , style "height" "80%"
                    , style "position" "absolute"
                    , style "top" "15%"
                    , style "left" (String.fromFloat ((23 / 120 + 0 / 12 + 0 * 1 / 20) * 100) ++ "%")
                   ]
                   ([back_empty] ++ (listClue [] clueList 0 0 lan))
             , div [  style "width" (String.fromFloat (1 / 12 * 100) ++ "%")
                    , style "height" "80%"
                    , style "position" "absolute"
                    , style "top" "15%"
                    , style "left" (String.fromFloat ((23 / 120 + 1 / 12 + 1 * 1 / 20) * 100) ++ "%")
                   ]
                   ([back_empty] ++ (listClue [] clueList 1 0 lan))
             , div [  style "width" (String.fromFloat (1 / 12 * 100) ++ "%")
                    , style "height" "80%"
                    , style "position" "absolute"
                    , style "top" "15%"
                    , style "left" (String.fromFloat ((23 / 120 + 2 / 12 + 2 * 1 / 20) * 100) ++ "%")
                   ]
                   ([back_empty] ++ (listClue [] clueList 2 0 lan))
             , div [  style "width" (String.fromFloat (1 / 12 * 100) ++ "%")
                    , style "height" "80%"
                    , style "position" "absolute"
                    , style "top" "15%"
                    , style "left" (String.fromFloat ((23 / 120 + 3 / 12 + 3 * 1 / 20) * 100) ++ "%")
                   ]
                   ([back_empty] ++ (listClue [] clueList 3 0 lan))
             , div [  style "width" (String.fromFloat (1 / 12 * 100) ++ "%")
                    , style "height" "80%"
                    , style "position" "absolute"
                    , style "top" "15%"
                    , style "left" (String.fromFloat ((23 / 120 + 4 / 12 + 4 * 1 / 20) * 100) ++ "%")
                   ]
                   ([back_empty] ++ (listClue [] clueList 4 0 lan))
             , aClue pause onShow lan
            ]

    else
        div [] []

back_empty :Html Msg
back_empty =
    div [ style "height" "100%"
        , style "width" "100%"
        , style "position" "absolute"
        , style "top" "0"
        , style "left" "0"
        , onClick Resume
        ] []


listClue : List (Html Msg) -> List Int -> Int -> Int -> Int -> List (Html Msg)
listClue all cha day j lan=
    let
        top =
            String.fromFloat (toFloat j * 20) ++ "%"

        left =
            "10%"

        number =
            case day of
                0 ->
                    if j == 0 then
                        50
                    else if j == 1 then
                        75
                    else
                        76

                1 ->
                    if j == 0 then
                        51
                    else if j == 1 then
                        52
                    else if j == 2 then
                        77
                    else
                        78

                2 ->
                    if j == 0 then
                        53
                    else if j == 1 then
                        54
                    else
                        79

                3 ->
                    if j == 0 then
                        55
                    else if j == 1 then
                        56
                    else if j == 2 then
                        80
                    else
                        81

                _ ->
                    if j == 0 then
                        57
                    else if j == 1 then
                        58
                    else if j == 2 then
                        59
                    else if j == 3 then
                        82
                    else
                        83


        category =
            if lan == 1 then
                case number of
                    50 ->
                        "Memory 1"
                    75 ->
                        "Memory 2"
                    76 ->
                        "Object 1"
                    51 ->
                        "Dairy 1"
                    52 ->
                        "Memory 3"
                    77 ->
                        "Dairy 2"
                    78 ->
                        "Object 2"
                    53 ->
                        "Memory 4"
                    54 ->
                        "Memory 5"
                    79 ->
                        "Memory 6"
                    55 ->
                        "Dairy 3"
                    56 ->
                        "Memory 7"
                    80 ->
                        "Object 3"
                    81 ->
                        "Object 4"
                    57 ->
                        "Memory 8"
                    58 ->
                        "Object 5"
                    59 ->
                        "Memory 9"
                    82 ->
                        "Object 6"
                    83 ->
                        "Object 7"
                    _ ->
                        ""
            else
                case number of
                    50 ->
                        "???????????? 1"
                    75 ->
                        "???????????? 2"
                    76 ->
                        "?????? 1"
                    51 ->
                        "?????? 1"
                    52 ->
                        "???????????? 3"
                    77 ->
                        "?????? 2"
                    78 ->
                        "?????? 2"
                    53 ->
                        "???????????? 4"
                    54 ->
                        "???????????? 5"
                    79 ->
                        "???????????? 6"
                    55 ->
                        "?????? 3"
                    56 ->
                        "???????????? 7"
                    80 ->
                        "?????? 3"
                    81 ->
                        "?????? 4"
                    57 ->
                        "???????????? 8"
                    58 ->
                        "?????? 5"
                    59 ->
                        "???????????? 9"
                    82 ->
                        "?????? 6"
                    83 ->
                        "?????? 7"
                    _ ->
                        ""

        back =
            if List.member number cha then
                "#A33B53"
            else
                "#423b3b"

        n =
            if List.member number cha then
                number
            else
                0

        new =
            button [ style "width" "80%"
                , style "height" (String.fromFloat (1 / 8 * 100) ++ "%")
                , style "position" "absolute"
                , style "top" top
                , style "left" left
                , style "cursor" "pointer"
                , style "background" back
                , style "border" "none"
                , onClick (Clue n 0)
                ]
                [text category]


        j_ = j + 1

        all_ = new :: all
    in

    if (day == 0 && j_ == 3) || (day == 1 && j_ == 4) || (day == 2 && j_ == 3) || (day == 3 && j_ == 4) || (day == 4 && j_ == 5) then
        all_

    else
        listClue all_ cha day j_ lan


aClue : Bool -> Int -> Int -> Html Msg
aClue pause onShow lan =
    if pause && onShow /= 0 then
        if lan == 1 then
            if onShow == 50 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Memory 1"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "Your memory starts here. Off-white sheets, large courtyard covered with withered leaves. This is an orphanage. The yard is always stale, gray, and deadly silent. The only hope in this memory is an accompanying figure. He is the only one who shines happiness to your pale life whenever you feel lost. Though you could not remember his appearance, you found him familiar."]

                ]
            else if onShow == 75 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Memory 2"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "The cake for Sunday had been robbed by elder children again. Do not forget to avoid everyone next time. Today he took the little wood carving which back for you after it was robbed by other child. You remembered the warmth and sense of stability when he fondled your head. ???Mom and dad will bless you in heaven,??? he always said. But in the orphanage, boys who bullied you said you are just a homeless child with no father and mother???"]

                ]
            else if onShow == 76 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Blood Fingerprints"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "Blood fingerprints, blood fingerprints, and blood fingerprints appeared again and again. What were they? They reminded you of the endless nightmare that always wakes you up at night. Why did these blood handprints appeared in your dreams with sharp cries from numerous people? Where did they come from?"]

                ]
            else if onShow == 51 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_dairy.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Dairy 1"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "30%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                            [ p [] [text "1999.08.16. "]
                            , p [] [text "Mom and dad had passed away for four years. I missed them. I was awakened by the nightmare again??? "]
                            , p [] [text "However, Xiaoxiao found brother???s secret. He looked like a reliable brother in front of me, but during the night he cried quietly in his bed???"]
                            ]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "75%"
                            , style "right" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "right"
                           ]
                            [text "Xiao Xiao"]

                ]
            else if onShow == 52 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Memory 3"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "Adults said you must go to school, but you did not like the school. The boy sitting in the front row called you ???bastard??? in front of everyone. Your deskmate sat far away from you as if you were smelly. Teachers seemed to dislike you as well, because you were not smart. In PE class, no team wanted you because you were thin and ran slowly."]

                ]
            else if onShow == 77 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_dairy.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Dairy 2"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "31%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [ p [] [text "2002.10.23"]
                           , p [] [text "Why did???t I have parents? Why did all my classmates know I am an orphan? How do I face their eyes? I never have the chance to get snacks after school brought by my parents, nor do I have change to by a new stationary."]
                           , p [] [text "Stay alone in the corner under the shadow, so that no one will see me."]
                           ]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "75%"
                            , style "right" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "right"
                           ]
                            [text "Xiao Xiao"]
                    ]
            else if onShow == 78 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Bodies and amputated limbs"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "Bodies and amputated limbed all over the ground. On the wrist of a broken arm wearing fragmentized black suit wears a silver watch. With all blood cleaned, the watch showed a time of 2:28 and a word ???Lin XX??? engraved on its back."]

                ]
            else if onShow == 53 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Memory 4"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "One night, brother sat at the front of the bed and talked about mom and dad with you. Mom gave birth to you in her forties, he said. In your childhood, people often regarded mom as your grandma, which made him sad. Hence, mom dyed her hair black every once in a while. Though dad was old as well, his shoulders could still burden heavy goods and wall a long way."]

                ]
            else if onShow == 54 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Memory 5"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "30%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [ p [] [text "He taught you math tonight. When he asked if you still had nightmares at night, you lied."]
                           , p [] [text " He promised you that he would tell you the reason for those strange dreams some day, but you had no courage to tell him the truth, that those dreams appeared more and more often."]
                           , p [] [text "Memories, some fuzzy and some clear, were all into a black net that held you inside. It seemed that you could never get rid of the nightmare???"]
                           ]

                ]
            else if onShow == 79 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "12%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Memory 6"]
                    ,  div [  style "width" "86%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "21%"
                            , style "left" "7%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [ p [] [text "You lied in orphanage and told your brother in sobs that you missed mom and dad and you wanted to go home. He was stunned for a moment, and then quickly choked his tears that almost came out. Sitting by you tenderly and carefully organizing the words, for the first time he told you about the mudslide that destroyed your home. At the time, houses in the village were submerged, and you were trapped in the factory seeing distant torrents coming. Many villagers gave up and stood by windows desperately. The windows were covered with their mud handprints. However, it was mom and dad who did not gave up the last hope and saved you and brother. Dad leaned over and let mom sit on his shoulders. Holding brother and you in her arms, mom lifted you up with all her strength. When the mudslide poured into the factory and gradually engulfed familiar faces, dad stood as high as he could, and mom tried her best to stretch her arms higher. They tried their best to position brother and you safely???"]
                           , p [] [text " Brother said, ???You may not remember in fever at that time??? When the mudslide submerge dad???s shoulder and mom???s knees, they looked up, gazed at you in tears, and said softly, ???Don???t be afraid. Dad loves you, mom loves you??????"]
                           ]

                ]
            else if onShow == 55 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_dairy.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Dairy 3"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "30%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [ p [] [text "2006.04.08"]
                           , p [] [text "Ms.Lin adopted brother and me. Finally we could leave the orphanage. It was said that Ms.Lin is a teacher in brother???s dream high school. Ms.Lin is really a good person. She is the best one to Xiaoxiao other than brother. Thanks to Ms.Lin, brother did not have to be distracted by teaching me when he prepared for high school. I am going to that high school! Together with brother and Ms.Lin!"]
                           ]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "75%"
                            , style "right" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "right"
                           ]
                            [text "Xiao Xiao"]
                ]
            else if onShow == 56 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Memory 8"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "You were admitted. Classmates in high school were friendly, and you had made some good friends. Brother, Ms.Lin, and friends made up all of your life. Staying at either home or school everyday, a simple and peaceful life makes you extremely happy. You were finally living a normal life???"]

                ]
            else if onShow == 80 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "A Note"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "You found a note that seemed to be torn off by some one. It read, ???Who can I write blessings to??????It seems to be your handwriting. You recalled that yesterday was Mother???s Day, and a teacher asked you to write a holiday card to your mothers. This reminded you of your parents??? death. You wrote the words down on your scratch book in sorrow, and quickly tore the note off so that others would not see it???"]

                ]
            else if onShow == 81 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Ghosts"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [ p [] [text "???Why, why ghosts at night seem familiar????"]
                           , p [] [text "???They seem like??? some schoolmates?!???"]
                           , p [] [text "???Is it an illusion??? or????"]
                           ]

                ]
            else if onShow == 57 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Memory 8"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "In addition to staying with friends and brother, you still did???t like to go to or talk in crowded places. Brother was popular in school, as expected, but he still thought of you. He always went to your classroom to see if you have had classes well and prepared to protect you if anyone bullied you; when he bought drinks, he never forgot to bring you one; when you went to canteen with him, he always let you sit at the table and bought lunch for you."]

                ]
            else if onShow == 82 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Birthday Card"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "You prepared a birthday card for brother and bought him a new schoolbag with your pocket money. On the card, you wrote welcome to adulthood and thanked him for taking care of you for the last thirteen years. Why, you recalled that brother is going to college soon, which means you will be separated from him, separated for the first time since birth."]

                ]
            else if onShow == 58 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "The Rings"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "You seemed to have just heard the bell for class. The afternoon sun is shining on the windowsill of the classroom. But the feeling was unreal, because you seemed to feel the brick cracks in the window sill are shaking and cracking little by little.The bell rang in the ear, Teacher Lin walked into the classroom, then, then, the world gradually become distant, abstract, like a random construction of abstract painting, slowly split...You see Miss Lin's watch, the bell rings, just as it always does."]

                ]
            else if onShow == 83 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "13%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "Phantasm"]
                    ,  div [  style "width" "80%"
                            , style "height" "30%"
                            , style "position" "absolute"
                            , style "top" "23%"
                            , style "left" "10%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [ p [] [text "The world is no longer the same, everything seems to be shaking. Familiar faces wore expressions of pain: fear, panic. Their mouths are open and they seem to be Shouting, but there is only a loud roar in your ear and no other voices can be heard, and they seem to have lost the ability to think. Ear, who shouted, Xiao Xiao."]
                           , p [] [text "A huge, sharp, black shadow pressed over like you."]
                           , p [] [text "It's your brother."]
                           , p [] [text "But, why does the world turn so red?"]
                           , p [] [text " What is this, is it an illusion, but why the sadness in your heart seems to overflow; Or, the possibility you're afraid to think about..."]
                           ]

                ]
            else
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "Memory 9"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "It was probably the happiest day you could remember when your friend and brother secretly organized a birthday party for you. When you learned that, you were too surprised to say anything. Your guys were eating the cake, enjoying hot pot together, noisy, but very warm. You just quietly watched everyone laugh, and decided to have this scene deeply engraved in your heart."]
                           ]
        else
            if onShow == 50 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                            , style "user-select" "none"
                           ]
                           [text "?????? 1"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                ]
            else if onShow == 75 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 2"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                ]
            else if onShow == 76 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????????"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????.......??????"]
                ]
            else if onShow == 51 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_dairy.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 1"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "30%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                            [ p [] [text "1999.08.16. "]
                            , p [] [text " ???????????????????????????????????????????????????????????????????????????????????????"]
                            , p [] [text "?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                            ]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "75%"
                            , style "right" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "right"
                           ]
                            [text "??????"]

                ]
            else if onShow == 52 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 3"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                            , style "user-select" "none"
                           ]
                           [text "?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                ]
            else if onShow == 77 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_dairy.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "18%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 2"]
                    ,  div [  style "width" "58%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "31%"
                            , style "left" "21%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ p [] [text "2002.10.23"]
                           , p [] [text "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                           , p [] [text "?????????????????????????????????????????????????????????????????????????????????????????????"]
                           ]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "75%"
                            , style "right" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "right"
                           ]
                            [text "??????"]
                    ]
            else if onShow == 78 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "??????"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                ]
            else if onShow == 53 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 4"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text " ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                ]
            else if onShow == 54 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 5"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "30%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ p [] [text "?????????????????????????????????????????????????????????????????????????????????????????????"]
                           , p [] [text "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                           , p [] [text "???????????????????????????????????????????????????"]
                           ]

                ]
            else if onShow == 79 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "12%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 6"]
                    ,  div [  style "width" "80%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "21%"
                            , style "left" "10%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ p [] [text "?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                           , p [] [text "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                           ]

                ]
            else if onShow == 55 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_dairy.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "18%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 3"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "30%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ p [] [text "2006.04.08"]
                           , p [] [text "???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                           ]
                           ,  div [  style "width" "50%"
                           , style "height" "40%"
                           , style "position" "absolute"
                           , style "top" "75%"
                           , style "right" "25%"
                           , style "font-size" "18px"
                           , style "color" "#fff"
                           , style "text-align" "right"
                           ]
                           [text "??????"]
                ]
            else if onShow == 56 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 7"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                ]
            else if onShow == 80 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "17%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "??????"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "35%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ p [] [text "????????????????????????????????????????????????????????????????????????"]
                           , p [] [text "????????????????????????????????????"]
                           , p [] [text "?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                           ]
                ]
            else if onShow == 81 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "??????"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [ p [] [text " ???????????????????????????????????????????????????????????????????????????"]
                           , p [] [text "????????????????????????????????????????????????"]
                           , p [] [text "??????????????????????????????"]
                           ]

                ]
            else if onShow == 57 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_memory.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 8"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                ]
            else if onShow == 58 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "??????"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????.......?????????????????????????????????????????????????????????????????????"]
                    ]
            else if onShow == 59 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "?????? 9"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                ]
            else if onShow == 82 then
                div [  style "width" "80%"
                     , style "height" "70%"
                     , style "position" "absolute"
                     , style "top" "13%"
                     , style "left" "10%"
                     , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                     , style "opacity" "0.8"
                     , onClick (Clue 0 0)
                    ]
                    [  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "20%"
                            , style "left" "25%"
                            , style "font-size" "24px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [text "??????"]
                    ,  div [  style "width" "60%"
                            , style "height" "30%"
                            , style "position" "absolute"
                            , style "top" "38%"
                            , style "left" "20%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ text "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                    ]
                else
                    div [  style "width" "80%"
                         , style "height" "70%"
                         , style "position" "absolute"
                         , style "top" "13%"
                         , style "left" "10%"
                         , style "background" "url(picture/background/clue_object.png) 0% 0% / 100% 100%"
                         , style "opacity" "0.8"
                         , onClick (Clue 0 0)
                        ]
                        [  div [  style "width" "50%"
                                , style "height" "40%"
                                , style "position" "absolute"
                                , style "top" "13%"
                                , style "left" "25%"
                                , style "font-size" "24px"
                                , style "color" "#fff"
                                , style "text-align" "center"
                               ]
                               [text "??????"]
                        ,  div [  style "width" "80%"
                                , style "height" "30%"
                                , style "position" "absolute"
                                , style "top" "23%"
                                , style "left" "10%"
                                , style "font-size" "18px"
                                , style "color" "#fff"
                                , style "text-align" "left"
                               ]
                               [ p [] [text "?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                               , p [] [text "???????????????????????????????????????"]
                               , p [] [text "???????????????????????????????????????????????????????????????????????????"]
                               , p [] [text "????????????????????????????????????????????????????????????????????????"]
                               , p [] [text "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"]
                               ]
                        ]

        else
             div [] []


