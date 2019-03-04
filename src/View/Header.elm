module View.Header exposing (render)

import Dom
import Html.Attributes exposing (..)


render : Dom.Element msg
render =
    Dom.element "header"
        |> Dom.addClass "header"
        |> Dom.appendChild links


links : Dom.Element msg
links =
    let
        link location =
            Dom.element "li"
                |> Dom.addClass "mr-6"
                |> Dom.appendChild
                    (Dom.element "a"
                        |> Dom.addClass "text-blue no-underline hover:text-blue-darker"
                        |> Dom.addAttribute (href ("#section-" ++ String.toLower location))
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
