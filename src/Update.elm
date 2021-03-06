module Update exposing (..)

import Commands exposing (savePlayerCmd)
import Msgs exposing (Msg)
import Models exposing (Model, Player, Manga)
import Routing exposing (parseLocation)
import RemoteData
import Navigation

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response -> ( { model | players = response }, Cmd.none )

        Msgs.OnFetchMangas response -> ( { model | mangas = response }, Cmd.none )

        Msgs.ChangeLocation path ->
            ( { model | changes = model.changes +1 }, Navigation.newUrl path )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
              ( {model | route = newRoute }, Cmd.none)

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
            { model | players = updatedPlayers }