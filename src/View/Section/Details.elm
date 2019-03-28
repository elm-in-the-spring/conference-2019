module View.Section.Details exposing (render)

import ContactForm
import Dom
import Html
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Update exposing (Msg(..))
import View.Button as Button


render : Model -> Dom.Element Msg
render model =
    Dom.element "section"
        |> Dom.setId "details"
        |> Dom.addClass "Section Section--details"
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
                |> Dom.appendText "Details"
                |> Dom.setId "details-heading"
                |> Dom.addAttribute (Attr.tabindex -1)
            )


content model =
    Dom.element "div"
        |> Dom.addClass "Section__content"
        |> Dom.appendChildList
            [ subheading1
            , p1
            , p2
            , ticketsButton
            , p3
            , subheading2
            , p4
            , contactForm model.contactForm
            , p5
            ]


subheading1 =
    Dom.element "h3"
        |> Dom.addClass "Section__subheading"
        |> Dom.appendText "All Elm, all day!"


p1 =
    Dom.element "p"
        |> Dom.addClass "Section__paragraph"
        |> Dom.appendChild (Dom.element "span" |> Dom.addClass "font-bold" |> Dom.appendText "Elm in the Spring")
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText " is a single-track, single-day conference for developers who love Elm. Whether you’re an Elm expert scaling up your production app or you're just starting out with your first Elm project, join us for a great day of learning, teaching, and community!")


p2 =
    Dom.element "p"
        |> Dom.addClass "Section__paragraph"
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText "Elm in the Spring 2019 will take place on ")
        |> Dom.appendChild (Dom.element "span" |> Dom.addClass "font-bold" |> Dom.appendText "Friday, April 26th")
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText " at the ")
        |> Dom.appendChild
            (Dom.element "a"
                |> Dom.addAttributeList [ href "https://maps.google.com/?q=Newberry+Library+Chicago", target "_blank" ]
                |> Dom.appendText "Newberry Library"
            )
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText " in Chicago.")


ticketsButton =
    Dom.element "div"
        |> Dom.addClass "TicketsButton"
        |> Dom.appendChild
            (Dom.element "div"
                |> Dom.addClass "ButtonContainer ButtonContainer--offset ButtonContainer--centered"
                |> Dom.appendChild
                    (Button.offset (Attr.href "https://ti.to/elm-in-the-spring/chicago-2019") "Get Your Tickets"
                        |> Dom.addClass "Button--on-dark"
                    )
            )


p3 =
    Dom.element "p"
        |> Dom.addClass "Section__paragraph"
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText "All attendees are expected to observe the conference ")
        |> Dom.appendChild
            (Dom.element "a"
                |> Dom.addAttributeList [ href "http://confcodeofconduct.com/", target "_blank" ]
                |> Dom.appendText "Code of Conduct"
            )
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText ".")


subheading2 =
    Dom.element "h3"
        |> Dom.addClass "Section__subheading"
        |> Dom.appendText "Stay In Touch"


p4 =
    Dom.element "p"
        |> Dom.addClass "Section__paragraph"
        |> Dom.appendText "For conference updates, join our mailing list. No spam. Ever."


contactForm contactFormModel =
    let
        formHtmlNode =
            ContactForm.view contactFormModel
                |> Dom.render
                |> Html.map ContactFormMsg
    in
    Dom.element "div"
        |> Dom.appendNode formHtmlNode


p5 =
    Dom.element "p"
        |> Dom.addClass "Section__paragraph"
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText "Or, follow ")
        |> Dom.appendChild
            (Dom.element "a"
                |> Dom.addAttributeList
                    [ href "https://twitter.com/ElmInTheSpring", target "_blank" ]
                |> Dom.appendText "@elminthespring"
            )
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText " on Twitter")
