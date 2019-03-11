module View.Footer exposing (render)

import Dom
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "footer"
        |> Dom.addClass "Footer"
        |> Dom.appendChild content


content =
    Dom.element "div"
        |> Dom.addClass "Footer__content"
        |> Dom.appendChildList
            [ copyright
            , github
            ]


copyright =
    Dom.element "div"
        |> Dom.addClass "Footer__copyright"
        |> Dom.appendText "© Elm in the Spring 2019"


github =
    Dom.element "a"
        |> Dom.addClass "Footer__github u-noUnderline"
        |> Dom.appendChild
            (Dom.element "i" |> Dom.addClass "fab fa-github")
        |> Dom.addAttributeList
            [ href "https://github.com/elm-in-the-spring/conference-2019"
            , target "_blank"
            ]
        |> Dom.appendChildList
            [ Dom.element "span"
                |> Dom.addClass "u-gapBefore"
            , Dom.element "span"
                |> Dom.addClass "u-underline"
                |> Dom.appendText "This site is open-source and written with Elm!"
            ]
