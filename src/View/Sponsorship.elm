module View.Sponsorship exposing (view)

import Dom
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Update exposing (Msg)


type alias Tier =
    { title : String
    , cost : String
    , perks : List String
    , imageAssetSrc : String
    }


levelData : List Tier
levelData =
    [ { title = "Old Grove"
      , cost = "$2,500"
      , perks = [ "20% discount on ticket purchases", "On-stage banner and speaker introduction opportunity. Limited space, first come first served!", "Logo included in videos and displayed on presentation screen between talks" ]
      , imageAssetSrc = "/images/sponsorship/new/old-grove-2.svg"
      }
    , { title = "Shade Tree"
      , cost = "$1,000"
      , perks = [ "15% discount on ticket purchases", "Special thank-you from the organizers during announcements", "Logo displayed on presentation screen between talks" ]
      , imageAssetSrc = "/images/sponsorship/new/shade-tree-2.svg"
      }
    , { title = "Spring Sapling"
      , cost = "$500"
      , perks = [ "10% discount on ticket purchases" ]
      , imageAssetSrc = "/images/sponsorship/new/spring-sapling-2.svg"
      }
    ]


view : Model -> Dom.Element Msg
view _ =
    Dom.element "div"
        |> Dom.appendChildList
            [ header, tiers ]


header =
    Dom.element "header"
        |> Dom.addClass "Section Sponsorship__header"
        |> Dom.appendChildList [ heading, blurb ]


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
        |> Dom.appendText "Help us do this!"


tierSection tierData =
    Dom.element "section"
        |> Dom.addClass "Sponsorship__tier"
        |> Dom.appendChildList
            [ name tierData
            , graphic tierData
            , cost tierData
            , perks tierData
            ]


cost tier =
    Dom.element "div"
        |> Dom.addClass "Sponsorship__cost"
        |> Dom.appendText tier.cost


graphic { title, imageAssetSrc } =
    Dom.element "div"
        |> Dom.addClass "Sponsorship__graphic-container"
        |> Dom.appendChild
            (Dom.element "img"
                |> Dom.addClass "Sponsorship__tier-graphic"
                |> Dom.addAttributeList
                    [ src imageAssetSrc
                    , alt (title ++ " sponsorship tier")
                    ]
            )


name tier =
    Dom.element "h1"
        |> Dom.addClass "Sponsorship__tier-name"
        |> Dom.appendText tier.title


perks tier =
    Dom.element "ul"
        |> Dom.addClass "Sponsorship__perks"
        |> Dom.appendChildList
            (tier.perks
                |> List.map
                    (\perk ->
                        Dom.element "li"
                            |> Dom.addClass "Sponsorship__perk"
                            |> Dom.appendText perk
                    )
            )
