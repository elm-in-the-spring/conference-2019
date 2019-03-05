module View exposing (view)

import Browser
import Dom
import Model exposing (Model)
import Update exposing (Msg)
import View.Footer as FooterView
import View.Header as HeaderView
import View.Hero as HeroView
import View.Section.Details as DetailsView
import View.Section.Speakers as SpeakersView
import View.Section.Sponsors as SponsorsView


view : Model -> Browser.Document Msg
view model =
    let
        pageContent =
            Dom.element "main"
                |> Dom.appendChildList
                    [ HeaderView.render model
                    , HeroView.render model
                    , DetailsView.render model
                    , SpeakersView.render model
                    , SponsorsView.render model
                    , FooterView.render model
                    ]
                >> Dom.render
    in
    { title = "Elm in the Spring 2019"
    , body = [ pageContent ]
    }
