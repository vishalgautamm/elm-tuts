module Main exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (Html)
import Mouse


-- We'll add a Model


type alias Model =
    { position : Mouse.Position
    }


model : Model
model =
    { position =
        { x = 0
        , y = 0
        }
    }



-- UPDATE


type Msg
    = MoveMouse Mouse.Position


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MoveMouse newPosition ->
            { model | position = newPosition } ! []


squares : ( Int, Int ) -> Element
squares ( x, y ) =
    let
        theGroup =
            group
                [ move ( 0, -55 ) blueSquare
                , move ( 0, 55 ) redSquare
                ]

        originGroup =
            move ( -400, 400 ) theGroup

        movedGroup =
            move ( toFloat (x), toFloat (-y) ) originGroup
    in
        collage 800 800 [ movedGroup ]


blueSquare : Form
blueSquare =
    outlined (dashed blue) square


redSquare : Form
redSquare =
    outlined (solid red) square


square : Shape
square =
    Collage.square 100



-- VIEW


view : Model -> Html Msg
view model =
    squares ( model.position.x, model.position.y )
        |> Element.toHtml



-- MAIN, SUBSCRIPTIONS ETC


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves MoveMouse
