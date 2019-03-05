module View exposing (view)

import Browser
import Dom
import Model exposing (Model)
import Route exposing (Route(..))
import Update exposing (Msg)
import View.Footer as FooterView
import View.Header as HeaderView
import View.Hero as HeroView
import View.Section.Details as DetailsView
import View.Section.Speakers as SpeakersView
import View.Section.Sponsors as SponsorsView
import View.Sponsorship as Sponsorship


view : Model -> Browser.Document Msg
view model =
    let
        pageContent content =
            Dom.element "main"
                |> Dom.appendChildList content
                |> Dom.render
                |> List.singleton
    in
    case model.route of
        Sponsorship ->
            { title = "Elm in the Spring 2019 - Become a Sponsor"
            , body = pageContent [ Sponsorship.view model, FooterView.render model ]
            }

        _ ->
            { title = "Elm in the Spring 2019 - Conference"
            , body =
                pageContent
                    [ HeaderView.render model
                    , HeroView.render model
                    , DetailsView.render model
                    , SpeakersView.render model
                    , SponsorsView.render model
                    , FooterView.render model
                    ]
            }
