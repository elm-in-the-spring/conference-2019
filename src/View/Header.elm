module View.Header exposing (render)

import Dom
import Html.Attributes exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    let
        link location =
            Dom.element "li"
                |> Dom.addClass "Header__link"
                |> Dom.appendChild
                    (Dom.element "a"
                        |> Dom.addAttribute (href ("/#" ++ String.toLower location))
                        |> Dom.appendText location
                    )
    in
    Dom.element "ul"
        |> Dom.addClass "Header__links"
        |> Dom.appendChildList
            [ link "Details"
            , link "Speakers"
            , link "Sponsors"
            ]
