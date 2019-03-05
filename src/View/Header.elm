module View.Header exposing (render)

import Dom
import Html.Attributes exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "header"
        |> Dom.addClass "header biko uppercase"
        |> Dom.appendChild links


links : Dom.Element Msg
links =
    let
        link location =
            Dom.element "li"
                |> Dom.addClass "mr-6"
                |> Dom.appendChild
                    (Dom.element "a"
                        |> Dom.addClass "text-blue no-underline hover:text-blue-darker"
                        |> Dom.addAttribute (href ("#" ++ String.toLower location))
                        |> Dom.appendText location
                    )
    in
    Dom.element "ul"
        |> Dom.addClass "list-reset flex text-2xl justify-center content-center"
        |> Dom.appendChildList
            [ link "Details"
            , link "Speakers"
            , link "Sponsors"
            ]
