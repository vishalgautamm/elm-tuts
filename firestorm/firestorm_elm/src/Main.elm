module Main exposing (..)

import App exposing (..)
import Navigation exposing (Location, programWithFlags)
import Json.Decode exposing (Value)
import Route


main : Program Value Model Msg
main =
    Navigation.programWithFlags
        (Route.fromLocation >> SetRoute)
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }



-- WALK OVER THE CONCEPTS (1)
-- Navation.programWithFlags to create our program. Our flags will just be JSON.Decode.value
-- First argument to Navigation.programWithFlags is a function mapping a navigation.location to a message to be send to the app anytime the location changes
-- We are using existing Route from the location function composing it with the SetRoute message, which will set the route in our module
-- Then our Model shows the appropriate page, based on its current route
--
