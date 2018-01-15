module Node.Restify.Handler
       ( HandlerM(..), Handler()
       , runHandlerM, next, nextThrow
       ) where

import Prelude

import Control.Monad.Aff (Aff, runAff_)
import Control.Monad.Aff.Class (class MonadAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (class MonadEff, liftEff)
import Control.Monad.Eff.Exception (Error)
import Data.Either (either)
import Data.Function.Uncurried (runFn2)

import Node.Restify.Internal.Utils (nextWithError)
import Node.Restify.Types (RESTIFY, RestifyM, Request, Response)


-- | Monad responsible for handling a single request.
newtype HandlerM e a = HandlerM (Request -> Response -> Eff e Unit -> Aff e a)

type Handler e = HandlerM (restify :: RESTIFY | e) Unit

instance functorHandlerM :: Functor (HandlerM e) where
  map f (HandlerM h) = HandlerM \req res nxt ->
    (h req res nxt >>= \r -> pure $ f r)

instance applyHandlerM :: Apply (HandlerM e) where
  apply (HandlerM f) (HandlerM h) = HandlerM \req res nxt -> do
    res'  <- h req res nxt
    trans <- f req res nxt
    pure $ trans res'

instance applicativeHandlerM :: Applicative (HandlerM e) where
  pure x = HandlerM \_ _ _ -> pure x

instance bindHandlerM :: Bind (HandlerM e) where
  bind (HandlerM h) f = HandlerM \req res nxt -> do
    (HandlerM g) <- liftM1 f $ h req res nxt
    g req res nxt

instance monadHandlerM :: Monad (HandlerM e)

instance monadEffHandlerM :: MonadEff eff (HandlerM eff) where
  liftEff act = HandlerM \_ _ _ -> liftEff act

instance monadAffHandlerM :: MonadAff eff (HandlerM eff) where
  liftAff act = HandlerM \_ _ _ -> act

runHandlerM :: forall e. Handler e -> Request -> Response -> RestifyM e Unit -> RestifyM e Unit
runHandlerM (HandlerM h) req res nxt =
  runAff_ (either (runFn2 nextWithError nxt) pure) (h req res nxt)

-- | Call next handler/plugin in a chain.
next :: forall e. Handler e
next = HandlerM \_ _ nxt -> liftEff nxt

-- | Call next handler/plugin and pass error to it.
nextThrow :: forall e a. Error -> HandlerM (restify :: RESTIFY | e) a
nextThrow err = HandlerM \_ _ nxt ->
  liftEff $ runFn2 nextWithError nxt err
