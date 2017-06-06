-- 1 - define module route and expose Route(..) and fromLocation
--
-- 2 - import Navigation exposing Location
--
-- 3 - import UrlParser exposing (parseHash, s, (</>), string, oneOf, Parser)
--
-- 4 - define type Route and all the routes
-- 4.1 Ex: type Route = Home | Categories | Catrgory String | Items | Items String
--
-- 5 - define router function that " parses the routes"
-- router : parser (Route -> a) a
-- router = oneOf [ Url.map Categories (s "categories"), Url.map Category (s "categories" </> string)]
--
-- 6 - Define fromLocation that takes the location and parses the path and takes us to maybe a route
-- fromLocation : Location -> Maybe Route
-- 6.1 if the String.isEmpty location.hash is true then return Just Home, else parseHash router to the location


module Route exposing (Route(..), fromLocation)

import Navigation exposing (Location)
import UrlParser as Url exposing (s, (</>), string, parseHash, oneOf, Parser)


type Route
    = Home
    | Categories
    | Category String
    | Thread String String


router : Parser (Route -> a) a
router =
    oneOf
        [ Url.map Categories (s "categories")
        , Url.map Category (s "categories" </> string)
        , Url.map Thread (s "categories" </> string </> s "threads" </> string)
        ]


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Home
    else
        parseHash router location
