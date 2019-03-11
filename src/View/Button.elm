module View.Button exposing (offset)

import Dom
import Html.Attributes exposing (href)



offset target textContent =
    let
        addInterior =
            Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "Button__interior"
                |> addText
            )

        addText =
            Dom.appendChild
            (Dom.element "span"
                |> Dom.addClass "Button__text"
                |> Dom.appendText textContent)
    in
    Dom.element "a"
        |> Dom.addAttribute (href target)
        |> Dom.addClass "Button Button--offset"
        |> addInterior


