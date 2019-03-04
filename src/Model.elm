module Model exposing (Model)

import Browser.Dom
import Browser.Navigation as Nav
import ContactForm
import Route exposing (Route(..))
import Speaker exposing (Speaker)


type alias Model =
    { contactForm : ContactForm.Model
    , key : Nav.Key
    , route : Route
    , speakers : List Speaker
    , speakerModal : Maybe Speaker
    , savedViewport : Maybe Browser.Dom.Viewport
    }
