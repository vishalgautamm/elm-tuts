port module Main exposing (..)

import Html exposing (Html, div, text, button, h3)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { count : Int
    , increase : Int
    , decrease : Int
    }


type Msg
    = Increment
    | Decrement
    | Reset
    | NoOp


initialModel : Model
initialModel =
    { count = 0
    , increase = 0
    , decrease = 0
    }


mapJsMsg : Int -> Msg
mapJsMsg int =
    case int of
        1 ->
            Increment

        _ ->
            NoOp



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model
                | count = model.count + 1
                , increase = model.increase + 1
              }
            , increment ()
            )

        Decrement ->
            ( { model
                | count = model.count - 1
                , decrease = model.decrease + 1
              }
            , decrement ()
            )

        Reset ->
            ( { model
                | count = 0
                , increase = 0
                , decrease = 0
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+" ]
        , div [] [ text (toString model.count) ]
        , button [ onClick Decrement ] [ text "-" ]
        , h3 [] [ text ("+ clicked " ++ (toString model.increase) ++ " times") ]
        , h3 [] [ text ("-clicked " ++ (toString model.decrease) ++ " times") ]
        , button [ onClick Reset ] [ text "Reset" ]
        ]


main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions model =
    jsMsgs mapJsMsg



-- PORTS
-- INCOMING PORT


port jsMsgs : (Int -> msg) -> Sub msg



-- OUTGOING PORTS


port increment : () -> Cmd msg


port decrement : () -> Cmd msg
