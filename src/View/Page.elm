module View.Page exposing (view)

import Dom
import View.Footer as Footer
import View.Divider as Divider


view classes content =
    Dom.element "main"
        |> Dom.addClassList classes
        |> Dom.appendChildList content
        |> List.singleton
        |> List.append [ Footer.render, Divider.render ]
        |> List.reverse
        |> List.map Dom.render
