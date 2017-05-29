module Stamps exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (Html)
import Mouse


-- MODEL

type Shape
  = Pentagon
  | Circle

type alias Stamp =
  { position : (Int, Int)
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

        NoOp ->
          model ! []

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
