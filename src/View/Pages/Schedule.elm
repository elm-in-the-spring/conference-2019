module View.Pages.Schedule exposing (view)

import Browser
import Html
import Dom
import Model exposing (Model)
import Update exposing (Msg)
import View.Page as Page
import Schedule
import Speaker exposing (Speaker)

type alias Block =
    { title : String
    , info : Maybe String
    , slot : Schedule.Slot
    }

nonSpeakerBlocks : List Block
nonSpeakerBlocks =
    [ { title = "Welcome", info = Nothing, slot = { number = 1, start = "9:30 AM", end = "9:45 AM" } }
    , { title = "Morning Break", info = Nothing, slot = { number = 4, start = "10:45 AM", end = "11:00 AM" } }
    , { title = "Lunch", info = Nothing, slot = { number = 7, start = "12:00 PM", end = "1:30 PM" } }
    , { title = "Afternoon Break 1", info = Nothing, slot = { number = 10, start = "2:30 PM", end = "2:45 PM"} }
    , { title = "Afternoon Break 2", info = Nothing, slot = { number = 13, start = "3:45 PM", end = "4:00 PM"} }
    , { title = "Wrap-Up", info = Nothing, slot = { number = 16, start = "5:00 PM", end = "5:15 PM"} }
    , { title = "Party", info = Nothing, slot = { number = 17, start = "7:00 PM", end = "9:00 PM"} }
    ]


speakerToBlock : Speaker -> Block
speakerToBlock ({name, slot} as speaker) =
    { title = Speaker.talkFullTitle speaker
    , info = Just name
    , slot = slot
    }


infoNode info =
    case info of
        Nothing ->
            Html.text ""

        Just info_ ->
            Dom.element "div"
                |> Dom.addClass "ScheduleSlot__info"
                |> Dom.appendText info_
                |> Dom.render


blockToElem : Block -> Dom.Element Msg
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
                |> Dom.appendChild (Dom.element "div" |> Dom.addClass "ScheduleSlot__title" |> Dom.appendText block.title)
                |> Dom.appendNode (infoNode block.info)
            ]


blocks : List Speaker -> Dom.Element Msg
blocks speakers =
    Dom.element "div"
        |> Dom.addClass "Schedule__container"
        |> Dom.appendChildList
            (speakers
                |> List.map speakerToBlock
                |> List.append nonSpeakerBlocks
                |> List.sortBy (\block -> block.slot.number)
                |> List.map blockToElem)


view : Model -> Browser.Document Msg
view model =
    { title = "Elm in the Spring - Conference 2019 - Schedule"
    , body =
        Page.view
            [ "Schedule", model.platform ]
            [Dom.element "h1" |> Dom.appendText "Schedule Placeholder"
            , blocks model.speakers
            ]
    }
