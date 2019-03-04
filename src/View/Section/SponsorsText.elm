module View.Section.SponsorsText exposing (render)

import Dom
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "section"
        |> Dom.addClass "page-section section-sponsors-b"
        |> Dom.appendText "SPONSORS TEXT section placeholder"
