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



-- VIEW


view : Model -> Html Msg
view model =
    shapes ( model.position.x, model.position.y )
        |> Element.toHtml


shapes : ( Int, Int ) -> Element
shapes ( x, y ) =
    let
        theGroup =
            group
                [ move ( 0, -55 ) blueSquare
                , move ( 0, 55 ) redSquare
                , move ( -110, -55 ) blueCircle
                , move ( -110, 55 ) redCircle
                , move ( 110, -55 ) blueHexagon
                , move ( 110, 55 ) redOctagon
                ]

        originGroup =
            move ( -400, 400 ) theGroup

        movedGroup =
            move ( toFloat (x), toFloat (-y) ) originGroup
    in
        collage 800 800 [ movedGroup ]


blueHexagon : Form
blueHexagon =
    filled blue (ngon 6 50)


redOctagon : Form
redOctagon =
    filled red (ngon 8 50)


blueSquare : Form
blueSquare =
    outlined (dashed blue) square


redSquare : Form
redSquare =
    outlined (solid red) square


square : Shape
square =
    Collage.square 100


blueCircle : Form
blueCircle =
    filled blue circle


redCircle : Form
redCircle =
    filled red circle


circle : Shape
circle =
    Collage.circle 50



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
