module Data.Thread
    exposing
        ( Id
        , Slug
        , Thread
        , slugParser
        , slugToString
        , mockThread
        )

import UrlParser as Url exposing (Parser)
import Time exposing (Time)
import Data.Category as Category


type Id
    = Id Int


type Slug
    = Slug String


type alias Thread =
    { id : Id
    , title : String
    , slug : Slug
    , insertedAt : Time
    , updatedAt : Time
    , categoryId : Category.Id
    }


slugParser : Parser (Slug -> a) a
slugParser =
    Url.custom "SLUG" (Ok << Slug)


slugToString : Slug -> String
slugToString (Slug slug) =
    slug


mockThread : Thread
mockThread =
    let
        category =
            Category.mockCategory
    in
        { id = Id 1
        , title = "OTP is Neat"
        , slug = Slug "otp-is-cool"
        , insertedAt = 0
        , updatedAt = 0
        , categoryId = category.id
        }
