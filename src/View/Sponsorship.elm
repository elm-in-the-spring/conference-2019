module View.Sponsorship exposing (render)

import Dom
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "div"
        |> Dom.appendText "SPONSORSHIP PAGE view placeholder"
