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
      in
        div [] [ Pages.Login.View.view childAddress model.login ]



navbar : Signal.Address Action -> Model -> Html
navbar address model =
    nav [ class "deep-orange" ]
        [ div [ class "nav-wrapper container" ]
            [ a
                [ href "#"
                , class "brand-logo header"
                ]
                [ text "Discoverbean" ]
            , ul
                [ id "nav-mobile"
                , class "right hide-on-med-and-down"
                ]
                [ li [] [ a [ href "#loginModal" ] [ text "Login John" ] ]
                ]
            ]
        ]


footer : Html
footer =
    div []
        [
        ]
