module Stamps exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (Html)
import Mouse
import Keyboard


-- MODEL


type Shape
    = Pentagon
    | Circle


type alias Stamp =
    { position : ( Int, Int )
    , shape : Shape
    }


type alias Position =
    ( Int, Int )


type alias Model =
    { stamps : List Stamp
    , shift : Bool
    }


type Msg
    = AddClick Position
    | HandleShift Bool
    | Clear
    | NoOp


model : Model
model =
    { stamps = []
    , shift = False
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddClick pos ->
            let
                newStamp =
                    if model.shift then
                        Stamp pos Pentagon
                    else
                        Stamp pos Circle
            in
                { model | stamps = newStamp :: model.stamps } ! []

        HandleShift pressed ->
            { model | shift = pressed } ! []

        Clear ->
            { model | stamps = [] } ! []

        NoOp ->
            model ! []


drawStamp : Stamp -> Form
drawStamp stamp =
    let
        ( x, y ) =
            stamp.position

        shape =
            case stamp.shape of
                Pentagon ->
                    ngon 5 50

                Circle ->
                    circle 50
    in
        shape
            |> filled red
            |> move ( toFloat (x), toFloat (-y) )



-- VIEW


view : Model -> Html Msg
view model =
    let
        theGroup =
            group (List.map drawStamp model.stamps)

        originGroup =
            move ( -400, 400 ) theGroup
    in
        collage 800
            800
            [ originGroup ]
            |> Element.toHtml



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


mapKeyDown : Int -> Msg
mapKeyDown keyCode =
    case Debug.log "mapKeyDown" keyCode of
        16 ->
            HandleShift True

        _ ->
            NoOp


mapKeyUp : Int -> Msg
mapKeyUp keyCode =
    case Debug.log "mapKeyUp" keyCode of
        16 ->
            HandleShift False

        67 ->
            Clear

        _ ->
            NoOp


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks (\{ x, y } -> AddClick ( x, y ))
        , Keyboard.downs mapKeyDown
        , Keyboard.ups mapKeyUp
        ]
