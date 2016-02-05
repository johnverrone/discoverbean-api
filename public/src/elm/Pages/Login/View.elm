module Pages.Login.View where

import Pages.Login.Model exposing (initialModel, Model)
import Pages.Login.Update exposing (Action)

import Html exposing (a, button, div, i, input, h2, hr, span, text, Html)
import Html.Attributes exposing (action, class, disabled, id, hidden, href, placeholder, required, size, style, type', value)
import Html.Events exposing (on, onClick, onSubmit, targetValue)
import String exposing (isEmpty)

view : Address Action -> Model -> Html
view address model =
    let
        loginForm =
            Html.form
                [ onSubmit address Pages.Login.Update.SubmitForm
                , action "javascript:void(0);"
                , class "form-signin"
                ]

                -- Form title
                [ h2 [] [ text "Please login" ]
                , div
                    [ class "input-group" ]
                    [ span
                        [ class "input-group-addon" ]
                        [ i [ class "glyphicon glyphicon-user" ] [] ]
                        , input
                            [ type' "text"
                            , class "form-control"
                            , placeholder "Name"
                            , value model.loginForm.name
                            , on "input" targetValue (Signal.message address << Pages.Login.Update.UpdateUsername)
                            , size 40
                            , required True
                            , disabled (isFetchStatus)
                            ]
                            []
                   ]
                -- Password
                , div
                  [ class "input-group"]
                  [ span
                      [ class "input-group-addon" ]
                      [ i [ class "fa fa-lock fa-lg" ] [] ]
                  , input
                      [ type' "password"
                      , class "form-control"
                      , placeholder "Password"
                      , value modelForm.pass
                      , on "input" targetValue (Signal.message address << Pages.Login.Update.UpdatePassword)
                      , size 40
                      , required True
                      , disabled (isFetchStatus)
                      ]
                      []
                   ]

                -- Submit button
                , button
                    [ onClick address Pages.Login.Update.SubmitForm
                    , class "btn btn-lg btn-primary btn-block"
                    , disabled (isFetchStatus || isFormEmpty)
                    ]
                    [ span [ hidden <| not isFetchStatus] [ spinner ]
                    , span [ hidden isFetchStatus ] [ text "Login" ] ]
                    ]
    in
        div [ id "login-page" ] [
          hr [] []
          , div
              [ class "container" ]
              [ div
                  [ class "wrapper" ]
                  [ loginForm
                  ]
                ]
                , hr [] []
              ]
