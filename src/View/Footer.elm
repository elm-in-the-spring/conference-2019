module View.Footer exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.appendText "FOOTER placeholder"
