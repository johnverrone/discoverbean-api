module Pages.Login.Update where

import Pages.Login.Model exposing (initialModel, Model)

import Effects exposing (Effects)
import Http exposing (Error)
import Json.Encode as Encode
import Json.Decode as Json exposing ((:=))
import Task


init : (Model, Effects Action)
init =
    ( initialModel
    , Effects.none
    )

type Action
    = UpdateUsername String
    | UpdatePassword String
    | SetUserMessage Pages.Login.Model.UserMessage
    | SubmitForm

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        UpdateUsername str ->
            let
                loginForm = model.loginForm
                updatedLoginForm = { loginForm | username = str }
            in
                ( { model | loginForm = updatedLoginForm }
                , Effects.none
                )

        UpdatePassword str ->
            let
                loginForm = model.loginForm
                updatedLoginForm = { loginForm | password = str }
            in
                ( {model | loginForm = updatedLoginForm }
                , Effects.none
                )
        SetUserMessage userMessage ->
            ( { model | userMessage = userMessage }
            , Effects.none
            )
        SubmitForm ->
            ( model, postLogin model )

-- EFFECTS

postLogin : Model -> Effects Action
postLogin model =
    loginRequest "api/login" model
        |> Task.toMaybe
        |> Task.map SetUserMessage
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
