module Mangas.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Manga)
import RemoteData exposing (WebData)
import Routing exposing (mangasPath, onLinkClick)

view : WebData (List Manga) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ div [ class "left ps" ] [ text "Players" ] ]

list : List Manga -> Html Msg
list mangas =
    div [ class "ps" ]
        [ table []
            [ thead []
                [ tr [] 
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Author" ]
                    , th [] [ text "Status" ]
                    , th [] [ text "Volumes" ]
                    , th [] [ text "Chapters" ]
                    ]
                ]
            , tbody [] (List.map mangaRow mangas )
            ]
        ]

maybeList: WebData (List Manga) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""
        RemoteData.Loading ->
            text "Loading..."
        RemoteData.Success mangas ->
            list mangas
        RemoteData.Failure error ->
            text (toString error)

mangaRow: Manga -> Html Msg
mangaRow manga =
    tr []
        [ td [] [ text manga.id ]
        , td [] [ text manga.name ]
        , td [] [ text manga.author ]
        , td [] [ text manga.status ]
        , td [] [ text (toString manga.volumes) ]
        , td [] [ text (toString manga.chapters) ]
        ]
