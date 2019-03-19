module Route exposing (Route(..), fromUrl, toString)

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), (<?>), Parser, fragment, s, string, top)
import Url.Parser.Query as Query


type Route
    = Root
    | Home (Maybe String)
    | SpeakerModal (Maybe String)
    | Sponsorship
    | NotFound


toString : Route -> String
toString route =
    case route of
        Root ->
            "/"

        Home sectionId ->
            sectionId
                |> Maybe.map ((++) "/#")
                |> Maybe.withDefault ""

        SpeakerModal maybeString ->
            maybeString
                |> Maybe.map (\s -> "?speaker=" ++ s)
                |> Maybe.withDefault "/"

        Sponsorship ->
            "/sponsorship"

        NotFound ->
            "/"


fromUrl : Url -> Route
fromUrl =
    Parser.parse
        (Parser.oneOf
            [ Parser.map Home (fragment identity)
            , Parser.map SpeakerModal (top <?> Query.string "speaker")
            , Parser.map Sponsorship (s "sponsorship")
            ]
        )
        >> Maybe.withDefault Root
