module View.Pages.Home.Sponsors exposing (render)

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


heading =
    Dom.element "div"
        |> Dom.addClass "Section__heading"
        |> Dom.appendChild
            (Dom.element "h2"
                |> Dom.appendText "Sponsors"
                |> Dom.setId "sponsors-heading"
                |> Dom.addAttribute (Attr.tabindex -1)
            )


logos =
    Dom.element "div"
        |> Dom.addClass "Section__logos"
        |> Dom.appendChildList
            [ logo "eSpark Learning" "/images/sponsors/espark-logo.svg"
            , logo "Hubtran" "/images/sponsors/hubtran-logo.svg"
            , logo "Spantree" "/images/sponsors/spantree-logo.svg"
            , logo "NoRedInk" "/images/sponsors/no-red-ink-logo.svg"
            ]


logo sponsorName imgSrc =
    Dom.element "img"
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
    Dom.element "h3"
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
