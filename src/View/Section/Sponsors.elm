module View.Section.Sponsors exposing (render)

import Dom
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "section"
        |> Dom.setId "sponsors"
        |> Dom.addClass "Section Section--sponsors"
        |> Dom.appendChildList
            [ heading
            , logos
            , content
            ]


heading : Dom.Element Msg
heading =
    Dom.element "h2"
        --|> Dom.addClass "section__heading text-style-special-v3 text-center uppercase pt-20"
        |> Dom.addClass "Section__heading"
        |> Dom.appendText "Sponsors"


logos =
    Dom.element "div"
        --|> Dom.addClass "flex flex-wrap items-center justify-center pt-10"
        |> Dom.addClass "Section__logos Section__block"
        |> Dom.appendChildList
            [ logo "eSpark Learning" "/images/sponsors/espark-logo.svg"
            , logo "Hubtran" "/images/sponsors/hubtran-logo.svg"
            , logo "Spantree" "/images/sponsors/spantree-logo.svg"
            , logo "NoRedInk" "/images/sponsors/no-red-ink-logo.svg"
            ]


logo sponsorName imgSrc =
    Dom.element "img"
        --|> Dom.addClass "px-2 mx-2 object-scale-down h-20"
        |> Dom.addAttributeList
            [ alt ("Sponsor " ++ sponsorName)
            , src imgSrc
            ]


content : Dom.Element Msg
content =
    Dom.element "div"
        |> Dom.addClass "Section__content"
        |> Dom.appendChildList
            [ subheading
            , p1
            , p2
            ]


subheading =
    Dom.element "h4"
        --|> Dom.addClass "mb-5 text-3xl md:text-4xl"
        |> Dom.addClass "Section__subheading"
        |> Dom.appendText "Support the community"


p1 =
    Dom.element "p"
        |> Dom.addClass "Section__paragraph"
        |> Dom.appendText "You or your company can become a sponsor for Elm in the Spring 2019."


p2 =
    Dom.element "p"
        |> Dom.addClass "Section__paragraph"
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText "For more info, check out ")
        |> Dom.appendChild
            (Dom.element "a"
                |> Dom.addAttribute (href "/sponsorship")
                |> Dom.appendText "becoming a sponsor"
            )
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText ".")
