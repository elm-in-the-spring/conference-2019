module View.Section.Details exposing (render)

import Dom
import Html.Attributes as Attr exposing (..)


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.addClass "section-details"
        |> Dom.appendChildList
            [ Dom.element "div"
            , Dom.element "div"
                |> Dom.appendText "DETAILS section placeholder"
            ]
