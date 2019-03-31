module View.Pages.Sponsorship exposing (view)

import Browser
import Dom
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Update exposing (Msg)
import View.Page as Page


type alias Tier =
    { title : String
    , cost : String
    , perks : List String
    , imageAssetSrc : String
    }


view : Model -> Browser.Document Msg
view model =
    { title = "Elm in the Spring 2019 - Become a Sponsor"
    , body =
        Page.view
            [ "Sponsorship", model.platform ]
            [ header
            , tiers
            ]
    }


levelData : List Tier
levelData =
    [ { title = "Old Grove"
      , cost = "$2,500"
      , perks = [ "20% discount on ticket purchases", "On-stage banner and speaker introduction opportunity. Limited space, first come first served!", "Logo included in videos and displayed on presentation screen between talks" ]
      , imageAssetSrc = "/images/sponsorship/old-grove.svg"
      }
    , { title = "Shade Tree"
      , cost = "$1,000"
      , perks = [ "15% discount on ticket purchases", "Special thank-you from the organizers during announcements", "Logo displayed on presentation screen between talks" ]
      , imageAssetSrc = "/images/sponsorship/shade-tree.svg"
      }
    , { title = "Spring Sapling"
      , cost = "$500"
      , perks = [ "10% discount on ticket purchases" ]
      , imageAssetSrc = "/images/sponsorship/spring-sapling.svg"
      }
    ]


backNav =
    Dom.element "a"
        |> Dom.appendChild
            (Dom.element "img"
                |> Dom.addAttributeList
                    [ src "/images/flower.svg"
                    , alt "Go Home"
                    ]
            )
        |> Dom.addClass "Sponsorship__back-navigation"
        |> Dom.addAttributeList [ href "/" ]


header =
    Dom.element "header"
        |> Dom.addClass "Section Sponsorship__header"
        |> Dom.appendChildList [ backNav, heading, blurb ]


heading =
    Dom.element "div"
        |> Dom.addClass "Section__heading Sponsorship__heading"
        |> Dom.appendChild
            (Dom.element "h1"
                |> Dom.appendText "Sponsorship"
            )


tiers =
    Dom.element "section"
        |> Dom.addClass "Sponsorship__tiers Section__content"
        |> Dom.appendChildList (List.map tierSection levelData)


blurb =
    Dom.element "p"
        |> Dom.addClass "Sponsorship__blurb"
        |> Dom.appendText "Interested in supporting the community? Sponsor Elm in the Spring!"


tierSection tierData =
    Dom.element "section"
        |> Dom.addClass "Sponsorship__tier"
        |> Dom.appendChildList
            [ title tierData
            , graphic tierData
            , perks tierData
            ]


graphic tierData =
    Dom.element "div"
        |> Dom.addClass "Sponsorship__tier-graphic-container"
        |> Dom.appendChild
            (Dom.element "img"
                |> Dom.addClass "Sponsorship__tier-graphic"
                |> Dom.addAttributeList
                    [ src tierData.imageAssetSrc
                    , alt (tierData.title ++ " sponsorship tier")
                    ]
            )


name tier =
    Dom.element "span"
        |> Dom.addClass "Sponsorship__tier-name"
        |> Dom.appendText tier.title


cost tier =
    Dom.element "span"
        |> Dom.addClass "Sponsorship__tier-cost"
        |> Dom.appendText (" " ++ tier.cost)
        |> Dom.addClass "u-fontMono"


title tier =
    Dom.element "h1"
        |> Dom.addClass "Sponsorship__tier-title"
        |> Dom.appendChildList [ name tier, cost tier ]


perks tier =
    Dom.element "ul"
        |> Dom.addClass "Sponsorship__tier-perks"
        |> Dom.appendChildList
            (tier.perks
                |> List.map
                    (\perk ->
                        Dom.element "li"
                            |> Dom.addClass "Sponsorship__perk eits-leaf"
                            |> Dom.appendText perk
                    )
            )
