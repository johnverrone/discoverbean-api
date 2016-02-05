module Pages.Login.Model where

import Http exposing (Error)

type alias AccessToken = String

type alias LoginForm =
    { username : String
    , password : String
    }

type UserMessage
    = None
    | Error String

type Status
    = Init
    | Fetching
    | Fetched
    | HttpError Http.Error

type alias Model =
    { accessToken : AccessToken
    , hasAccessTokenInStorage : Bool
    , loginForm : LoginForm
    , status : Status
    , userMessage : UserMessage
    }

initialModel : Model
initialModel =
    { accessToken = ""
    , hasAccessTokenInStorage = True
    , loginForm = LoginForm "" ""
    , status = Init
    , userMessage = None
    }
