module View.Nav exposing (linkTo, links, render)

import Dom
import Html.Attributes exposing (..)


render : List (Dom.Element msg) -> Dom.Element msg
render navLinks =
    Dom.element "nav"
        |> Dom.addClass "Nav"
        |> Dom.appendChild (links navLinks)


linkTo : String -> Dom.Element msg
linkTo location =
    linkWrapper
        |> Dom.appendChild
            (link location
                |> Dom.replaceAttributeList [ href ("/" ++ location) ]
            )


links : List (Dom.Element msg) -> Dom.Element msg
links additionalLinks =
    Dom.element "ul"
        |> Dom.addClass "Header__links"
        |> Dom.appendChildList
            ([ linkWrapper |> Dom.appendChild (link "Details")
             , linkWrapper |> Dom.appendChild (link "Speakers")
             , linkWrapper
                |> Dom.appendChild
                    (Dom.element "a"
                        |> Dom.addAttribute (href "https://www.youtube.com/elminthespring")
                        |> Dom.addAttribute (target "_blank")
                        |> Dom.appendText "Videos"
                    )
             ]
                ++ additionalLinks
            )


link location =
    Dom.element "a"
        |> Dom.addAttribute (href ("/#" ++ String.toLower location ++ "-heading"))
        |> Dom.appendText location


linkWrapper =
    Dom.element "li"
        |> Dom.addClass "Header__link"
