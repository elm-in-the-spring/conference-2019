module Route exposing (Route(..), fromUrl, toString)

import Url exposing (Url)
import Url.Parser as Parser exposing ((<?>), Parser, s, top)
import Url.Parser.Query as Query


type Route
    = Home
    | SpeakerModal (Maybe String)
    | Sponsorship
    | NotFound


toString : Route -> String
toString route =
    case route of
        Home ->
            "/"

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
            [ Parser.map SpeakerModal (top <?> Query.string "speaker")
            , Parser.map Home top
            , Parser.map Sponsorship (s "sponsorship")
            ]
        )
        >> Maybe.withDefault Home
