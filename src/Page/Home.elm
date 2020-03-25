module Page.Home exposing (Model, Msg, view, init, update, toSession)


import Html exposing (Html)

import Session exposing (Session)
---- MODEL ----

type alias Model =
    { session: Session }


init : Session -> ( Model, Cmd Msg )
init  session =
    ( { session = session }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----



view : Model -> { title : String, content : Html Msg }
view m = { title = "Home", content = Html.div [] []}

toSession : Model -> Session
toSession { session } = session