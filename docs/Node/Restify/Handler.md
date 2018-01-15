## Module Node.Restify.Handler

#### `HandlerM`

``` purescript
newtype HandlerM e a
  = HandlerM (Request -> Response -> Eff e Unit -> Aff e a)
```

Monad responsible for handling a single request.

##### Instances
``` purescript
Functor (HandlerM e)
Apply (HandlerM e)
Applicative (HandlerM e)
Bind (HandlerM e)
Monad (HandlerM e)
MonadEff eff (HandlerM eff)
MonadAff eff (HandlerM eff)
```

#### `Handler`

``` purescript
type Handler e = HandlerM (restify :: RESTIFY | e) Unit
```

#### `runHandlerM`

``` purescript
runHandlerM :: forall e. Handler e -> Request -> Response -> RestifyM e Unit -> RestifyM e Unit
```

#### `next`

``` purescript
next :: forall e. Handler e
```

Call next handler/plugin in a chain.

#### `nextThrow`

``` purescript
nextThrow :: forall e a. Error -> HandlerM (restify :: RESTIFY | e) a
```

Call next handler/plugin and pass error to it.


