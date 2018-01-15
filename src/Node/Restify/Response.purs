module Node.Restify.Response
       ( cache, cache', defaultCache, noCache
       , charSet
       , set, setHeaders, setHeader, getHeader
       , json, statusJson, statusJsonHeaders
       , link
       , send, statusSend, statusSendHeaders
       , sendRaw, statusSendRaw, statusSendRawHeaders
       , status
       , redirect, statusRedirect
       ) where

import Prelude

import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Except (runExcept)
import Data.Foreign (Foreign, toForeign)
import Data.Foreign.Class (class Decode, decode)
import Data.Function.Uncurried (Fn1, Fn2, Fn3, Fn4, runFn1, runFn2, runFn3, runFn4)
import Data.Maybe (Maybe)

import Node.Restify.Handler (Handler, HandlerM(..))
import Node.Restify.Internal.Utils (eitherToMaybe)
import Node.Restify.Types (CacheControl, RestifyM, Response, RESTIFY)


cache :: forall e opts. CacheControl -> opts -> Handler e
cache val opts = HandlerM \_ res _ ->
  liftEff $ runFn3 _cache res (show val) (toForeign opts)

cache' :: forall e. CacheControl -> Handler e
cache' val = HandlerM \_ res _ ->
  liftEff $ runFn2 _cache1 res (show val)

defaultCache :: forall e. Handler e
defaultCache = HandlerM \_ res _ ->
  liftEff $ runFn1 _defaultCache res

noCache :: forall e. Handler e
noCache = HandlerM \_ res _ ->
  liftEff $ runFn1 _noCache res

charSet :: forall e. String -> Handler e
charSet val = HandlerM \_ res _ ->
  liftEff $ runFn2 _charSet res val

setHeader :: forall e a. String -> a -> Handler e
setHeader key val = HandlerM \_ res _ ->
  liftEff $ runFn3 _setHeader res key val

getHeader :: forall e a. (Decode a) => String -> HandlerM (restify :: RESTIFY | e) (Maybe a)
getHeader key = HandlerM \_ res _ ->
  liftEff $ liftM1 (eitherToMaybe <<< runExcept <<< decode) (runFn2 _getHeader res key)

statusJsonHeaders :: forall e a b. Int -> a -> b -> Handler e
statusJsonHeaders code body headers = HandlerM \_ res _ ->
  liftEff $ runFn4 _statusJsonHeaders res code body headers

statusJson :: forall e a. Int -> a -> Handler e
statusJson code body = HandlerM \_ res _ ->
  liftEff $ runFn3 _statusJson res code body

json :: forall e a. a -> Handler e
json body = HandlerM \_ res _ ->
  liftEff $ runFn2 _json res body

link :: forall e. String -> String -> Handler e
link key value = HandlerM \_ res _ ->
  liftEff $ runFn3 _link res key value

statusSendHeaders :: forall e a b. Int -> a -> b -> Handler e
statusSendHeaders code body headers = HandlerM \_ res _ ->
  liftEff $ runFn4 _statusSendHeaders res code body headers

statusSend :: forall e a. Int -> a -> Handler e
statusSend code body = HandlerM \_ res _ ->
  liftEff $ runFn3 _statusSend res code body

send :: forall e a. a -> Handler e
send body = HandlerM \_ res _ ->
  liftEff $ runFn2 _send res body

statusSendRawHeaders :: forall e a b. Int -> a -> b -> Handler e
statusSendRawHeaders code body headers = HandlerM \_ res _ ->
  liftEff $ runFn4 _statusSendRawHeaders res code body headers

statusSendRaw :: forall e a. Int -> a -> Handler e
statusSendRaw code body = HandlerM \_ res _ ->
  liftEff $ runFn3 _statusSendRaw res code body

sendRaw :: forall e a. a -> Handler e
sendRaw body = HandlerM \_ res _ ->
  liftEff $ runFn2 _sendRaw res body

set :: forall e. String -> String -> Handler e
set name val = HandlerM \_ res _ ->
  liftEff $ runFn3 _set res name val

setHeaders :: forall e a. a -> Handler e
setHeaders headers = HandlerM \_ res _ ->
  liftEff $ runFn2 _setHeaders res headers

status :: forall e. Int -> Handler e
status code = HandlerM \_ res _ ->
  liftEff $ runFn2 _status res code

redirect :: forall e a. a -> Handler e
redirect opts = HandlerM \_ res nxt ->
  liftEff $ runFn3 _redirect res opts nxt

statusRedirect :: forall e. Int -> String -> Handler e
statusRedirect code url = HandlerM \_ res nxt ->
  liftEff $ runFn4 _statusRedirect res code url nxt

foreign import _cache :: forall e a. Fn3 Response String a (RestifyM e Unit)

foreign import _cache1 :: forall e. Fn2 Response String (RestifyM e Unit)

foreign import _defaultCache :: forall e. Fn1 Response (RestifyM e Unit)

foreign import _noCache :: forall e. Fn1 Response (RestifyM e Unit)

foreign import _charSet :: forall e. Fn2 Response String (RestifyM e Unit)

foreign import _setHeader :: forall e a. Fn3 Response String a (RestifyM e Unit)

foreign import _getHeader :: forall e. Fn2 Response String (RestifyM e Foreign)

foreign import _statusJsonHeaders :: forall e a b. Fn4 Response Int a b (RestifyM e Unit)

foreign import _statusJson :: forall e a. Fn3 Response Int a (RestifyM e Unit)

foreign import _json :: forall e a. Fn2 Response a (RestifyM e Unit)

foreign import _link :: forall e. Fn3 Response String String (RestifyM e Unit)

foreign import _statusSendHeaders :: forall e a b. Fn4 Response Int a b (RestifyM e Unit)

foreign import _statusSend :: forall e a. Fn3 Response Int a (RestifyM e Unit)

foreign import _send :: forall e a. Fn2 Response a (RestifyM e Unit)

foreign import _statusSendRawHeaders :: forall e a b. Fn4 Response Int a b (RestifyM e Unit)

foreign import _statusSendRaw :: forall e a. Fn3 Response Int a (RestifyM e Unit)

foreign import _sendRaw :: forall e a. Fn2 Response a (RestifyM e Unit)

foreign import _set :: forall e. Fn3 Response String String (RestifyM e Unit)

foreign import _setHeaders :: forall e a. Fn2 Response a (RestifyM e Unit)

foreign import _status :: forall e. Fn2 Response Int (RestifyM e Unit)

foreign import _redirect :: forall e a. Fn3 Response a (RestifyM e Unit) (RestifyM e Unit)

foreign import _statusRedirect :: forall e. Fn4 Response Int String (RestifyM e Unit) (RestifyM e Unit)
