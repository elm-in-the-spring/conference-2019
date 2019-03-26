module View.Speaker exposing (headshot, name, socialLinks, talkTitles)

import Dom
import Html
import Html.Attributes as Attr exposing (..)
import Speaker exposing (Speaker)


headshot : Speaker -> Dom.Element msg
headshot speaker =
    Dom.element "img"
        |> Dom.addClass "Speaker__headshot"
        |> Dom.addAttributeList
            [ src speaker.headshotSrc
            , alt speaker.name
            ]


name : Speaker -> Dom.Element msg
name speaker =
    Dom.element "h3"
        |> Dom.addClass "Speaker__name"
        |> Dom.appendText speaker.name


socialLinks : Speaker -> Dom.Element msg
socialLinks { social } =
    Dom.element "div"
        |> Dom.addClass "Speaker__social-links"
        |> Dom.appendChildList
            (social
                |> List.sortBy (\s -> Speaker.socialNetworkToString s.network)
                |> List.map socialLink
            )


talkTitles : Speaker -> Dom.Element msg
talkTitles { talkTitle, talkSubtitle } =
    let
        subtitleNode =
            case talkSubtitle of
                Nothing ->
                    Html.text ""

                Just string ->
                    Dom.element "h4"
                        |> Dom.addClass "Speaker__talk-subtitle u-fontNormal"
                        |> Dom.appendText string
                        |> Dom.render

        titleEl =
            Dom.element "h3"
                |> Dom.addClass "Speaker__talk-title u-fontNormal"
                |> Dom.appendText talkTitle
    in
    Dom.element "div"
        |> Dom.addClass "Speaker__talk-titles"
        |> Dom.appendChild titleEl
        |> Dom.appendNode subtitleNode


socialLink : Speaker.Social -> Dom.Element msg
socialLink social =
    let
        ( linkTitle, iconClass ) =
            getIconAndTitle social
    in
    Dom.element "div"
        |> Dom.appendChild
            (Dom.element "a"
                |> Dom.addClass "Speaker__social-link u-noUnderline"
                |> Dom.addAttributeList
                    [ title linkTitle
                    , attribute "aria-label" linkTitle
                    , href social.src
                    , target "_blank"
                    ]
                |> Dom.appendChild
                    (Dom.element "i" |> Dom.addClass iconClass)
            )


getIconAndTitle : Speaker.Social -> ( String, String )
getIconAndTitle social =
    case social.network of
        Speaker.Website ->
            ( social.src, "eits-web" )

        Speaker.Twitter ->
            ( "twitter", "eits-social-twitter" )

        Speaker.Github ->
            ( "github", "eits-social-github" )
