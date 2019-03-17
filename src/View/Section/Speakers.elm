module View.Section.Speakers exposing (render)

import Dom
import Html
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Speaker exposing (Speaker)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render model =
    Dom.element "section"
        |> Dom.setId "speakers"
        |> Dom.addClass "Section Section--speakers u-fontBiko"
        |> Dom.appendChildList
            [ Dom.element "div"
            , Dom.element "div"
                |> Dom.appendChildList
                    [ heading
                    , content model
                    ]
            ]


heading =
    Dom.element "div"
        |> Dom.addClass "Section__heading"
        |> Dom.appendChild
            (Dom.element "h2"
                |> Dom.appendText "Speakers"
            )


content : Model -> Dom.Element Msg
content model =
    Dom.element "div"
        |> Dom.addClass "Section__content"
        |> Dom.appendChildList (List.map listing model.speakers)


listing : Speaker -> Dom.Element Msg
listing speaker =
    Dom.element "div"
        |> Dom.addClass "Section__speaker-listing"
        |> Dom.appendChildList
            [ listingPhoto speaker True
            , listingText speaker
            ]


listingPhoto : Speaker -> Bool -> Dom.Element Msg
listingPhoto { headshotSrc, name } hasOffset =
    Dom.element "img"
        |> Dom.addClass "Section__speaker-headshot"
        |> Dom.addAttributeList
            [ src headshotSrc
            , alt name
            ]
        |> Dom.addClassConditional "Section__speaker-headshot--shadow" hasOffset


listingText : Speaker -> Dom.Element Msg
listingText speaker =
    Dom.element "div"
        |> Dom.addClass "Section__speaker-text"
        |> Dom.appendChildList
            [ speakerName speaker
            , socialLinks speaker
            , talkTitles speaker
            ]


speakerName : Speaker -> Dom.Element Msg
speakerName speaker =
    Dom.element "h3"
        |> Dom.addClass "Section__speaker-name"
        |> Dom.appendText speaker.name


socialLinks : Speaker -> Dom.Element Msg
socialLinks { social } =
    Dom.element "div"
        |> Dom.addClass "Section__social-links"
        |> Dom.appendChildList
            (social
                |> List.sortBy (\s -> Speaker.socialNetworkToString s.network)
                |> List.map socialLink
            )


socialLink : Speaker.Social -> Dom.Element Msg
socialLink social =
    let
        ( linkTitle, iconClass ) =
            getIconAndTitle social
    in
    Dom.element "div"
        |> Dom.addClass "m-2"
        |> Dom.appendChild
            (Dom.element "a"
                |> Dom.addClass "Section__social-link"
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
            ( social.src, "fas fa-globe" )

        Speaker.Twitter ->
            ( "twitter", "fab fa-twitter" )

        Speaker.Github ->
            ( "github", "fab fa-github" )


talkTitles : Speaker -> Dom.Element Msg
talkTitles { talkTitle, talkSubtitle } =
    let
        subtitleNode =
            case talkSubtitle of
                Nothing ->
                    Html.text ""

                Just string ->
                    Dom.element "h4"
                        |> Dom.addClass "Section__talk-subtitle u-fontNormal"
                        |> Dom.appendText string
                        |> Dom.render

        titleEl =
            Dom.element "h3"
                |> Dom.addClass "Section__talk-title u-fontNormal"
                |> Dom.appendText talkTitle
    in
    Dom.element "div"
        |> Dom.addClass "Section__talk-titles"
        |> Dom.appendChild titleEl
        |> Dom.appendNode subtitleNode
