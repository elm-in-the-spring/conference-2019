module View.Section.Speakers exposing (render)

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
        |> Dom.appendChildList
            [ listingPhoto speaker
            , listingText speaker
            ]


listingPhoto : Speaker -> Dom.Element Msg
listingPhoto speaker =
    SpeakerView.headshot speaker
        |> Dom.addClass "Speaker__headshot--shadow"


titleLink : Speaker -> Dom.Element Msg
titleLink speaker =
    let
        nameString =
            String.replace " " "" speaker.name
    in
    Dom.element "a"
        |> Dom.addAttributeList [ href <| "?speaker=" ++ nameString ]
        |> Dom.appendChild (SpeakerView.talkTitles speaker)
        |> Dom.addClass "Speaker__talk-titles open-popup"


listingText : Speaker -> Dom.Element Msg
listingText speaker =
    Dom.element "div"
        |> Dom.addClass "Speaker__listing-text"
        |> Dom.appendChildList
            [ SpeakerView.name speaker
            , SpeakerView.socialLinks speaker
            , titleLink speaker
            ]
