module Stamps exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)

drawStamp : (Int, Int) -> Form
drawStamp (x, y) =
  ngon 5 50
  |> filled red
  |> move (toFloat(x), toFloat(-1 *y))

