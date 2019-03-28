port module Update exposing (Msg(..), update)

import Browser
import Browser.Dom
import Browser.Navigation as Nav
import ContactForm
import Http
import Maybe.Extra as Maybe
import Model exposing (Model)
import Route exposing (Route(..))
import Speaker exposing (Speaker)
import Task
import Url


type Msg
    = NoOp
    | ContactFormMsg ContactForm.Msg
    | OnUrlRequest Browser.UrlRequest
    | OnUrlChange Url.Url
    | LoadSpeakers (Result Http.Error (List Speaker))
    | JumpTo (Result Browser.Dom.Error Browser.Dom.Element)
    | CloseSpeakerOverlay


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ContactFormMsg contactFormMsg ->
            let
                ( updateFormModel, updateFormMsg ) =
                    ContactForm.update contactFormMsg model.contactForm
            in
            ( { model | contactForm = updateFormModel }
            , Cmd.map ContactFormMsg updateFormMsg
            )

        OnUrlChange url ->
            ( { model | route = Route.fromUrl url }
            , [ Browser.Dom.getElement >> Task.attempt JumpTo
              , Browser.Dom.focus >> Task.attempt (\_ -> NoOp)
              ]
                |> List.map (ifFragment url.fragment)
                |> Cmd.batch
            )
                |> setOverflowForModalState

        OnUrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( { model | speakerModal = Route.matchSpeaker (Route.fromUrl url) model.speakers }
                    , Nav.pushUrl model.key (Url.toString url)
                    )
                        |> setOverflowForModalState

                Browser.External href ->
                    ( model, Nav.load href )

        LoadSpeakers (Ok speakers) ->
            ( { model
                | speakers = speakers
                , speakerModal = Route.matchSpeaker model.route speakers
              }
            , Cmd.none
            )
                |> setOverflowForModalState

        LoadSpeakers (Err httpError) ->
            ( model, Cmd.none )

        JumpTo (Ok element) ->
            ( model
            , Browser.Dom.setViewport element.element.x element.element.y
                |> Task.perform (\_ -> NoOp)
            )

        JumpTo (Err error) ->
            ( model, Cmd.none )

        CloseSpeakerOverlay ->
            ( { model | speakerModal = Nothing }, Cmd.none )


ifFragment maybeFragment applyFunction =
    Maybe.unwrap Cmd.none applyFunction maybeFragment


{-| Can't figure out how to access the body element from within elm and need to set overflow for the modal to
work properly and not scroll the underlying content
-}
setOverflowForModalState : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
setOverflowForModalState ( model, commands ) =
    case model.speakerModal of
        Nothing ->
            ( model, Cmd.batch [ commands, showOverflow () ] )

        Just _ ->
            ( model, Cmd.batch [ commands, hideOverflow () ] )


port hideOverflow : () -> Cmd msg


port showOverflow : () -> Cmd msg
