module Node.Restify.Request
       ( getRouteParam
       -- , getBody
       -- , accepts, acceptsEncoding
       -- , contentLength, getContentType
       -- , date, time, href, id, version
       -- , getPath, getQuery, getRoute
       -- , header, trailer
       -- , is, isChunked, isKeepAlive, isSecure, isUpgradeRequest, isUpload
       -- , userAgent
       -- , startHandlerTimer, endHandlerTimer
       -- , connectionState
       ) where

import Prelude

import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Except (runExcept)
import Data.Foreign (Foreign)
import Data.Foreign.Class (decode)
import Data.Function.Uncurried (Fn2(), runFn2)
import Data.Maybe (Maybe)

import Node.Restify.Handler (HandlerM(..))
import Node.Restify.Internal.Utils (eitherToMaybe)
import Node.Restify.Types (class RequestParam, Request, RestifyM, RESTIFY)


-- | Get route param value. If it is a named route, e.g. `/user/:id`, then
-- | `getRouteParam "id"` returns the matched part of the route. If it is a
-- | regex route, e.g. `/user/(\d+)`, then `getRouteParam 1` returns the
-- | part that matched `(\d+)` and `getRouteParam 0` returns the whole route.
getRouteParam ::
 forall e a. (RequestParam a) => a -> HandlerM (restify :: RESTIFY | e) (Maybe String)
getRouteParam name = HandlerM \req _ _ ->
  liftEff $ liftM1 (eitherToMaybe <<< runExcept <<< decode) (runFn2 _getRouteParam req name)


foreign import _getRouteParam :: forall e a. Fn2 Request a (RestifyM e Foreign)
