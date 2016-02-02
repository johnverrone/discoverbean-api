import Effects exposing (Never)
import StartApp exposing (start)
import Task

import Login exposing (init, update, view)

app =
    start
        { init = init
        , update = update
        , view = view
        , inputs = []
        }

main =
    app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
