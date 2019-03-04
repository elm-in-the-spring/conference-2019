module Update exposing (Msg(..), update)

import Browser
import Browser.Dom
import Browser.Navigation as Nav
import ContactForm
import Http
import Model exposing (Model)
import Route exposing (Route(..))
import Speaker exposing (Speaker)
import Url


type Msg
    = NoOp
    | ContactFormMsg ContactForm.Msg
    | OnUrlRequest Browser.UrlRequest
    | OnUrlChange Url.Url
    | LoadSpeakers (Result Http.Error (List Speaker))
    | SaveViewport Browser.Dom.Viewport


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
            , Cmd.none
            )

        OnUrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        LoadSpeakers (Ok speakers) ->
            ( { model | speakers = speakers }
            , Cmd.none
            )

        LoadSpeakers (Err httpError) ->
            ( model, Cmd.none )

        SaveViewport viewport ->
            ( { model | savedViewport = Just viewport }
            , Cmd.none
            )
