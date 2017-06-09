module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models exposing (PlayerId, Player, MangaId, Manga)
import RemoteData

fetchMangas: Cmd Msg
fetchMangas =
    Http.get fetchMangasUrl mangasDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMangas

fetchMangasUrl: String
fetchMangasUrl =
    "http://localhost:9001/api/mangas"

mangasDecoder : Decode.Decoder (List Manga)
mangasDecoder =
    Decode.list mangaDecoder

mangaDecoder : Decode.Decoder Manga
mangaDecoder =
    decode Manga
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> optional "author" Decode.string "unknown"
        |> required "status" Decode.string
        |> optional "volumes" Decode.int -1
        |> optional "chapters" Decode.int -1
        |> required "lang" Decode.string
        |> optional "url" Decode.string "NA"

fetchPlayers: Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlayers

fetchPlayersUrl: String
fetchPlayersUrl =
    "http://localhost:4000/players"

playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder

playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int

savePlayerUrl : PlayerId -> String
savePlayerUrl playerId =
    "http://localhost:4000/players/" ++ playerId


savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }


savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    savePlayerRequest player
        |> Http.send Msgs.OnPlayerSave


playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        Encode.object attributes        