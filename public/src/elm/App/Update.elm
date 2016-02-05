module App.Update where

import App.Model as App exposing (initialModel, Model)

import Effects exposing (Effects)
import Json.Encode as JE exposing (string, Value)
import String exposing (isEmpty)
import Task exposing (succeed)

-- Pages import

import Pages.Login.Update exposing (Action)

type alias Model = App.Model

initialEffects : List (Effects Action)
initialEffects =
    []

init : (Model, Effects Action)
init =
  ( App.initialModel
  , Effects.batch initialEffects
  )

type Action
    = NoOp
    | ChildLoginAction Pages.Login.Update.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        NoOp ->
            ( model, Effects.none )
        ChildLoginAction act ->
            ( model, Effects.none )
