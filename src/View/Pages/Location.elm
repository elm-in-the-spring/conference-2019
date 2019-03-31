module View.Pages.Location exposing (view)

import Browser
import Dom
import Model exposing (Model)
import Update exposing (Msg)
import View.Page as Page


view : Model -> Browser.Document Msg
view model =
    { title = "Elm in the Spring - Conference 2019 - Location"
    , body =
        Page.view
            [ "Location", model.platform ]
            [ Dom.element "h1" |> Dom.appendText "Location Placeholder"
            ]
    }
