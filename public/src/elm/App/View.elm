module App.View where

import App.Model as App exposing (initialModel, Model)
import App.Update exposing (init, Action)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id, href, style, target, attribute)
import Html.Events exposing (onClick)

-- Pages import

import Pages.Login.View exposing (view)

type alias Page = App.Page

view : Signal.Address Action -> Model -> Html
view address model =
    div
        []
        [ (navbar address model)
        , (mainContent address model)
        , footer
        ]

mainContent : Signal.Address Action -> Model -> Html
mainContent address model =
  case model.activePage of
    App.Login ->
      let
        childAddress =
            Signal.forwardTo address App.Update.ChildLoginAction
        context =
            { backendConfig = (.config >> .backendConfig) model }
      in
        div [ style myStyle ] [ Pages.Login.View.view context childAddress model.login ]



navbar : Signal.Address Action -> Model -> Html
navbar address model =
    div [] []


footer : Html
footer =
  div [class "main-footer"]
    [ div [class "container"]
      [ span []
        [ text "With "
        , i [ class "fa fa-heart" ] []
        , text " from "
        , a [ href "http://gizra.com", target "_blank", class "gizra-logo" ] [text "gizra"]
        , span [ class "divider" ] [text "|"]
        , text "Fork me on "
        , a [href "https://github.com/Gizra/elm-hedley", target "_blank"] [text "Github"]
        ]
      ]
  ]
