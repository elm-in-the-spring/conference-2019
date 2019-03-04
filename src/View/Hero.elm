module View.Hero exposing (render)

import Dom


render : Dom.Element msg
render =
    Dom.element "div"
        |> Dom.addClass "section-hero"
        |> Dom.appendChildList
            [ Dom.element "div"
            , Dom.element "div"
                |> Dom.appendText "HERO section placeholder"
            ]
