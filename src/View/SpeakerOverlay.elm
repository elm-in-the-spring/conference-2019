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
    let
        addContent =
            case model.speakerModal of
                Nothing ->
                    Dom.appendNode
                        (Html.text "")

                Just speaker ->
                    Dom.appendChildList
                        [ SpeakerView.headshot (Debug.log "SPEAKER" speaker)
                        , SpeakerView.name speaker
                        , SpeakerView.socialLinks speaker
                        , SpeakerView.talkTitles speaker
                        , bio speaker
                        , abstract speaker
                        , close
                        ]
    in
    Dom.element "section"
        |> Dom.addClass "SpeakerOverlay popup"
        |> Dom.addClassConditional "u-hidden" (not <| Model.modalIsOpen <| model)
        --|> Dom.setId "speaker-details"
        |> Dom.setId "popup-article"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "popup__block"
                |> addContent
            )


close : Dom.Element Msg
close =
    Dom.element "a"
        |> Dom.addAttributeList [ href "/" ]
        |> Dom.addAction ( "click", CloseSpeakerOverlay )
        |> Dom.addClass "popup__close"
        |> Dom.appendText "close"


bio : Speaker -> Dom.Element msg
bio speaker =
    Dom.element "div"
        |> Dom.addClass "SpeakerOverlay__bio"
        |> Dom.appendText speaker.bio


abstract : Speaker -> Dom.Element msg
abstract speaker =
    Dom.element "div"
        |> Dom.addClass "SpeakerOverlay__abstract"
        |> Dom.appendText speaker.talkAbstract
