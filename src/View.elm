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
    let
        { title, body } =
            case model.route of
                Schedule ->
                    SchedulePage.view model

                Sponsorship ->
                    SponsorshipPage.view model

                _ ->
                    HomePage.view model

        conference2020Header : Dom.Element Msg
        conference2020Header =
            Dom.element "div"
                |> Dom.appendText "Elm in the Spring will be back May 1, 2020!"
                |> Dom.setId "header2020"

        content =
            Dom.element "div"
                |> Dom.appendChild conference2020Header
                |> Dom.appendNodeList body
                |> Dom.render
    in
    { title = title
    , body = [ content ]
    }
