module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model = 
    { players : WebData (List Player) 
    , route : Route
    , changes  :Int
    }

initialModel : Route -> Model
initialModel route = 
    { players = RemoteData.Loading
    , route = route
    , changes = 0
    }

type alias PlayerId =
    String


type alias Player =
    { id: PlayerId
    , name: String
    , level: Int
    }

type Route = 
      HomeRoute
    | PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute