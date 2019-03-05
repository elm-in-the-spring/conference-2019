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
        |> Dom.addClass "page-section section-speakers biko"
        |> Dom.appendChildList
            [ Dom.element "div"
            , Dom.element "div"
                |> Dom.appendChildList
                    [ sectionTitle
                    , sectionContent model
                    ]
            ]


sectionTitle : Dom.Element Msg
sectionTitle =
    Dom.element "h3"
        |> Dom.addClass "section-title text-style-special-v2 text-center uppercase pt-10"
        |> Dom.appendText "Speakers"


sectionContent : Model -> Dom.Element Msg
sectionContent model =
    Dom.element "div"
        |> Dom.addClass "section-content leading-normal text-teal-light text-xl md:text-2xl bg-blue-dark p-12 mt-10"
        |> Dom.appendChildList (List.map listing model.speakers)


listing : Speaker -> Dom.Element Msg
listing speaker =
    Dom.element "div"
        |> Dom.addClass "flex mb-10"
        |> Dom.appendChildList
            [ photo speaker True
            , Dom.element "div"
                |> Dom.addClass "ml-5"
                |> Dom.appendChildList
                    [ speakerName speaker
                    , socialLinks speaker
                    , talkTitles speaker
                    ]
            ]


speakerName : Speaker -> Dom.Element Msg
speakerName speaker =
    Dom.element "div"
        |> Dom.appendText speaker.name
        |> Dom.addClass "text-3xl md:text-3.5xl text-green-light"


photo : Speaker -> Bool -> Dom.Element Msg
photo { headshotSrc, name } hasOffset =
    Dom.element "img"
        |> Dom.addAttributeList
            [ src headshotSrc
            , alt name
            ]
        |> Dom.addClass "border border-teal-light border-t-8 border-r-8 border-b-8 border-l-8 w-48 h-48"
        |> Dom.addClassConditional "shadow-offset-bottom-left-green-light" hasOffset


socialLinks : Speaker -> Dom.Element Msg
socialLinks { social } =
    Dom.element "div"
        |> Dom.addClass "flex justify-start"
        |> Dom.appendChildList
            (List.map socialLink social)


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
                |> Dom.addClass "text-xl md:text-2xl no-underline"
                |> Dom.addAttributeList
                    [ title linkTitle
                    , href social.src
                    , target "_blank"
                    ]
                |> Dom.appendChild
                    (Dom.element "i" |> Dom.addClass ("text-green-light hover:text-green " ++ iconClass))
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
                    Dom.element "div"
                        |> Dom.addClass "font-light text-md md:text-lg"
                        |> Dom.appendText string
                        |> Dom.render

        titleEl =
            Dom.element "div"
                |> Dom.addClass "font-bold text-xl md:text-2xl"
                |> Dom.appendText talkTitle
    in
    Dom.element "div"
        |> Dom.addClass "text-teal-light"
        |> Dom.appendChild titleEl
        |> Dom.appendNode subtitleNode
