module View.Section.Sponsors exposing (render)

import Dom
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "section"
        |> Dom.setId "sponsors"
        |> Dom.addClass "section-sponsors"
        |> Dom.appendChildList
            [ sectionTitle
            , logos
            , sectionContent
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


sectionContent : Dom.Element Msg
sectionContent =
    Dom.element "div"
        |> Dom.addClass "section-content leading-normal font-light text-teal-light text-xl md:text-2xl bg-blue-dark p-12 mt-10"
        |> Dom.appendChildList
            [ contentTitle
            , p1
            , p2
            ]


contentTitle =
    Dom.element "h4"
        |> Dom.addClass "mb-5 text-3xl md:text-4xl"
        |> Dom.appendText "Support the community"


p1 =
    Dom.element "p"
        |> Dom.appendText "You or your company can become a sponsor for Elm in the Spring 2019."


p2 =
    Dom.element "p"
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText "For more info, check out ")
        |> Dom.appendChild
            (Dom.element "a"
                |> Dom.addAttribute (href "/sponsorship")
                |> Dom.appendText "becoming a sponsor"
            )
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText ".")
