module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import About exposing (view)

-- MAIN


main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    {}


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    {} ! []



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ navigationView model
        , About.view
        ]


navigationView : Model -> Html Msg
navigationView model =
    nav []
        [ ul []
            [ li [] [ a [ href "#" ] [ text "Home" ] ]
            , li [] [ a [ href "#" ] [ text "topics" ] ]
            ]
        ]


currentPageView : Model -> Html Msg
currentPageView model =
  text "Home Page"
