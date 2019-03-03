module View.Section.Details exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.appendText "DETAILS section placeholder"
