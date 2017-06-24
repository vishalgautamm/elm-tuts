module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import App
import Route exposing (Route(..), fromLocation)
import Navigation exposing (Location)
import Json.Encode exposing (string)


all : Test
all =
    describe "A Test Suite"
        [ test "Model is initialized properly" <|
            \() ->
                (Tuple.first <| App.init (string "") (hash ""))
                    |> Expect.equal
                        { currentRoute =
                            Route.Home
                        }
        , test "no hash -> `Home`" <|
            \() ->
                parseRoute ""
                    |> Expect.equal (Just Home)
        , test "`/` -> `Home`" <|
            \() ->
                parseRoute "/"
                    |> Expect.equal (Just Home)
        , test "`/categories` -> `Categories`" <|
            \() ->
                parseRoute "/categories"
                    |> Expect.equal (Just Categories)
        , test "`/categories/foo` -> `Category \"foo\"`" <|
            \() ->
                parseRoute "/categories/foo"
                    |> Expect.equal (Just <| Category "foo")
        , test "`/categories/foo/threads/bar` -> `Thread \"foo\" \"bar\"`" <|
            \() ->
                parseRoute "/categories/foo/threads/bar"
                    |> Expect.equal (Just <| Thread "foo" "bar")
        ]


parseRoute : String -> Maybe Route
parseRoute =
    hash >> fromLocation


hash : String -> Location
hash h =
    { href = ""
    , host = ""
    , hostname = ""
    , protocol = ""
    , origin = ""
    , port_ = ""
    , pathname = ""
    , search = ""
    , hash = h
    , username = ""
    , password = ""
    }
