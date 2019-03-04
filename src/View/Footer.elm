module View.Footer exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.addClass "footer"
        |> Dom.appendText "FOOTER placeholder"
