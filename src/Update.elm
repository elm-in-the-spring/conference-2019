module Update exposing (Msg(..), update)

import Browser
import Browser.Dom
import Browser.Navigation as Nav
import ContactForm
import Http
import Model exposing (Model)
import Route exposing (Route(..))
import Speaker exposing (Speaker)
import Task
import Url


type Msg
    = NoOp
    | ContactFormMsg ContactForm.Msg
    | OnUrlRequest Browser.UrlRequest
    | OnUrlChange Url.Url
    | LoadSpeakers (Result Http.Error (List Speaker))
    | JumpTo Browser.Dom.Viewport
    | SaveViewport Browser.Dom.Viewport


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ContactFormMsg contactFormMsg ->
            let
                ( updateFormModel, updateFormMsg ) =
                    ContactForm.update contactFormMsg model.contactForm
            in
            ( { model | contactForm = updateFormModel }
            , Cmd.map ContactFormMsg updateFormMsg
            )

        OnUrlChange url ->
            ( { model | route = Route.fromUrl url }
            , Cmd.none
            )

        --JumpTo id ->
        --    jumpToSection id
        --        |> Tuple.pair model
        --Browser.Dom.getViewportOf id
        --    |> Task.andThen (\info -> Browser.Dom.setViewportOf id 0 0)
        --    |> Task.attempt result
        --Browser.Dom.getViewportOf id
        --    |> Task.andThen (\info -> Browser.Dom.setViewportOf id 0 0)
        --    |> Task.attempt (\_ -> NoOp)
        --    |> Tuple.pair model
        OnUrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    let
                        fragment : String
                        fragment =
                            url.fragment
                                |> Maybe.withDefault ""
                    in
                    ( model
                    , Cmd.batch
                        [ Nav.pushUrl model.key (Url.toString url)
                        , jumpToSection fragment
                        , saveViewport fragment
                            |> Task.attempt (\_ -> NoOp)
                        ]
                    )

                Browser.External href ->
                    ( model, Nav.load href )

        LoadSpeakers (Ok speakers) ->
            ( { model | speakers = speakers }
            , Cmd.none
            )

        LoadSpeakers (Err httpError) ->
            ( model, Cmd.none )

        SaveViewport viewport ->
            ( { model | savedViewport = Just viewport }
            , Cmd.none
            )

        JumpTo viewport ->
            ( { model | savedViewport = Just viewport }
            , model.savedViewport
                |> Maybe.map (\vp -> Browser.Dom.setViewport vp.viewport.x vp.viewport.y)
                |> Maybe.map (Task.perform (\_ -> NoOp))
                |> Maybe.withDefault Cmd.none
            )



--jumpToSection : String -> Cmd Msg


jumpToSpot : String -> Cmd Msg
jumpToSpot _ =
    Task.perform (\_ -> NoOp) (Browser.Dom.setViewport 0 100)


jumpToSection id =
    Browser.Dom.getViewportOf id
        |> Task.andThen (\info -> Browser.Dom.setViewport 0 (Debug.log "hello" info.viewport.height))
        |> Task.attempt (\_ -> NoOp)


saveViewport id =
    Browser.Dom.getViewportOf (Debug.log "id" id)
        |> Task.andThen (\t -> Task.succeed (SaveViewport (Debug.log "t" t)))



--|> Task.attempt (\_ -> NoOp) SaveViewport
--|> Task.attempt (\_ -> NoOp)
--|> Tuple.pair model
--jumpToSection : String -> Cmd Msg
--jumpToSection id =
--
--Result Browser.Dom.Error ()
--|> Task.perform
