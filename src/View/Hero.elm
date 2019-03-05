module View.Hero exposing (render)

import Dom
import Html.Attributes exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


render : Model -> Dom.Element Msg
render _ =
    Dom.element "div"
        |> Dom.addClass "section-hero"
        |> Dom.appendChildList
            [ Dom.element "div"
            , Dom.element "div"
                |> Dom.addClass "hero-content"
                |> Dom.appendChildList
                    [ logoImage
                    , logoText
                    , textContent
                    , logoAsText
                    , ctaButton
                    ]
            ]


logoImage =
    Dom.element "div"
        |> Dom.addClass "hero-logo"
        |> Dom.appendChild
            (Dom.element "img"
                |> Dom.addAttributeList
                    [ src "/images/flower.svg"
                    , alt "logo flower"
                    ]
            )


logoText =
    Dom.element "div"
        |> Dom.addClass "hero-logo-text"
        |> Dom.appendChild
            (Dom.element "img"
                |> Dom.addAttributeList
                    [ src "/images/text.svg"
                    , alt "Elm in the Spring Conference on April 26, 2019 in Chicago"
                    ]
            )


textContent =
    Dom.element "div"
        |> Dom.addClass "hero-text"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "text-blue text-2xl text-center"
                |> Dom.appendText "A day to learn, teach, and share about Elm!"
            )


ctaButton =
    Dom.element "div"
        |> Dom.addClass "hero-attend-cta"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.appendChild
                    (Dom.element "a"
                        |> Dom.addClass "btn-offset"
                        |> Dom.addAttribute (href "#details")
                        |> Dom.appendText "Attend"
                    )
            )


logoAsText =
    Dom.element "h1"
        |> Dom.appendText "Elm in the Spring Conference on April 26, 2019 in Chicago"
        |> Dom.addClass "hidden"
