module Pages.Login.Update where

import Pages.Login.Model exposing (initialModel, Model)

import Effects exposing (Effects)
import Http exposing (Error)
import Json.Encode as JE
import Json.Decode as JD exposing ((:=))
import Task


init : (Model, Effects Action)
init =
    ( initialModel
    , Effects.none
    )

type Action
    = UpdateUsername String
    | UpdatePassword String
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
        SubmitForm ->
            ( model, Effects.none ) 
