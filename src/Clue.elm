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
                        "记忆碎片 1"
                    75 ->
                        "记忆碎片 2"
                    76 ->
                        "物品 1"
                    51 ->
                        "日记 1"
                    52 ->
                        "记忆碎片 3"
                    77 ->
                        "日记 2"
                    78 ->
                        "物品 2"
                    53 ->
                        "记忆碎片 4"
                    54 ->
                        "记忆碎片 5"
                    79 ->
                        "记忆碎片 6"
                    55 ->
                        "日记 3"
                    56 ->
                        "记忆碎片 7"
                    80 ->
                        "物品 3"
                    81 ->
                        "物品 4"
                    57 ->
                        "记忆碎片 8"
                    58 ->
                        "物品 5"
                    59 ->
                        "记忆碎片 9"
                    82 ->
                        "物品 6"
                    83 ->
                        "物品 7"
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
                           [text "The cake for Sunday had been robbed by elder children again. Do not forget to avoid everyone next time. Today he took the little wood carving which back for you after it was robbed by other child. You remembered the warmth and sense of stability when he fondled your head. “Mom and dad will bless you in heaven,” he always said. But in the orphanage, boys who bullied you said you are just a homeless child with no father and mother…"]

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
                            , p [] [text "Mom and dad had passed away for four years. I missed them. I was awakened by the nightmare again… "]
                            , p [] [text "However, Xiaoxiao found brother’s secret. He looked like a reliable brother in front of me, but during the night he cried quietly in his bed…"]
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
                           [text "Adults said you must go to school, but you did not like the school. The boy sitting in the front row called you “bastard” in front of everyone. Your deskmate sat far away from you as if you were smelly. Teachers seemed to dislike you as well, because you were not smart. In PE class, no team wanted you because you were thin and ran slowly."]

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
                           , p [] [text "Why did’t I have parents? Why did all my classmates know I am an orphan? How do I face their eyes? I never have the chance to get snacks after school brought by my parents, nor do I have change to by a new stationary."]
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
                           [text "Bodies and amputated limbed all over the ground. On the wrist of a broken arm wearing fragmentized black suit wears a silver watch. With all blood cleaned, the watch showed a time of 2:28 and a word “Lin XX” engraved on its back."]

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
                           , p [] [text "Memories, some fuzzy and some clear, were all into a black net that held you inside. It seemed that you could never get rid of the nightmare…"]
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
                           [ p [] [text "You lied in orphanage and told your brother in sobs that you missed mom and dad and you wanted to go home. He was stunned for a moment, and then quickly choked his tears that almost came out. Sitting by you tenderly and carefully organizing the words, for the first time he told you about the mudslide that destroyed your home. At the time, houses in the village were submerged, and you were trapped in the factory seeing distant torrents coming. Many villagers gave up and stood by windows desperately. The windows were covered with their mud handprints. However, it was mom and dad who did not gave up the last hope and saved you and brother. Dad leaned over and let mom sit on his shoulders. Holding brother and you in her arms, mom lifted you up with all her strength. When the mudslide poured into the factory and gradually engulfed familiar faces, dad stood as high as he could, and mom tried her best to stretch her arms higher. They tried their best to position brother and you safely…"]
                           , p [] [text " Brother said, “You may not remember in fever at that time… When the mudslide submerge dad’s shoulder and mom’s knees, they looked up, gazed at you in tears, and said softly, ‘Don’t be afraid. Dad loves you, mom loves you…”"]
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
                           , p [] [text "Ms.Lin adopted brother and me. Finally we could leave the orphanage. It was said that Ms.Lin is a teacher in brother’s dream high school. Ms.Lin is really a good person. She is the best one to Xiaoxiao other than brother. Thanks to Ms.Lin, brother did not have to be distracted by teaching me when he prepared for high school. I am going to that high school! Together with brother and Ms.Lin!"]
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
                           [text "You were admitted. Classmates in high school were friendly, and you had made some good friends. Brother, Ms.Lin, and friends made up all of your life. Staying at either home or school everyday, a simple and peaceful life makes you extremely happy. You were finally living a normal life…"]

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
                           [text "You found a note that seemed to be torn off by some one. It read, “Who can I write blessings to…”It seems to be your handwriting. You recalled that yesterday was Mother’s Day, and a teacher asked you to write a holiday card to your mothers. This reminded you of your parents’ death. You wrote the words down on your scratch book in sorrow, and quickly tore the note off so that others would not see it…"]

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
                           [ p [] [text "“Why, why ghosts at night seem familiar?”"]
                           , p [] [text "“They seem like… some schoolmates?!”"]
                           , p [] [text "“Is it an illusion… or?”"]
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
                           [text "In addition to staying with friends and brother, you still did’t like to go to or talk in crowded places. Brother was popular in school, as expected, but he still thought of you. He always went to your classroom to see if you have had classes well and prepared to protect you if anyone bullied you; when he bought drinks, he never forgot to bring you one; when you went to canteen with him, he always let you sit at the table and bought lunch for you."]

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
                           [text "记忆 1"]
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
                           [text "你的记忆从这里开始。灰白色的床单，落满枯叶的大庭院。这是一家孤儿院。陈旧，灰暗，与长久不变的静谧，是这里恒久不变的感觉。这里唯一的光，是一个形影相伴的身影，你觉得，每一次你失落的时候，他都像一束阳光一样给你的生命带来颜色。可是你总是无法记起他的容貌，却给你一种无比熟悉的感觉。"]
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
                           [text "记忆 2"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "周日的小蛋糕又被大孩子抢走了。下次一定要躲着所有人。今天他帮你抢回了你自己做的小木雕，你记得他抚摸着你的头时的那种温暖和踏实。他总说，爸爸妈妈会在天上保佑你。可以福利院里，那些欺负你的男孩子却说，你说个没有家的孩子了，你没有爸爸，没有妈妈了……"]
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
                           [text "血手印"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "血手印，血手印，你看见了满墙的血手印，又出现了。是什么？？这让你想起了那个重复不断的噩梦，那个让你一次又一次在夜里惊醒的梦魇。为什么时常在夜晚，你的脑海里总出现这些带着血的手印；你都会听到许许多多人尖锐的呼喊声在你的耳中响起。那是什么.......？！"]
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
                           [text "日记 1"]
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
                            , p [] [text " 爸爸妈妈离开四年了，我好想他们。昨天晚上又被噩梦惊醒了……"]
                            , p [] [text "但是小小发现了哥哥的小秘密。在我面前，他是哥哥的模样，所以必须要坚强。但是每到深夜，回到自己被窝里，哥哥他，也会偷偷地哭的……"]
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
                            [text "小小"]

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
                           [text "记忆 3"]
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
                           [text "大人说一定要去上学，可你不喜欢去学校。前面的男孩子当着所有人的面骂你是“杂种”。你的同桌把椅子搬的离你很远，好像你身上有什么奇怪的味道一样。老师好像也不太喜欢你，因为你不是什么聪明的孩子。体育课的时候你因为瘦小跑步好慢，没有队伍愿意要你。"]
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
                           [text "日记 2"]
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
                           , p [] [text "父母，为什么我没有父母，为什么我所有的同学都知道我是孤儿？我要再怎么面对他们的眼神？我永远没有机会在放学时得到父母带来的小点心，也没有零花钱去小店铺买一个新出现的文具。"]
                           , p [] [text "一个人呆着吧，呆在角落，呆在墙角的影子下，就没有人会看到我了。"]
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
                            [text "小小"]
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
                           [text "断肢"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "冥冥之中，你又听到了人群喧吵的声音——满地的尸体，和残肢。一截断手臂，残缺的西装上沾满了血迹；手腕上银色腕表，擦干血迹后看见时间为两点二十八分，腕表背面刻着“林思远”字样。"]
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
                           [text "记忆 4"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text " 有天晚上，哥哥坐在床头，和你一起回忆爸爸妈妈。他说，妈妈是四十多岁才生下你们，小时候，妈妈常常被人认成你们的奶奶，哥哥总会偷偷难过。于是妈妈每隔一段时间就会染一次头发。爸爸年纪很大了，但那双苍老的手，依然能扛起很重的大米，走很远的山路。"]
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
                           [text "记忆 5"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "30%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ p [] [text "他今天晚上又教你做题目了。他问我晚上还会不会做噩梦。我撒谎了。"]
                           , p [] [text "他答应了我以后会告诉我那些过往的奇怪的梦的来源；你却没有勇气对他说真话，那些梦越来越多，模糊的记忆与清晰的记忆交织成黑色的把你兜在其中。"]
                           , p [] [text "你似乎永远无法摆脱掉这个梦魇了……"]
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
                           [text "记忆 6"]
                    ,  div [  style "width" "80%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "21%"
                            , style "left" "10%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ p [] [text "你躺在福利院的床上哽咽地跟哥哥说，你想爸爸，想妈妈，想回家了。哥哥一愣，随即把差点流出的眼泪硬憋回去，他立刻温柔地坐在你身边，慎重地组织着语言……那是他第一次对你说，那晚泥石流的景象……当说，当时村子里的房屋都淹没了，你们被困在村里的工厂里，远处是呼啸而来的洪流。很多村民都放弃了，他们绝望得堵在窗户边，印上一双又一双泥手印。但是，爸爸突然俯身，让妈妈跨坐在他的肩上，妈妈也是一手抱起你，一手抱起哥哥，用尽力气将你们抬高。他们竭尽所能得讲你们兄妹置于高处。泥石流涌入工厂，逐渐吞没一张张熟悉的脸。爸爸靠在墙边尽可能站得高高的，妈妈坐着爸爸肩上，靠着墙壁将身子挺直，恨不得将你和哥哥伸到全世界最安全的高度……"]
                           , p [] [text "哥哥说，那时候你发着高烧，可能不记得……当泥石流没过爸爸肩膀，没过妈妈膝盖……他们抬头，含泪注视你们，温柔地说：“宝贝别怕，爸爸爱你，妈妈爱你……”"]
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
                           [text "日记 3"]
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
                           , p [] [text "林老师收养了我和哥哥，终于可以离开福利院了。听说林老师是哥哥想考的高中的老师。林老师可真是个好人，是除了哥哥以外，对小小最好的人了。多亏了林老师，哥哥才不用一边准备中考，一边教我了。小小也要考到那所高中！和哥哥和林老师在一起！"]
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
                           [text "小小"]
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
                           [text "记忆 7"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "你最终考上了想去的高中。你的同学都很和善，你也交到几个好朋友。哥哥，林老师，两三个好友，构成了你生活的全部。每天在学校和家之间来回，简单而平静的生活却让你觉得无比幸福。生活似乎走入了正轨……"]
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
                           [text "纸条"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "35%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ p [] [text "你捡到了一张纸条，似乎是被人撕下来的，上面写着："]
                           , p [] [text "“我能给谁写祝福呢……”"]
                           , p [] [text "这，似乎是你自己的字迹。你想起来，昨天是母亲节，老师要求你们给妈妈写一张节日祝福，这让你又一次想起了父母的死，难过之下写在自己的草稿纸上，怕别人看见，又匆匆撕掉了……"]
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
                           [text "幽魂"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "center"
                           ]
                           [ p [] [text " “为什么，为什么夜晚的怪物，会给我一种熟悉的感觉？"]
                           , p [] [text "好像，好像学校的一些……同学？！"]
                           , p [] [text "是错觉吗……还是？”"]
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
                           [text "记忆 8"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "除了和朋友、哥哥呆在一起之外，你还是不喜欢去人多的地方，也不敢在人多的地方说话。哥哥性格那么好，不出所料得在学校很受欢迎，但哥哥总是跑到你们年纪来看你过的好不好、有没有人欺负你；去小卖部买饮料，总不会忘了你一瓶；去食堂吃饭时，总是让你坐好等着，去替你打饭。"]
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
                           [text "铃声"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "你似乎刚刚听到了上课的铃声，下午的阳光洒在教室的窗台上。但这种感觉很不真实，因为你似乎觉得窗台的砖缝正在一点一点的震动、裂开。铃声在耳边响着，林老师走进课堂，然后，然后，世界逐渐变得渺远，抽象，像一幅随意搭建的抽象画，慢慢的裂开.......你看到了林老师的手表，铃声，还一如既往的响着。"]
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
                           [text "记忆 9"]
                    ,  div [  style "width" "50%"
                            , style "height" "40%"
                            , style "position" "absolute"
                            , style "top" "40%"
                            , style "left" "25%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [text "那可能是你记忆里最快乐的一天了吧，朋友和哥哥一起偷偷组织给你庆生。当你得知时，惊喜得什么话也说不出来。你们一边吃着蛋糕，一边吃着火锅，大家吵吵闹闹的，却很温馨。你只静静得看着大家笑，却把决定把眼前这一幕深深地刻在心里。"]
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
                           [text "贺卡"]
                    ,  div [  style "width" "60%"
                            , style "height" "30%"
                            , style "position" "absolute"
                            , style "top" "38%"
                            , style "left" "20%"
                            , style "font-size" "18px"
                            , style "color" "#fff"
                            , style "text-align" "left"
                           ]
                           [ text "这是你准备送给哥哥的生日贺卡，你打算在哥哥生日当天送给他，还用攒起来的零花钱给哥哥买了新书包。贺卡上面着对他的成年快乐，也感谢他过去十三年来代替父母对你无微不至的照顾。是啊，你想起来哥哥马上就要上大学了，这意味着你和哥哥马上就要分来了，是出生以来，第一次分开。"]
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
                               [text "幻象"]
                        ,  div [  style "width" "80%"
                                , style "height" "30%"
                                , style "position" "absolute"
                                , style "top" "23%"
                                , style "left" "10%"
                                , style "font-size" "18px"
                                , style "color" "#fff"
                                , style "text-align" "left"
                               ]
                               [ p [] [text "世界不在是原来的样子，一切似乎都在颤抖。平时熟悉的人们的脸上带痛苦的表情：是恐惧、是慌乱。他们张着嘴，似乎在大声疾呼，但你的耳边只有巨大的轰鸣声，听不见其他人的声音，似乎也失去了思考的能力。"]
                               , p [] [text "耳边，谁喊了一声“小小”。"]
                               , p [] [text "一个巨大的巨大的，尖锐的，黑色的阴影像你压了过来。"]
                               , p [] [text "是哥哥，是哥哥吗？为什么眼前的世界变得一片鲜红？"]
                               , p [] [text "这是什么，是幻觉吗，可是为什么你心中的悲伤就像要溢出来了一样；还是，那个你不敢去想的可能……"]
                               ]
                        ]

        else
             div [] []


