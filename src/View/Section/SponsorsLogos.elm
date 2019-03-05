module View.Section.SponsorsLogos exposing (render)

import Dom
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "section"
        |> Dom.setId "sponsors"
        |> Dom.addClass "section-sponsors-a"
        |> Dom.appendText "SPONSORS LOGOS section placeholder"
