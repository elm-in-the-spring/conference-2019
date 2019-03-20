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
    | JumpTo (Result Browser.Dom.Error Browser.Dom.Element)
      --| JumpTo Browser.Dom.Element
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
            let
                fragment =
                    Maybe.withDefault "" url.fragment

                ( updatingModel, updatingCmd ) =
                    Browser.Dom.getElement fragment
                        --|> Task.andThen (\el ->
                        |> Task.attempt (\_ -> NoOp)
                        |> Tuple.pair model
            in
            ( { updatingModel | route = Route.fromUrl url }
            , updatingCmd
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
                            Maybe.withDefault "" url.fragment
                    in
                    ( model
                    , Cmd.batch
                        [ Nav.pushUrl model.key (Debug.log "String url" (Url.toString url))
                        , Browser.Dom.getElement fragment
                            |> Task.attempt JumpTo

                        --    (\el ->
                        --        Browser.Dom.setViewportOf fragment el.element.x el.element.y
                        --            |> Task.attempt (\_ -> NoOp)
                        --    )
                        --|> Task.attempt (\_ -> NoOp)
                        --|> Task.andThen (\el -> JumpTo el.viewport)
                        --, saveViewport fragment
                        --, saveViewport fragment
                        --    |> Task.attempt (\_ -> NoOp)
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

        JumpTo (Ok element) ->
            let
                _ =
                    Debug.log "ELEMENT" element
            in
            ( model
            , Browser.Dom.setViewport element.element.x element.element.y
                |> Task.perform (\_ -> NoOp)
            )

        JumpTo (Err error) ->
            ( model, Cmd.none )



--JumpTo task ->
--    (model,
--        Task.attempt task
--            |> Task.andTHen
--    )
--JumpTo el ->
--    let
--        _ =
--            Debug.log "EL" el
--        { x, y } =
--            Debug.log "hello" el.element
--    in
--    Browser.Dom.setViewport x y
--        |> Task.perform (\_ -> NoOp)
--        |> Tuple.pair model
--( { model | savedViewport = Just viewport }
--, model.savedViewport
--    |> Maybe.map (\vp -> Browser.Dom.setViewport vp.viewport.x vp.viewport.y)
--    |> Maybe.map (Task.perform (\_ -> NoOp))
--    |> Maybe.withDefault Cmd.none
--)
--jumpToSection : String -> Cmd Msg


jumpToSpot : String -> Cmd Msg
jumpToSpot _ =
    Task.perform (\_ -> NoOp) (Browser.Dom.setViewport 0 100)



--jumpToSection id =
--    Browser.Dom.element id
--        |> Task.andThen (\info -> Browser.Dom.setViewport 0 (Debug.log "hello" info.viewport.height))
--        |> Task.andThen (\_ -> Browser.Dom.getViewport)
--        |> Task.attempt (\_ -> NoOp)


saveViewport id =
    Browser.Dom.getViewportOf (Debug.log "id" id)
        |> Task.map
            (\t ->
                SaveViewport (Debug.log "t" t)
            )
        |> Task.attempt (\_ -> NoOp)



--|> update
--|> Task.map (\t ->
--    let
--        (m, c) =
--            Task.perform (\_ -> NoOp) t
--                |> Task.pair
--    in
--)
--|> Task.attempt (\_ -> NoOp) SaveViewport
--|> Task.attempt (\_ -> NoOp)
--|> Tuple.pair model
--jumpToSection : String -> Cmd Msg
--jumpToSection id =
--
--Result Browser.Dom.Error ()
--|> Task.perform
