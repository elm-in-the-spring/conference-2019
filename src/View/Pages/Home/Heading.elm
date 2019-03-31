module View.Pages.Home.Heading exposing (render)

import Dom


render : String -> String -> Dom.Element msg
render modifierString textContent =
    Dom.element "h2"
        |> Dom.addClass ("Section__heading Section__heading--" ++ modifierString)
        |> Dom.appendText textContent
