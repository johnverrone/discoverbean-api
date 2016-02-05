import Effects exposing (Never)
import StartApp exposing (start)
import Task

import App.Model as App exposing (Model)
import App.Update exposing (init, update)
import App.View exposing (view)

app =
    start
        { init = App.Update.init
        , update = App.Update.update
        , view = App.View.view
        , inputs = []
        }

main =
    app.html

port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks
