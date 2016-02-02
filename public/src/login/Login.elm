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

import Nav

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
    | LoginResponse (Maybe Http.Response)

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
        [ Nav.view
        , div [ class "row" ]
            [ div [ class "col s4 offset-s4" ]
                [ Html.form [ class "container" ]
                    [ div [ class "modal-content" ]
                        [ h2 [ class "header center-align" ] [ text "Login Fam" ]
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
                        ]
                    , div [ class "model-footer" ]
                        [ button
                            [ onClick address Login
                            , class "btn waves-effect waves-light deep-orange right"
                            , type' "submit"
                            ]
                            [ text "Login"
                            , i [ class "material-icons right" ] [ text "send" ]
                            ]
                        ]
                    ]
                ]
            ]
        ]

-- EFFECTS

postLogin : Model -> Effects Action
postLogin model =
    loginRequest "api/login" model
        |> Task.toMaybe
        |> Task.map LoginResponse
        |> Effects.task

loginRequest : String -> Model -> Task.Task Http.RawError Http.Response
loginRequest url model =
    Http.send Http.defaultSettings
        { verb = "POST"
        , headers = [("Content-Type", "application/json")]
        , url = url
        , body = encodeBody model
        }

encodeBody : Model -> Http.Body
encodeBody model =
    Http.string ("{ \"username\": \"" ++ model.username ++ "\", \"password\": \"" ++ model.password ++ "\"}")

decodeLoginResponse : Json.Decoder Account
decodeLoginResponse =
    Json.object4 Account
        ("admin" := Json.bool)
        ("email" := Json.string)
        ("username" := Json.string)
        ("name" := Json.string)
