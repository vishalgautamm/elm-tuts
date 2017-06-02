module Main exposing (..)

import Html exposing (text)
import Date


{--
Make a list of Strings, some valid Date strings and some invalid.
Map that list of Strings to a list of Dates, filtering out invalid Dates.
Map over the list of dates and return their years
--}


dates : List String
dates =
    [ "Mon, 25 Dec 1995"
    , "23 Dec 2004"
    , "foo"
    , "var"
    , "Fri, 02 Jun 2017 "
    , "Sat, 03 June 2017"
    , "blah blah"
    ]


maybeDate : String -> Maybe Date.Date
maybeDate dateStr =
    case Date.fromString dateStr of
        Ok date ->
            Just date

        Err _ ->
            Nothing


filteredResults : List String -> List Int
filteredResults xs =
    xs
        |> List.filterMap maybeDate
        |> List.map Date.year


result : List Int
result =
    filteredResults dates


main : Html.Html msg
main =
    text (toString result)
