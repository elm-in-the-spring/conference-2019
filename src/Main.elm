module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import ContactForm
import HttpBuilder
import Json.Decode as Decode
import Model exposing (Model)
import Route
import Speaker exposing (Speaker)
import Update exposing (Msg(..), update)
import Url exposing (Url)
import View exposing (view)



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


init : a -> Url -> Nav.Key -> ( Model, Cmd Msg )
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
