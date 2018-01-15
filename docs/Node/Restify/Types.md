## Module Node.Restify.Types

#### `RESTIFY`

``` purescript
data RESTIFY :: Effect
```

#### `RestifyM`

``` purescript
type RestifyM e a = Eff (restify :: RESTIFY | e) a
```

#### `Server`

``` purescript
data Server :: Type
```

#### `Router`

``` purescript
data Router :: Type
```

#### `Request`

``` purescript
data Request :: Type
```

#### `Response`

``` purescript
data Response :: Type
```

#### `Method`

``` purescript
data Method
  = GET
  | HEAD
  | POST
  | PUT
  | PATCH
  | DEL
  | OPTS
```

##### Instances
``` purescript
Show Method
```

#### `Port`

``` purescript
type Port = Int
```

#### `RoutePath`

``` purescript
class RoutePath a 
```

##### Instances
``` purescript
RoutePath String
RoutePath Regex
```

#### `RouteVersion`

``` purescript
class RouteVersion a 
```

##### Instances
``` purescript
RouteVersion String
RouteVersion (Array String)
```

#### `MethodOpts`

``` purescript
class MethodOpts a 
```

##### Instances
``` purescript
MethodOpts String
MethodOpts Regex
MethodOpts (Options a b)
```

#### `Options`

``` purescript
newtype Options a b
  = Options { name :: String, path :: RoutePath a => a, version :: RouteVersion b => b }
```

##### Instances
``` purescript
MethodOpts (Options a b)
```

#### `RequestParam`

``` purescript
class RequestParam a 
```

##### Instances
``` purescript
RequestParam String
RequestParam Number
```

#### `CacheControl`

``` purescript
data CacheControl
  = PUBLIC
  | PRIVATE
```

##### Instances
``` purescript
Show CacheControl
```


