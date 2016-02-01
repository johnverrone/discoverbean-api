module Login where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Effects exposing (Effects, Never)
import Signal exposing (Address, forwardTo)
import Json.Encode as Encode
import Json.Decode as Json exposing ((:=))
import Task

-- MODEL

type alias Model =
    { username : String
    , password : String
    }

type alias Account =
    { admin : Bool
    , email : String
    , username : String
    , name : String
    }

init: (Model, Effects Action)
init =
    ( Model "" ""
    , Effects.none
    )

-- UPDATE

type Action
    = NoOp
    | UpdateUsername String
    | UpdatePassword String
    | Login
    | LoginResponse Account

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        NoOp -> ( model, Effects.none )
        UpdateUsername str ->
            ( { model | username = str }
            , Effects.none
            )
        UpdatePassword str ->
            ( { model | password = str }
            , Effects.none
            )
        Login ->
            ( model, postLogin model )
        LoginResponse result ->
            ( model, Effects.none )


-- VIEW

view : Address Action -> Model -> Html
view address model =
    div []
        [ header
            [ id "header" ]
            [ h1 [] [ text "Login" ] ]
        , input
            [ type' "text"
            , placeholder "username"
            , value model.username
            , on "input" targetValue (Signal.message address << UpdateUsername)
            ]
            []
        , input
            [ type' "password"
            , placeholder "password"
            , value model.password
            , on "input" targetValue (Signal.message address << UpdatePassword)
            ]
            []
        , button [ onClick address Login ] [ text "Login" ]
        ]

-- EFFECTS

postLogin : Model -> Effects Action
postLogin model =
    Effects.task (Task.map LoginResponse (Task.onError (Http.post decodeLoginResponse "api/login" (Http.string ("{username: " ++ model.username ++ ", password: " ++ model.password ++ "}"))) (\err -> Task.succeed (Account False "" "" ""))))

decodeLoginResponse : Json.Decoder Account
decodeLoginResponse =
    Json.object4 Account
        ("admin" := Json.bool)
        ("email" := Json.string)
        ("username" := Json.string)
        ("name" := Json.string)
