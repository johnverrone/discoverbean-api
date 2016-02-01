import Effects exposing (Never)
import Login exposing (init, update, view)
import StartApp exposing (start)
import Task

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
