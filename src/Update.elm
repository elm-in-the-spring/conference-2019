module Update exposing (Msg(..), update)

import Browser
import Browser.Dom
import Browser.Navigation as Nav
import ContactForm
import Http
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
            let
                fragment : String
                fragment =
                    Maybe.withDefault "" url.fragment
            in
            ( { model | speakerModal = Speaker.findByNameQuery model.speakers fragment, route = Route.fromUrl url }
            , Cmd.none
            )

        OnUrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    let
                        fragment : String
                        fragment =
                            Maybe.withDefault "" url.fragment
                    in
                    ( model
                    , Cmd.batch
                        [ Nav.pushUrl model.key (Url.toString url)
                        , Browser.Dom.getElement fragment
                            |> Task.attempt JumpTo
                        ]
                    )

                Browser.External href ->
                    ( model, Nav.load href )

        LoadSpeakers (Ok speakers) ->
            ( { model | speakers = speakers }
            , Cmd.none
            )

        LoadSpeakers (Err httpError) ->
            ( model, Cmd.none )

        JumpTo (Ok element) ->
            ( model
            , Browser.Dom.setViewport element.element.x element.element.y
                |> Task.perform (\_ -> NoOp)
            )

        JumpTo (Err error) ->
            ( model, Cmd.none )
