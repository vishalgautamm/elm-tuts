module Data.Category
    exposing
        ( Id
        , Slug
        , Category
        , slugParser
        , slugToString
        , mockCategory
        )

import Time exposing (Time)
import UrlParser as Url exposing (Parser)


type Id
    = Id Int


type Slug
    = Slug String


type alias Category =
    { id : Id
    , title : String
    , slug : Slug
    , insertedAt : Time
    , updatedAt : Time
    }


slugParser : Parser (Slug -> a) a
slugParser =
    Url.custom "SLUG" (Ok << Slug)


slugToString : Slug -> String
slugToString (Slug slug) =
    slug


mockCategory : Category
mockCategory =
    { id = Id 1
    , title = "Elixir"
    , slug = Slug "elixir"
    , insertedAt = 0
    , updatedAt = 0
    }
