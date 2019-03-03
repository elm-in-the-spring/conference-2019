module View.Sponsorship exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.appendText "SPONSORSHIP PAGE view placeholder"
