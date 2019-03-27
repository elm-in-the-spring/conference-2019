module View.SpeakerOverlay exposing (render)

import Dom
import Html
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Route
import Speaker exposing (Speaker)
import Update exposing (Msg(..))
import View.Speaker as SpeakerView


render : Model -> Dom.Element Msg
render model =
    Dom.element "section"
        |> Dom.addClass "SpeakerOverlay"
        |> Dom.addAttributeList
            [ Attr.attribute "role" "dialog"
            ]
        |> Dom.addClassConditional "u-hidden" (not <| Model.modalIsOpen model)
        |> Dom.setId "speaker-details"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "SpeakerOverlay__content"
                |> addContent model.speakerModal
            )


addContent speakerModal =
    case speakerModal of
        Nothing ->
            Dom.appendNode
                (Html.text "")

        Just speaker ->
            Dom.appendChildList
                [ close
                , speaekerInfo speaker
                , divider
                , talkInfo speaker
                ]


speaekerInfo speaker =
    Dom.element "section"
        |> Dom.addClass "SpeakerOverlay__speaker-info"
        |> Dom.appendChildList
            [ SpeakerView.headshot speaker
            , name speaker
            , bio speaker
            ]


talkInfo speaker =
    Dom.element "section"
        |> Dom.addClass "SpeakerOverlay__talk-info"
        |> Dom.appendChildList
            [ SpeakerView.talkTitles speaker
            , abstract speaker
            ]


name speaker =
    Dom.element "div"
        |> Dom.addClass "SpeakerOverlay__speaker-name"
        |> Dom.appendChildList
            [ SpeakerView.name speaker
            , SpeakerView.socialLinks speaker
            ]


close =
    Dom.element "a"
        |> Dom.addAttributeList
            [ href "/"
            , Attr.attribute "aria-label" "close"
            ]
        |> Dom.addAction ( "click", CloseSpeakerOverlay )
        |> Dom.addClassList [ "Button", "SpeakerOverlay__close", "eits-close" ]


bio speaker =
    Dom.element "p"
        |> Dom.addClass "SpeakerOverlay__bio"
        |> Dom.appendText speaker.bio


abstract speaker =
    Dom.element "p"
        |> Dom.addClass "SpeakerOverlay__abstract"
        |> Dom.appendText speaker.talkAbstract


divider =
    Dom.element "div"
        |> Dom.addClass "SpeakerOverlay__divider"
        |> Dom.appendChildList
            (List.repeat 3 (Dom.element "i" |> Dom.addClass "eits-leaf"))
