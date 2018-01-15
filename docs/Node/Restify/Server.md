## Module Node.Restify.Server

#### `ServerM`

``` purescript
data ServerM e a
  = ServerM (Server -> Eff e a)
```

Monad responsible for server related operations (initial setup mostly).

##### Instances
``` purescript
Functor (ServerM e)
Apply (ServerM e)
Applicative (ServerM e)
Bind (ServerM e)
Monad (ServerM e)
MonadEff eff (ServerM eff)
```

#### `Server`

``` purescript
type Server e = ServerM (restify :: RESTIFY | e) Unit
```

#### `listenHttp`

``` purescript
listenHttp :: forall e opts. Port -> opts -> Server e -> RestifyM e Unit
```

Create a Restify server with the given options, perform the given setup actions,
and start it running on the given port.

#### `listenHttp'`

``` purescript
listenHttp' :: forall e. Port -> Server e -> RestifyM e Unit
```

Create a Restify server with the default options, perform the given setup actions,
and start it running on the given port.

#### `apply`

``` purescript
apply :: forall e. Server e -> Server -> RestifyM e Unit
```

Apply Server actions to a Restify server.

#### `http`

``` purescript
http :: forall e opts. MethodOpts opts => Method -> opts -> Handler e -> Server e
```

Bind specified handler to handle request matching route and method.

#### `get`

``` purescript
get :: forall e opts. MethodOpts opts => opts -> Handler e -> Server e
```

Shortcut for `http GET`

#### `head`

``` purescript
head :: forall e opts. MethodOpts opts => opts -> Handler e -> Server e
```

Shortcut for `http HEAD`

#### `post`

``` purescript
post :: forall e opts. MethodOpts opts => opts -> Handler e -> Server e
```

Shortcut for `http POST`

#### `put`

``` purescript
put :: forall e opts. MethodOpts opts => opts -> Handler e -> Server e
```

Shortcut for `http PUT`

#### `patch`

``` purescript
patch :: forall e opts. MethodOpts opts => opts -> Handler e -> Server e
```

Shortcut for `http PATCH`

#### `del`

``` purescript
del :: forall e opts. MethodOpts opts => opts -> Handler e -> Server e
```

Shortcut for `http DEL`

#### `opts`

``` purescript
opts :: forall e opts. MethodOpts opts => opts -> Handler e -> Server e
```

Shortcut for `http OPTS`


