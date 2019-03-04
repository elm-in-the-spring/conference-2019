module View.Section.Speakers exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.addClass "section-speakers"
        |> Dom.appendText "SPEAKERS section placeholder"
