module View exposing (view)

import Browser
import Dom
import Model exposing (Model)
import Route exposing (Route(..))
import Update exposing (Msg)
import View.Pages.Home as HomePage
import View.Pages.Schedule as SchedulePage
import View.Pages.Sponsorship as SponsorshipPage


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Schedule ->
            SchedulePage.view model

        Sponsorship ->
            SponsorshipPage.view model

        _ ->
            HomePage.view model
