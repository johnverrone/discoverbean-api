module App.Model where

-- Pages import

import Pages.Login.Model as Login exposing (initialModel, Model)

type Page
    = Login


type alias Model =
    { activePage : Page
    , login : Login.Model
    , nextPage : Maybe Page
    }

initialModel : Model
initialModel =
    { activePage = Login
    , login = Login.initialModel
    , nextPage = Nothing
    }
