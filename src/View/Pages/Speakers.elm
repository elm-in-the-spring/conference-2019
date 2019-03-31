module View.Pages.Speakers exposing (view)

import Browser
import Dom
import Model exposing (Model)
import Update exposing (Msg)
import View.Footer as Footer
import View.Page as Page


view : Model -> Browser.Document Msg
view model =
    { title = "Elm in the Spring - Conference 2019 - Speakers"
    , body =
        Page.view
            [ "Speakers", model.platform ]
            [ Dom.element "h1" |> Dom.appendText "Speakers Placeholder"
            ]
    }
