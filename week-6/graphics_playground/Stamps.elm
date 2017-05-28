module Stamps exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)


drawStamp : ( Int, Int ) -> Form
drawStamp ( x, y ) =
    ngon 5 50
        |> filled red
        |> move ( toFloat (x), toFloat (-1 * y) )



-- VIEW


view : List ( Int, Int ) -> Element
view positions =
    let
        theGroup =
            group (List.map drawStamp positions)

        originGroup =
            move ( -400, 400 ) theGroup
    in
        collage 800
            800
            [ originGroup ]


clicks : List ( Int, Int )
clicks =
    [ ( 0, 0 ), ( 100, 100 ), ( 200, 100 ) ]



-- MAIN


main : Html msg
main =
    view clicks
        |> Element.toHtml
