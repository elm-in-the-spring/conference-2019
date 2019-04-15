module Schedule exposing (Slot, decoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


type alias Slot =
    { number : Int
    , start : String
    , end : String
    }


decoder : Decoder Slot
decoder =
    Decode.succeed Slot
        |> required "number" Decode.int
        |> required "start_time" Decode.string
        |> required "end_time" Decode.string
