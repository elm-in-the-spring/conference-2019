module ContactForm exposing (Model, Msg, init, update)


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
    | Submit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateField Name value ->
            ( { model | name = value }, Cmd.none )

        UpdateField Email value ->
            ( { model | email = value }, Cmd.none )

        Submit ->
            -- TODO:
            ( model, Cmd.none )
