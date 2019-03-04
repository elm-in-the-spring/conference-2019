module View.Footer exposing (render)

import Dom
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "div"
        |> Dom.addClass "footer"
        |> Dom.appendText "FOOTER placeholder"
