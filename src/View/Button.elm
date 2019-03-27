module View.Button exposing (offset)

import Dom
import Html exposing (Attribute)


offset : Attribute msg -> String -> Dom.Element msg
offset href textContent =
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
                    |> Dom.appendText textContent
                )
    in
    Dom.element "a"
        |> Dom.addAttribute href
        |> Dom.addClass "Button Button--offset"
        |> addInterior
