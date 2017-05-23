-- Import All the modules


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http exposing (send, get)
import Json.Decode exposing (string, Decoder)
import Json.Decode.Pipeline exposing (decode, required)


-- MODEL
{--
- Define type alias MODEL
- define type Msg
- define initialModel
- define APIEndPoints
--}


type alias Model =
    { image_url : String
    , id_value : String
    , quote : String
    }


type Msg
    = FetchJoke
    | ReceiveJoke (Result Http.Error Model)


initialModel : Model
initialModel =
    Model
        "https://assets.chucknorris.host/img/avatar/chuck-norris.png"
        "664705gltfezqxhwbzykrg"
        "Mr. T pities the fool. Chuck Norris rips the fool's head off."


apiEndPoint : String
apiEndPoint =
    "https://api.chucknorris.io/jokes/random"



--UPDATE
{--
- define update function
- define decode function
- define Http function

--}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchJoke ->
            ( model
            , fetchJoke
            )

        ReceiveJoke (Ok joke) ->
            ( joke
            , Cmd.none
            )

        ReceiveJoke (Err _) ->
            ( model
            , Cmd.none
            )


fetchJoke : Cmd Msg
fetchJoke =
    get apiEndPoint jokeDecoder
        |> send ReceiveJoke


jokeDecoder : Decoder Model
jokeDecoder =
    decode Model
        |> required "icon_url" string
        |> required "id" string
        |> required "value" string



-- VIEW
{--
Define all the View Components
--}


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Chuck Norris Jokes" ]
        , mainPage model
        , button [ onClick FetchJoke ] [ text "Moar Jokes pls" ]
        ]


mainPage : Model -> Html Msg
mainPage model =
    div []
        [ img [ src model.image_url ] []
        , p [] [ text model.quote ]
        ]



-- MAIN, SUBSCRIPTIONS, PORTS AND ALL OTHER THINGS


main : Program Never Model Msg
main =
    program
        { init = ( initialModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
