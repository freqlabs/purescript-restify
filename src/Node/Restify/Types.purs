module Node.Restify.Types where

import Prelude

import Data.String.Regex (Regex)
import Control.Monad.Eff (Eff, kind Effect)


foreign import data RESTIFY :: Effect

type RestifyM e a = Eff (restify :: RESTIFY | e) a

foreign import data Server :: Type
foreign import data Router :: Type
foreign import data Request :: Type
foreign import data Response :: Type

data Method = GET | HEAD | POST | PUT | PATCH | DEL | OPTS

instance showMethod :: Show Method where
  show GET   = "get"
  show HEAD  = "head"
  show POST  = "post"
  show PUT   = "put"
  show PATCH = "patch"
  show DEL   = "del"
  show OPTS  = "opts"

type Port = Int

class RoutePath a
instance routePath  :: RoutePath String
instance routeRegex :: RoutePath Regex

class RouteVersion a
instance routeVersion  :: RouteVersion String
instance routeVersions :: RouteVersion (Array String)

class MethodOpts a
instance methodPath  :: MethodOpts String
instance methodRegex :: MethodOpts Regex
instance methodOpts  :: MethodOpts (Options a b)

newtype Options a b = Options { name    :: String
                              , path    :: RoutePath a => a
                              , version :: RouteVersion b => b
                              }

class RequestParam a
instance requestParamString :: RequestParam String
instance requestParamNumber :: RequestParam Number

data CacheControl = PUBLIC | PRIVATE

instance showCacheControl :: Show CacheControl where
  show PUBLIC  = "public"
  show PRIVATE = "private"
