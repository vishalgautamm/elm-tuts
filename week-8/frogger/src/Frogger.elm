module Frogger exposing (..)

import Html as App
import Html exposing (..)


type Msg
    = NoOp


type alias Model =
    Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text "Hello Frogger" ]


main : Program Never Int Msg
main =
    App.program
        { init = ( 0, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none
