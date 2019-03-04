module View.Section.Speakers exposing (render)

import Dom
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "section"
        |> Dom.addClass "page-section section-speakers"
        |> Dom.appendText "SPEAKERS section placeholder"
