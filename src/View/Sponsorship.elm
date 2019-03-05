module View.Sponsorship exposing (view)

import Dom
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Dom.Element Msg
view _ =
    Dom.element "div"
        |> Dom.appendText "SPONSORSHIP PAGE view placeholder"
