module Main exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Keyboard
import Html exposing (..)
import Html as App


type alias Model =
    { points : List Point
    , x : Int
    , y : Int
    }


type alias Point =
    ( Int, Int )


initialModel : Model
initialModel =
    { points = [ ( 0, 0 ) ]
    , x = 0
    , y = 0
    }


type Msg
    = KeyUp Keyboard.KeyCode


view : Model -> Html Msg
view model =
    collage 800
        800
        [ (drawLine model.points) ]
        |> Element.toHtml


drawLine : List Point -> Form
drawLine points =
    let
        -- Our points are integers, but a path needs a list of floats.  We'll make a
        -- function to turn a 2-tuple of ints into a 2-tuple of floats
        intsToFloats : ( Int, Int ) -> ( Float, Float )
        intsToFloats ( x, y ) =
            ( toFloat x, toFloat y )

        -- Then we'll map our points across that function
        shape =
            path (List.map intsToFloats points)
    in
        -- Finally, we'll trace that list of points in solid red
        shape
            |> traced (solid red)


main : Program Never Model Msg
main =
    App.program
        { init = initialModel ! []
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyUp keyCode ->
            ( keyUp keyCode model, Cmd.none )


keyUp : Keyboard.KeyCode -> Model -> Model
keyUp keyCode model =
    case keyCode of
        38 ->
            -- up
            { model | y = model.y + 1, points = ( model.x, model.y + 1 ) :: model.points }

        40 ->
            -- down
            { model | y = model.y - 1, points = ( model.x, model.y - 1 ) :: model.points }

        37 ->
            -- left
            { model | x = model.x - 1, points = ( model.x - 1, model.y ) :: model.points }

        39 ->
            -- right
            { model | x = model.x + 1, points = ( model.x + 1, model.y ) :: model.points }

        _ ->
            model


subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.ups KeyUp
