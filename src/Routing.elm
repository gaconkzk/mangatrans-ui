module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import UrlParser exposing (..)
import Html
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]

parseLocation: Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute

homePath: String
homePath =
    "/"

playersPath : String
playersPath =
    "/players"


playerPath : PlayerId -> String
playerPath id =
    "/players/" ++ id

{-|
When clicking a link we want to prevent the default browser behaviour which is to load a new page.
So we use `onWithOptions` instead of `onClick`.
-}
onLinkClick : msg -> Html.Attribute msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed message)
