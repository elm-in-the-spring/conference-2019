module View.Hero exposing (render)

import Dom
import Html.Attributes exposing (src, alt)
import Model exposing (Model)
import Update exposing (Msg)
import View.Button as Button
import Svg exposing (..)
import Svg.Attributes exposing (width, height, viewBox, points, id)
import View.Header as Header

render : Model -> Dom.Element Msg
render model =
    Dom.element "div"
        |> Dom.addClass "Hero"
        |> Dom.appendChildList
            [ Dom.element "div"
                |> Dom.addClass "Hero__content"
                |> Dom.appendChildList
                    [ flower
                    , header model
                    , main_
                    ]
            ]
            |> Dom.appendChild clippy





flower =
    Dom.element "div"
        |> Dom.addClass "Hero__flower"

header model =
    Dom.element "h1"
        |> Dom.addClass "Hero__header"
        |> Dom.appendChild (Header.render model)

main_ =
    Dom.element "div"
        |> Dom.addClass "Hero__main"
        |> Dom.appendChildList [mainContent, ctaButton]


mainContent =
    let
        elm =
            Dom.element "span"
                |> Dom.appendText "elm"
                |> Dom.addClass "Hero__brand--elm"

        inThe =
            Dom.element "span"
                |> Dom.appendText "in the"
                |> Dom.addClass "Hero__brand--in-the"

        elmInThe =
            Dom.element "span"
                |> Dom.appendChildList [elm, inThe]
                |> Dom.addClass "Hero__brand--elm-in-the"

        spring =
            Dom.element "span"
                |> Dom.addClass "Hero__brand--spring"
                |> Dom.appendText "spring"

    in
    Dom.element "h1"
        |> Dom.addClass "Hero__brand"
        |> Dom.appendChildList [elmInThe, spring]

-- ------------------------------------------------------------ old














logoImage =
    Dom.element "div"
        |> Dom.addClass "Hero__logo"
        |> Dom.appendChild
            (Dom.element "img"
                |> Dom.addAttributeList
                    [ src "/images/flower.svg"
                    , alt "logo flower"
                    ]
            )


logoText =
    Dom.element "div"
        |> Dom.addClass "Hero__logo-text"
        |> Dom.appendChild
            (Dom.element "img"
                |> Dom.addAttributeList
                    [ src "/images/text.svg"
                    , alt "Elm in the Spring Conference on April 26, 2019 in Chicago"
                    ]
            )


textContent =
    Dom.element "div"
        |> Dom.addClass "Hero__text"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "u-cursorText"
                |> Dom.appendText "A day to learn, teach, and share about Elm!"
            )


ctaButton =
    Dom.element "div"
        |> Dom.addClass "Hero__attend-cta"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "ButtonContainer ButtonContainer--offset ButtonContainer--centered"
                |> Dom.appendChild (Button.offset "#details" "Attend")
            )


logoAsText =
    Dom.element "h1"
        |> Dom.appendText "Elm in the Spring Conference on April 26, 2019 in Chicago"
        |> Dom.addClass "u-hidden"


clippy =
    let
        shape =
            svg
                [ viewBox "0 0 157 191"
                --, width "155.6"
                --, height "191"
                ]
                [ defs
                    []
                    [clipPath
                        [ id "clip-logo" ]
                        [ polygon [ points "20 59 44 83 44 35 20 59" ] []
                        , polygon [ points "51 34 75 58 75 111 51 87 51 34" ] []
                        , polygon [ points "79 0 106 26 79 53 52 27 79 0" ] []
                        , polygon [ points "131 62 82 62 82 111 131 62" ] []
                        , polygon [ points "75 116 0 116 75 191 75 116" ] []
                        , polygon [ points "82 191 157 116 82 116 82 191" ] []
                        , polygon [ points "109 32 85 56 132 56 109 32" ] []
                        ]
                    ]
                ]

    in
    Dom.element "div"
        |> Dom.appendNode shape
        |> Dom.addClass "u-zeroSize"
        --|> Dom.addClass "u-hidden"





                --[ viewBox "0 0 157 191"
                --, id "clip-logo"
                --, width "155.6"
                --, height "191"
                --]

--clipPath =
--    let
--        shape =
--            svg
--                [
--                ]
--                []
--                [ viewBox "0 0 157 191"
--                , id "clip-logo"
--                , width "155.6"
--                , height "191"
--                ]
--                [ polygon [ points "20 59 44 83 44 35 20 59" ] []
--                , polygon [ points "51 34 75 58 75 111 51 87 51 34" ] []
--                , polygon [ points "79 0 106 26 79 53 52 27 79 0" ] []
--                , polygon [ points "131 62 82 62 82 111 131 62" ] []
--                , polygon [ points "75 116 0 116 75 191 75 116" ] []
--                , polygon [ points "82 191 157 116 82 116 82 191" ] []
--                , polygon [ points "109 32 85 56 132 56 109 32" ] []
--                ]
--    in
--    Dom.element "div"
--        |> Dom.appendNode shape
--        |> Dom.addClass "u-hidden"
