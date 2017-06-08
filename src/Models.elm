module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model = 
    { players : WebData (List Player) 
    , mangas : WebData (List Manga)
    , route : Route
    , changes  :Int
    }

initialModel : Route -> Model
initialModel route = 
    { players = RemoteData.Loading
    , mangas = RemoteData.Loading
    , route = route
    , changes = 0
    }

type alias PlayerId =
    String

type alias MangaId = 
    String

type alias Player =
    { id: PlayerId
    , name: String
    , level: Int
    }

type alias Manga =
    { id: MangaId
    , name: String
    , author: String
    , status: String
    , volumes: Int
    , chapters: Int
    , lang: String
    }

type Route = 
      HomeRoute
    | MangasRoute
    | PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute