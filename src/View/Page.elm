module View.Page exposing (view)

import Dom
import View.Footer as Footer


view classes content =
    Dom.element "main"
        |> Dom.addClassList classes
        |> Dom.appendChildList content
        |> List.singleton
        |> List.append [ Footer.render ]
        |> List.reverse
        |> List.map Dom.render
