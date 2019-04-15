module View.Pages.Schedule exposing (view)

import Browser
import Dom
import Html
import Html.Attributes as Attr exposing (..)
import Model exposing (Model)
import Schedule
import Speaker exposing (Speaker)
import Update exposing (Msg)
import View.Divider as Divider
import View.Nav as Nav
import View.Page as Page
import View.PageHeader as PageHeader


type alias Block msg =
    { title : String
    , info : Maybe (Dom.Element msg)
    , slot : Schedule.Slot
    }


nonSpeakerBlocks : List (Block msg)
nonSpeakerBlocks =
    [ { title = "Registration & Coffee", info = Nothing, slot = { number = 0, start = "9:00 AM", end = "9:30 AM" } }
    , { title = "Welcome", info = Nothing, slot = { number = 1, start = "9:30 AM", end = "9:45 AM" } }
    , { title = "Morning Break", info = Nothing, slot = { number = 4, start = "10:45 AM", end = "11:00 AM" } }
    , { title = "Lunch", info = Nothing, slot = { number = 7, start = "12:00 PM", end = "1:30 PM" } }
    , { title = "Afternoon Break 1", info = Nothing, slot = { number = 10, start = "2:30 PM", end = "2:45 PM" } }
    , { title = "Afternoon Break 2", info = Nothing, slot = { number = 13, start = "3:45 PM", end = "4:00 PM" } }
    , { title = "Wrap-Up", info = Nothing, slot = { number = 16, start = "5:00 PM", end = "5:15 PM" } }
    , { title = "Party @ Rock Bottom Brewery"
      , info = Just partyInfo
      , slot = { number = 17, start = "7:00 PM", end = "9:00 PM" }
      }
    ]


partyInfo =
    Dom.element "div"
        |> Dom.appendChildList
            [ Dom.element "span" |> Dom.appendText "Located at "
            , Dom.element "a"
                |> Dom.addAttribute (href "https://goo.gl/maps/4E7RTE9x5kq")
                |> Dom.appendText "1 W Grand Ave"
            , Dom.element "div"
                |> Dom.addClass "u-textSmaller"
                |> Dom.appendText "Appetizers will be provided! No age restriction (attendees under 21 welcome)"
            ]


view : Model -> Browser.Document Msg
view model =
    { title = "Elm in the Spring - Conference 2019 - Schedule"
    , body =
        Page.view
            [ "Schedule", model.platform, "Page" ]
            [ PageHeader.render "Schedule" []
            , PageHeader.blurb blurbContent
            , blocks model.speakers
            ]
    }


speakerToBlock : Speaker -> Block msg
speakerToBlock ({ name, slot } as speaker) =
    { title = Speaker.talkFullTitle speaker
    , info = Just (Dom.element "span" |> Dom.appendText name)
    , slot = slot
    }


infoNode info =
    case info of
        Nothing ->
            Html.text ""

        Just info_ ->
            Dom.element "div"
                |> Dom.addClass "ScheduleSlot__info"
                |> Dom.appendChild info_
                |> Dom.render


blockToElem : Block msg -> Dom.Element msg
blockToElem block =
    Dom.element "section"
        |> Dom.addClass "ScheduleSlot"
        |> Dom.addClassConditional "ScheduleSlot--highlight" (List.member block nonSpeakerBlocks)
        |> Dom.appendChildList
            [ Dom.element "span"
                |> Dom.addClass "ScheduleSlot__time"
                |> Dom.appendText block.slot.start
                |> Dom.appendText " — "
                |> Dom.appendText block.slot.end
            , Dom.element "div"
                |> Dom.addClass "ScheduleSlot__content"
                |> Dom.appendChild (Dom.element "h2" |> Dom.addClass "ScheduleSlot__title" |> Dom.appendText block.title)
                |> Dom.appendNode (infoNode block.info)
            ]


blocks : List Speaker -> Dom.Element Msg
blocks speakers =
    Dom.element "div"
        |> Dom.addClassList [ "Schedule__container" ]
        |> Dom.appendChildList
            (speakers
                |> List.map speakerToBlock
                |> List.append nonSpeakerBlocks
                |> List.sortBy (\block -> block.slot.number)
                |> List.map blockToElem
            )


blurbContent =
    Dom.element "section"
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText "Events will take place on ")
        |> Dom.appendChild (Dom.element "span" |> Dom.addClass "font-bold" |> Dom.appendText "Friday, April 26th")
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText " at ")
        |> Dom.appendChild
            (Dom.element "a"
                |> Dom.addAttributeList [ href "https://maps.google.com/?q=Newberry+Library+Chicago", target "_blank" ]
                |> Dom.appendText "Newberry Library"
            )
        |> Dom.appendChild (Dom.element "span" |> Dom.appendText " in Chicago unless noted otherwise.")
