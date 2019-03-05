module View.Section.SponsorsLogos exposing (render)

import Dom
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "section"
        |> Dom.setId "sponsors"
        |> Dom.addClass "section-sponsors-logos"
        |> Dom.appendChildList
            [ sectionTitle
            , logos
            ]


sectionTitle : Dom.Element Msg
sectionTitle =
    Dom.element "h3"
        |> Dom.addClass "section-title text-style-special-v3 text-center uppercase pt-20"
        |> Dom.appendText "Sponsors"


logos =
    Dom.element "div"
        |> Dom.addClass "flex flex-wrap items-center justify-center pt-10"
        |> Dom.appendChildList
            [ logo "eSpark Learning" "/images/sponsors/espark-logo.svg"
            , logo "Hubtran" "/images/sponsors/hubtran-logo.svg"
            , logo "Spantree" "/images/sponsors/spantree-logo.svg"
            , logo "NoRedInk" "/images/sponsors/no-red-ink-logo.svg"
            ]


logo sponsorName imgSrc =
    Dom.element "img"
        |> Dom.addClass "px-2 mx-2 object-scale-down h-20"
        |> Dom.addAttributeList
            [ alt ("Sponsor " ++ sponsorName)
            , src imgSrc
            ]
