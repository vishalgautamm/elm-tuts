module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src)


-- MODEL


type alias Model =
    ()


init : String -> ( Model, Cmd Msg )
init path =
    ( (), Cmd.none )


type Msg
    = NoOp



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text "Nothing here yet" ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
