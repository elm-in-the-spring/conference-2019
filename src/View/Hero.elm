module View.Hero exposing (render)

import Dom
import Html.Attributes exposing (alt, src)
import Model exposing (Model)
import Svg exposing (..)
import Svg.Attributes exposing (class, clipPathUnits, fill, height, id, points, preserveAspectRatio, transform, viewBox, width, xlinkHref)
import Update exposing (Msg)
import View.Button as Button
import View.Header as Header


render : Model -> Dom.Element Msg
render model =
    Dom.element "div"
        |> Dom.addClass "Hero"
        |> Dom.appendChildList
            [ hHeader model
            , hFlower
            , hTitle
            , hDetails
            , hBlurb
            , hFooter
            , hLeftBottom
            , hRight
            ]


hLeftBottom =
    Dom.element "div"
        |> Dom.addClass "HeroLeftColBottom"


hRight =
    Dom.element "div"
        |> Dom.addClass "HeroRightCol"


hHeader model =
    Dom.element "div"
        |> Dom.addClass "HeroHeader"
        |> Dom.appendChild
            (Dom.element "h1"
                |> Dom.appendChild (Header.render model)
            )


hFlower =
    Dom.element "div"
        |> Dom.addClass "HeroFlower"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "HeroFlower__Content eits-flower"
                |> Dom.appendText "a"
            )


hTitle =
    let
        elm =
            Dom.element "span"
                |> Dom.appendText "elm"
                |> Dom.addClass "HeroTitle--elm"

        inThe =
            Dom.element "span"
                |> Dom.appendText "in the"
                |> Dom.addClass "HeroTitle--in-the"

        elmInThe =
            Dom.element "span"
                |> Dom.appendChildList [ elm, inThe ]
                |> Dom.addClass "HeroTitle--elm-in-the"

        spring =
            Dom.element "span"
                |> Dom.addClass "HeroTitle--spring"
                |> Dom.appendText "spring"
    in
    Dom.element "h1"
        |> Dom.addClass "HeroTitle"
        |> Dom.appendChildList [ elmInThe, spring ]


hDetails =
    let
        date_ =
            Dom.element "div" |> Dom.appendText "April 26, 2019"

        star =
            Dom.element "div" |> Dom.appendText "✶"

        location =
            Dom.element "div" |> Dom.appendText "Chicago"
    in
    Dom.element "div"
        |> Dom.addClass "HeroDetails"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.appendChildList [ date_, star, location ]
            )


hBlurb =
    Dom.element "div"
        |> Dom.addClass "HeroBlurb"
        |> Dom.appendText "A day to learn, teach, and share about Elm!"


hFooter =
    Dom.element "footer"
        |> Dom.addClass "HeroFooter"
        |> Dom.appendChild hfCtaButton



--*****************************************************************************


hfCtaButton =
    Dom.element "div"
        |> Dom.addClass "HeroCTA"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "ButtonContainer ButtonContainer--offset ButtonContainer--centered"
                |> Dom.appendChild (Button.offset "#details" "Attend")
            )
