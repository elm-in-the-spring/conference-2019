module View.Section.SponsorsText exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.addClass "section-sponsors-b"
        |> Dom.appendText "SPONSORS TEXT section placeholder"
