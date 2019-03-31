module Route exposing (Route(..), fromUrl, href, matchSpeaker, toString)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Speaker exposing (Speaker)
import Url exposing (Url)
import Url.Builder exposing (Root(..))
import Url.Parser as Parser exposing ((</>), (<?>), Parser, fragment, s, top)
import Url.Parser.Query as Query


type alias SectionId =
    Maybe String


type alias SpeakerName =
    Maybe String


type Route
    = Root
    | NotFound
    | Home SectionId SpeakerName
    | Speakers
    | Schedule
    | Location
    | Sponsorship


toString : Route -> String
toString route =
    case route of
        Root ->
            "/"

        NotFound ->
            "/"

        Home sectionId speakerNameQuery ->
            case ( speakerNameQuery, sectionId ) of
                ( Just query, _ ) ->
                    Url.Builder.relative [] [ Url.Builder.string "speaker" query ]

                ( Nothing, Just section ) ->
                    Url.Builder.custom Relative [] [] sectionId

                ( Nothing, Nothing ) ->
                    toString Root

        Speakers ->
            "/speakers"

        Schedule ->
            "/schedule"

        Location ->
            "/location"

        Sponsorship ->
            "/sponsorship"


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Home (top </> fragment identity <?> Query.string "speaker")
        , Parser.map Speakers (s "speakers")
        , Parser.map Schedule (s "schedule")
        , Parser.map Location (s "location")
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
        Home _ speakerNameQuery ->
            Speaker.findByNameQuery speakers (Maybe.withDefault "" speakerNameQuery)

        _ ->
            Nothing
