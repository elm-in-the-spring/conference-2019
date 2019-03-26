module Route exposing (Route(..), fromUrl, matchSpeaker, toString)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Speaker exposing (Speaker)
import Url exposing (Url)
import Url.Builder exposing (Root(..))
import Url.Parser as Parser exposing ((</>), (<?>), Parser, fragment, s, top)
import Url.Parser.Query as Query


type Route
    = Root
    | Home (Maybe String)
    | SpeakerModal (Maybe String) (Maybe String)
    | Sponsorship
    | NotFound


toString : Route -> String
toString route =
    case route of
        Root ->
            "/"

        Home sectionId ->
            Url.Builder.custom Relative [] [] sectionId

        SpeakerModal speakerNameFragment speakerNameQuery ->
            Url.Builder.custom Relative
                []
                [ Url.Builder.string "speaker" (Maybe.withDefault "" speakerNameQuery) ]
                speakerNameFragment

        Sponsorship ->
            "/sponsorship"

        NotFound ->
            "/"


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map SpeakerModal (top </> fragment identity <?> Query.string "speaker")
        , Parser.map Home (top </> fragment identity)
        , Parser.map Sponsorship (s "sponsorship")
        ]


fromUrl : Url -> Route
fromUrl url =
    Parser.parse parser url
        |> Maybe.withDefault Root


href : Route -> Attribute msg
href targetRoute =
    Attr.href (toString targetRoute)


matchSpeaker : Route -> List Speaker -> Maybe Speaker
matchSpeaker route speakers =
    case route of
        SpeakerModal nameFragment _ ->
            Speaker.findByNameQuery speakers (Maybe.withDefault "" nameFragment)

        _ ->
            Nothing
