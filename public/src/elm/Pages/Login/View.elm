module Pages.Login.View where

import Pages.Login.Model exposing (initialModel, Model)
import Pages.Login.Update exposing (Action)

import Html exposing (a, button, div, i, input, h2, hr, span, text, Html)
import Html.Attributes exposing (action, class, disabled, id, hidden, href, placeholder, required, size, style, type', value)
import Html.Events exposing (on, onClick, onSubmit, targetValue)
import String exposing (isEmpty)

view : Signal.Address Action -> Model -> Html
view address model =
    let
        loginForm =
            Html.form
                [ onSubmit address Pages.Login.Update.SubmitForm
                , action "javascript:void(0);"
                , class "form-signin"
                ]

                -- Form title
                [ h2 [ class "header center-align" ] [ text "Login Fam" ]
                , div
                    [ class "input-group" ]
                    [ span
                        [ class "input-group-addon" ]
                        [ i [ class "glyphicon glyphicon-user" ] [] ]
                        , input
                            [ type' "text"
                            , class "form-control"
                            , placeholder "Name"
                            , value model.loginForm.username
                            , on "input" targetValue (Signal.message address << Pages.Login.Update.UpdateUsername)
                            , size 40
                            , required True
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
                      , value model.loginForm.password
                      , on "input" targetValue (Signal.message address << Pages.Login.Update.UpdatePassword)
                      , size 40
                      , required True
                      ]
                      []
                   ]

                -- Submit button
                , button
                    [ onClick address Pages.Login.Update.SubmitForm
                    , class "btn waves-effect waves-light deep-orange right"
                    , type' "submit"
                    ]
                    [ text "Login"
                    , i [ class "material-icons right" ] [ text "send" ]
                    ]
                ]
    in
        div [ id "login-page" ]
            [ div
                [ class "container" ]
                [ div
                    [ class "wrapper" ]
                    [ loginForm
                    ]
                ]
            ]
