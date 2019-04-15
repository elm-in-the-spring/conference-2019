module View.Pages.Home exposing (view)

import Browser
import Dom
import Model exposing (Model)
import Update exposing (Msg)
import View.Divider as Divider
import View.Page as Page
import View.Pages.Home.Details as Details
import View.Pages.Home.Hero as Hero
import View.Pages.Home.SpeakerOverlay as SpeakerOverlay
import View.Pages.Home.Speakers as Speakers
import View.Pages.Home.Sponsors as Sponsors


view : Model -> Browser.Document Msg
view model =
    { title = "Elm in the Spring 2019 - Conference"
    , body =
        Page.view
            [ "Home", model.platform ]
            [ Hero.render model
            , Divider.render
            , Details.render model
            , Speakers.render model
            , Sponsors.render model
            , SpeakerOverlay.render model
            ]
    }
