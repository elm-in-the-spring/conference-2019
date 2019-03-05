module View.Footer exposing (render)

import Dom
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "footer"
        |> Dom.addClass "footer"
        |> Dom.appendChild content


content =
    Dom.element "div"
        |> Dom.addClass "flex justify-around text-blue text-lg text-center"
        |> Dom.appendChildList
            [ copyright
            , github
            ]


copyright =
    Dom.element "div"
        |> Dom.appendText "© Elm in the Spring 2019"


github =
    Dom.element "a"
        |> Dom.addClass "text-blue"
        |> Dom.addAttributeList
            [ href "https://github.com/elm-in-the-spring/conference-2019"
            , target "_blank"
            ]
        |> Dom.appendText "This site is open-source and written with Elm!"
