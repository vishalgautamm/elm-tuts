module Main exposing (..)

import Html exposing (Html, div, text, button, h3)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }



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


initialModel : Model
initialModel =
    { count = 0
    , increase = 0
    , decrease = 0
    }



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model
                | count = model.count + 1
                , increase = model.increase + 1
            }

        Decrement ->
            { model
                | count = model.count - 1
                , decrease = model.decrease + 1
            }

        Reset ->
            { model
                | count = 0
                , increase = 0
                , decrease = 0
            }



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
