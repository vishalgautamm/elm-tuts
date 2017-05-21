port module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Task exposing (Task)


-- MODEL


type alias Model =
    Int


initialModel : Model
initialModel =
    0



-- MESSAGES


type Msg
    = Increment
    | Send



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1
            , Cmd.none
            )

        Send ->
            ( model
            , outbound model
            )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model) ]
        , button [ onClick Send ] [ text "Send" ]
        ]



-- MAIN


main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions model =
    increment mapIncrement



-- turn these units into increment messages


mapIncrement : {} -> Msg
mapIncrement _ =
    Increment



-- PORT
-- INBOUND PORT


port increment : ({} -> msg) -> Sub msg



-- OUTBOUND PORT


port outbound : Int -> Cmd msg
