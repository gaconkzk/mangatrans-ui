module Main exposing(..)

import Msgs exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Routing
import Navigation exposing (Location)
import Commands exposing (fetchPlayers, fetchMangas)

init : Location -> ( Model, Cmd Msg )
init location =
    let
      currentRoute = 
        Routing.parseLocation location
      fet = 
        case currentRoute of
            Models.MangasRoute ->
                fetchMangas
            _ ->
                fetchPlayers
    in
        ( initialModel currentRoute, fet )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- MAIN
main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }