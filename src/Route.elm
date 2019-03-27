module Route exposing (Route(..), fromUrl, href, matchSpeaker, toString)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Speaker exposing (Speaker)
import Url exposing (Url)
import Url.Builder exposing (Root(..))
import Url.Parser as Parser exposing ((</>), (<?>), Parser, fragment, s, top)
import Url.Parser.Query as Query


type Route
    = Root
    | Home (Maybe String) (Maybe String)
    | Sponsorship
    | NotFound


toString : Route -> String
toString route =
    case route of
        Root ->
            "/"

        Home sectionId speakerNameQuery ->
            case ( speakerNameQuery, sectionId ) of
                ( Just query, _ ) ->
                    Url.Builder.relative [] [ Url.Builder.string "speaker" (Debug.log "QUERY" query) ]

                ( Nothing, Just section ) ->
                    Url.Builder.custom Relative [] [] sectionId

                ( Nothing, Nothing ) ->
                    toString Root

        Sponsorship ->
            "/sponsorship"

        NotFound ->
            "/"


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Home (top </> fragment identity <?> Query.string "speaker")
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
