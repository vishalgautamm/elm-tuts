module Stamps exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (Html)
import Mouse


-- MODEL


type alias Position =
    ( Int, Int )


type alias Model =
    { clicks : List Position
    }


type Msg
    = AddClick Position


model : Model
model =
    { clicks = clicks
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddClick pos ->
            { model | clicks = pos :: model.clicks } ! []



-- VIEW


view : Model -> Html Msg
view model =
    let
        theGroup =
            group (List.map drawStamp model.clicks)

        originGroup =
            move ( -400, 400 ) theGroup
    in
        collage 800
            800
            [ originGroup ]
            |> Element.toHtml


drawStamp : ( Int, Int ) -> Form
drawStamp ( x, y ) =
    ngon 5 50
        |> filled red
        |> move ( toFloat (x), toFloat (-1 * y) )


clicks : List ( Int, Int )
clicks =
    [ ( 0, 0 ), ( 100, 100 ), ( 200, 100 ) ]



-- MAIN


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
    Mouse.clicks (\{ x, y } -> AddClick ( x, y ))
