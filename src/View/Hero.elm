module View.Hero exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.appendText "HERO placeholder"
