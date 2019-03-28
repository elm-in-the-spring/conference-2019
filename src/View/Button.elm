module View.Button exposing (offset)

import Dom
import Html exposing (Attribute)


offset : Attribute msg -> String -> Dom.Element msg
offset href textContent =
    Dom.element "a"
        |> Dom.addAttribute href
        |> Dom.addClass "Button Button--offset"
        |> addInterior textContent


addText content =
    Dom.appendChild
        (Dom.element "span"
            |> Dom.addClass "Button__text"
            |> Dom.appendText content
        )


addInterior textContent =
    Dom.appendChild
        (Dom.element "div"
            |> Dom.addClass "Button__interior"
            |> addText textContent
        )
