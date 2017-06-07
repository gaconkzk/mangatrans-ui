module Msgs exposing(..)

import Http
import Models exposing (Player, Manga)
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
  = OnFetchPlayers (WebData (List Player))
  | OnFetchMangas (WebData (List Manga))
  | OnLocationChange Location
  | ChangeLevel Player Int
  | OnPlayerSave (Result Http.Error Player)
  | ChangeLocation String
