module View exposing (view)

import Browser
import Dom
import Model exposing (Model)
import Route exposing (Route(..))
import Update exposing (Msg)
import View.Pages.Home as HomePage
import View.Pages.Location as LocationPage
import View.Pages.Schedule as SchedulePage
import View.Pages.Speakers as SpeakersPage
import View.Pages.Sponsorship as SponsorshipPage


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Speakers ->
            SpeakersPage.view model

        Schedule ->
            SchedulePage.view model

        Location ->
            LocationPage.view model

        Sponsorship ->
            SponsorshipPage.view model

        _ ->
            HomePage.view model
