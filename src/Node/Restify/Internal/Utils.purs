module Node.Restify.Internal.Utils where

import Prelude

import Data.Either (Either(..))
import Data.Function.Uncurried (Fn2)
import Data.Maybe (Maybe(..))
import Control.Monad.Eff.Exception (Error)

import Node.Restify.Types (RestifyM)


eitherToMaybe :: forall a e. Either e a -> Maybe a
eitherToMaybe (Left _)  = Nothing
eitherToMaybe (Right v) = Just v

foreign import nextWithError :: forall e a. Fn2 (RestifyM e Unit) Error (RestifyM e a)
