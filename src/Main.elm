module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Dom
import Browser.Navigation as Nav
import ContactForm
import Dom
import Html exposing (Html, div, h1, img, text)
import Html.Attributes as Attr exposing (src)
import Http
import HttpBuilder
import Json.Decode as Decode
import Route exposing (Route(..))
import Speaker exposing (Speaker)
import Task
import Url
import View.Footer as FooterView
import View.Header as HeaderView
import View.Hero as HeroView
import View.Section.Details as DetailsView
import View.Section.Speakers as SpeakersView
import View.Section.SponsorsLogos as SponsorsLogosView
import View.Section.SponsorsText as SponsorsTextView



---- MODEL ----


type alias Model =
    { contactForm : ContactForm.Model
    , key : Nav.Key
    , route : Route
    , speakers : List Speaker
    , speakerModal : Maybe Speaker
    , savedViewport : Maybe Browser.Dom.Viewport
    }


init : a -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { contactForm = ContactForm.init
      , key = key
      , route = Route.fromUrl url
      , speakers = []
      , speakerModal = Nothing
      , savedViewport = Nothing
      }
    , loadSpeakers
    )


loadSpeakers : Cmd Msg
loadSpeakers =
    HttpBuilder.get "/speaker_data.json"
        |> HttpBuilder.withExpectJson (Decode.list Speaker.decoder)
        |> HttpBuilder.send LoadSpeakers



---- UPDATE ----


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



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    let
        pageContent =
            Dom.element "main"
                |> Dom.appendChildList
                    [ HeaderView.render
                    , HeroView.render
                    , DetailsView.render
                    , SpeakersView.render
                    , SponsorsLogosView.render
                    , SponsorsTextView.render
                    , FooterView.render
                    ]
                >> Dom.render
    in
    { title = "Elm in the Spring 2019"
    , body = [ pageContent ]
    }



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }
