module View.Section.SponsorsLogos exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.addClass "section-sponsors-a"
        |> Dom.appendText "SPONSORS LOGOS section placeholder"
