module Node.Restify.Server
       ( ServerM(..), Server()
       , listenHttp, listenHttp', apply
       , http, get, head, post, put, patch, del, opts
       ) where

import Prelude hiding (apply)

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (class MonadEff)
import Data.Foreign (Foreign, toForeign)
import Data.Function.Uncurried (Fn4, runFn4)

import Node.Restify.Types as R
import Node.Restify.Handler (Handler(), runHandlerM)


-- | Monad responsible for server related operations (initial setup mostly).
data ServerM e a = ServerM (R.Server -> Eff e a)
type Server e = ServerM (restify :: R.RESTIFY | e) Unit

type HandlerFn e = R.Request -> R.Response -> Eff (restify :: R.RESTIFY | e) Unit
                -> Eff (restify :: R.RESTIFY | e) Unit

instance functorServerM :: Functor (ServerM e) where
  map f (ServerM h) = ServerM \server -> liftM1 f $ h server

instance applyServerM :: Apply (ServerM e) where
  apply (ServerM f) (ServerM h) = ServerM \server -> do
    res <- h server
    trans <- f server
    pure $ trans res

instance applicativeServerM :: Applicative (ServerM e) where
  pure x = ServerM \_ -> pure x

instance bindServerM :: Bind (ServerM e) where
  bind (ServerM h) f = ServerM \server -> do
    res <- h server
    case f res of
      ServerM g -> g server

instance monadServerM :: Monad (ServerM e)

instance monadEffServerM :: MonadEff eff (ServerM eff) where
  liftEff act = ServerM \_ -> act


-- | Create a Restify server with the given options, perform the given setup actions,
-- | and start it running on the given port.
listenHttp :: forall e opts. R.Port -> opts -> Server e -> R.RestifyM e Unit
listenHttp port options (ServerM act) = do
  server <- createServer options
  act server
  listen server port

-- | Create a Restify server with the default options, perform the given setup actions,
-- | and start it running on the given port.
listenHttp' :: forall e. R.Port -> Server e -> R.RestifyM e Unit
listenHttp' port (ServerM act) = do
  server <- createServer_
  act server
  listen server port

-- | Apply Server actions to a Restify server.
apply :: forall e. Server e -> R.Server -> R.RestifyM e Unit
apply (ServerM act) server = act server

-- | Bind specified handler to handle request matching route and method.
http :: forall e opts. (R.MethodOpts opts) => R.Method -> opts -> Handler e -> Server e
http method route handler = ServerM \server ->
  runFn4 _http server (show method) (toForeign route) $ runHandlerM handler

-- | Shortcut for `http GET`
get :: forall e opts. (R.MethodOpts opts) => opts -> Handler e -> Server e
get = http R.GET

-- | Shortcut for `http HEAD`
head :: forall e opts. (R.MethodOpts opts) => opts -> Handler e -> Server e
head = http R.HEAD

-- | Shortcut for `http POST`
post :: forall e opts. (R.MethodOpts opts) => opts -> Handler e -> Server e
post = http R.POST

-- | Shortcut for `http PUT`
put :: forall e opts. (R.MethodOpts opts) => opts -> Handler e -> Server e
put = http R.PUT

-- | Shortcut for `http PATCH`
patch :: forall e opts. (R.MethodOpts opts) => opts -> Handler e -> Server e
patch = http R.PATCH

-- | Shortcut for `http DEL`
del :: forall e opts. (R.MethodOpts opts) => opts -> Handler e -> Server e
del = http R.DEL

-- | Shortcut for `http OPTS`
opts :: forall e opts. (R.MethodOpts opts) => opts -> Handler e -> Server e
opts = http R.OPTS


foreign import createServer :: forall e a. a -> R.RestifyM e R.Server

foreign import createServer_ :: forall e. R.RestifyM e R.Server

foreign import _http ::
  forall e. Fn4 R.Server String Foreign (HandlerFn e) (Eff (restify :: R.RESTIFY | e) Unit)

foreign import listen :: forall e. R.Server -> R.Port -> R.RestifyM e Unit
