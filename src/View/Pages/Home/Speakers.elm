module View.Pages.Home.Speakers exposing (render)

import Dom
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Route
import Speaker exposing (Speaker)
import Update exposing (Msg)
import View.Speaker as SpeakerView


render : Model -> Dom.Element Msg
render model =
    Dom.element "section"
        |> Dom.setId "speakers"
        |> Dom.addClass "Section Section--speakers"
        |> Dom.appendChildList
            [ Dom.element "div"
            , Dom.element "div"
                |> Dom.appendChildList
                    [ heading
                    , content model
                    ]
            ]


heading =
    Dom.element "div"
        |> Dom.addClass "Section__heading"
        |> Dom.appendChild
            (Dom.element "h2"
                |> Dom.appendText "Speakers"
                |> Dom.setId "speakers-heading"
                |> Dom.addAttribute (Attr.tabindex -1)
            )


content : Model -> Dom.Element Msg
content model =
    Dom.element "div"
        |> Dom.addClass "Section__content"
        |> Dom.appendChildList (List.map listing model.speakers)


listing : Speaker -> Dom.Element Msg
listing speaker =
    Dom.element "div"
        |> Dom.addClass "Section__speaker-listing"
        |> Dom.appendChild (speakerInfo speaker)


titleLink : Speaker -> Dom.Element Msg
titleLink speaker =
    linkToModal speaker
        |> Dom.appendChild (SpeakerView.talkTitles speaker)
        |> Dom.addClass "Speaker__talk-titles open-popup"


linkToModal speaker =
    Dom.element "a"
        |> Dom.addAttribute (href <| "?speaker=" ++ String.replace " " "" speaker.name)


headshot speaker =
    linkToModal speaker
        |> Dom.addClass "Speaker__headshot-container"
        |> Dom.appendChild
            (SpeakerView.headshot speaker
                |> Dom.addClass "Speaker__headshot--shadow"
            )


speakerInfo speaker =
    Dom.element "section"
        |> Dom.addClass "Speaker__listing-info"
        |> Dom.appendChildList
            [ headshot speaker
            , listingName speaker
            , titleLink speaker
            ]


listingName speaker =
    Dom.element "div"
        |> Dom.addClass "Speaker__listing-name"
        |> Dom.appendChildList
            [ SpeakerView.name speaker
            , SpeakerView.socialLinks speaker
            ]
