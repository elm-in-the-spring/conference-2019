module ContactForm exposing (Model, Msg, init, update, view)

import Dom
import Html.Attributes as Attr exposing (..)


type alias Model =
    { name : String
    , email : String
    }


init : Model
init =
    { name = ""
    , email = ""
    }


type Field
    = Name
    | Email


type Msg
    = UpdateField Field String
    | Clear


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateField Name value ->
            ( { model | name = value }, Cmd.none )

        UpdateField Email value ->
            ( { model | email = value }, Cmd.none )

        Clear ->
            ( init, Cmd.none )


view : Model -> Dom.Element Msg
view model =
    Dom.element "form"
        |> Dom.addClass "ContactForm"
        |> Dom.setId "mailing-list"
        |> Dom.addAttributeList
            [ name "mailing-list"
            , method "POST"
            , id "mailing-list"
            , target "_blank"
            , action "https://elminthespring.us19.list-manage.com/subscribe/post?u=7f1c2d8a3cd0f3008803845ad&amp;id=0a8d03f3de"
            ]
        |> Dom.appendChildList
            [ Dom.element "input"
                |> Dom.addClass "u-hidden"
                |> Dom.addAttributeList
                    [ type_ "text"
                    , name "name"
                    , id "b_7f1c2d8a3cd0f3008803845ad_0a8d03f3de"
                    , value model.name
                    , tabindex -1
                    ]
                |> Dom.addInputHandler (UpdateField Name)
            , Dom.element "input"
                |> Dom.addClass "ContactForm__input-email"
                |> Dom.addAttributeList
                    [ type_ "text"
                    , name "EMAIL"
                    , id "mce-EMAIL"
                    , placeholder "email address"
                    , value model.email
                    , attribute "aria-label" "Email address"
                    ]
                |> Dom.addInputHandler (UpdateField Email)
            , Dom.element "input"
                |> Dom.addClass "ContactForm__input-submit"
                |> Dom.addAction ( "click", Clear )
                |> Dom.addAttributeList
                    [ type_ "submit"
                    , value "Sign Up"
                    ]
            ]
