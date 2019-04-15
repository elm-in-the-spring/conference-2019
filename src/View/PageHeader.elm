module View.PageHeader exposing (blurb, render)

import Dom
import Html.Attributes as Attr exposing (..)
import View.Nav as Nav


render text links =
    Dom.element "header"
        |> Dom.addClass "Page__header"
        |> Dom.appendChildList (Nav.render links :: [ backNav, heading text ])


backNav =
    Dom.element "a"
        |> Dom.appendChild
            (Dom.element "img"
                |> Dom.addAttributeList
                    [ src "/images/flower.svg"
                    , alt "Go Home"
                    ]
            )
        |> Dom.addClass "Page__back-navigation"
        |> Dom.addAttributeList [ href "/" ]


heading text =
    Dom.element "div"
        |> Dom.addClass "Section__heading Page__heading"
        |> Dom.appendChild
            (Dom.element "h1"
                |> Dom.appendText text
            )


blurb content =
    Dom.element "div"
        |> Dom.addClass "Page__blurb"
        |> Dom.appendChild content
