module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Browser.Navigation as Nav
import Url exposing (Url)
import Page.Home as Home
import Route exposing (Route)
import Browser exposing (Document)
import Page
import Page.Blank as Blank
import Page.NotFound as NotFound
import Json.Decode as Decode exposing (Value)
import Session exposing (Session(..))

---- MODEL ----

type Model =
    Redirect Session
    | NotFound Session
    | Home Home.Model


init : Url -> Nav.Key -> ( Model, Cmd Msg )
init url navKey =
    changeRouteTo (Route.fromUrl url) (Redirect (Guest navKey))


---- UPDATE ----


type Msg
    = GotHomeMsg Home.Msg
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (msg, model) of
        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            -- If we got a link that didn't include a fragment,
                            -- it's from one of those (href "") attributes that
                            -- we have to include to make the RealWorld CSS work.
                            --
                            -- In an application doing path routing instead of
                            -- fragment-based routing, this entire
                            -- `case url.fragment of` expression this comment
                            -- is inside would be unnecessary.
                            ( model, Cmd.none )

                        Just _ ->
                            ( model
                            , Nav.pushUrl (Session.navKey (toSession model)) (Url.toString url)
                            )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( GotHomeMsg subMsg, Home home ) ->
            Home.update subMsg home
                |> updateWith Home GotHomeMsg model

        ( _, _ ) ->
            -- Disregard messages that arrived for the wrong page.
            ( model, Cmd.none )
                
                
toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            session

        NotFound session ->
            session            

        Home home ->
            Home.toSession home


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just Route.Home ->
            Home.init session
                |> updateWith Home GotHomeMsg model
        



updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )
---- VIEW ----



view : Model -> Document Msg
view model =
    let
        viewPage page toMsg config =
            let
                { title, body } =
                    Page.view page config
            in
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        Redirect _ ->
            Page.view Page.Other Blank.view
        
        NotFound _ ->
            Page.view Page.Other NotFound.view

        Home home ->
            viewPage Page.Home GotHomeMsg (Home.view home)


---- PROGRAM ----


main : Program Value Model Msg
main =
   Browser.application
        { init = \_ -> init
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        , subscriptions = always Sub.none
        , update = update
        , view = view
        }
