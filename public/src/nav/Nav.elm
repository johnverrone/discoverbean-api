module Nav where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Effects exposing (Effects, Never)

-- MODEL

type alias Model =
    { }


-- UPDATE

type Action
    = NoOp

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        NoOp -> ( model, Effects.none )


-- VIEW

view : Html
view =
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
                [ li [] [ a [ href "#loginModal" ] [ text "Login" ] ]
                ]
            ]
        ]
