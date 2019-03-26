module Route exposing (Route(..), fromUrl, toString)

import Html exposing (Attribute)
import Html.Attributes as Attr
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
        [ Parser.map SpeakerModal (fragment identity <?> Query.string "speaker")
        , Parser.map Home (fragment identity)
        , Parser.map Sponsorship (s "sponsorship")
        ]


fromUrl : Url -> Route
fromUrl url =
    Parser.parse parser url
        |> Maybe.withDefault Root



--toUrl : Route -> Url
--toUrl


href : Route -> Attribute msg
href targetRoute =
    Attr.href (toString targetRoute)
