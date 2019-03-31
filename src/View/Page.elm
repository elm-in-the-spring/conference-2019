module View.Page exposing (view)

import Dom


view classes content =
    Dom.element "main"
        |> Dom.addClassList classes
        |> Dom.appendChildList content
        |> Dom.render
        |> List.singleton
