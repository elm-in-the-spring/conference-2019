module View.Divider exposing (render)

import Dom


render =
    Dom.element "div"
        |> Dom.addClass "Divider"
