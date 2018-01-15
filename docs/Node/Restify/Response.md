## Module Node.Restify.Response

#### `cache`

``` purescript
cache :: forall e opts. CacheControl -> opts -> Handler e
```

#### `cache'`

``` purescript
cache' :: forall e. CacheControl -> Handler e
```

#### `defaultCache`

``` purescript
defaultCache :: forall e. Handler e
```

#### `noCache`

``` purescript
noCache :: forall e. Handler e
```

#### `charSet`

``` purescript
charSet :: forall e. String -> Handler e
```

#### `setHeader`

``` purescript
setHeader :: forall e a. String -> a -> Handler e
```

#### `getHeader`

``` purescript
getHeader :: forall e a. Decode a => String -> HandlerM (restify :: RESTIFY | e) (Maybe a)
```

#### `statusJsonHeaders`

``` purescript
statusJsonHeaders :: forall e a b. Int -> a -> b -> Handler e
```

#### `statusJson`

``` purescript
statusJson :: forall e a. Int -> a -> Handler e
```

#### `json`

``` purescript
json :: forall e a. a -> Handler e
```

#### `link`

``` purescript
link :: forall e. String -> String -> Handler e
```

#### `statusSendHeaders`

``` purescript
statusSendHeaders :: forall e a b. Int -> a -> b -> Handler e
```

#### `statusSend`

``` purescript
statusSend :: forall e a. Int -> a -> Handler e
```

#### `send`

``` purescript
send :: forall e a. a -> Handler e
```

#### `statusSendRawHeaders`

``` purescript
statusSendRawHeaders :: forall e a b. Int -> a -> b -> Handler e
```

#### `statusSendRaw`

``` purescript
statusSendRaw :: forall e a. Int -> a -> Handler e
```

#### `sendRaw`

``` purescript
sendRaw :: forall e a. a -> Handler e
```

#### `set`

``` purescript
set :: forall e. String -> String -> Handler e
```

#### `setHeaders`

``` purescript
setHeaders :: forall e a. a -> Handler e
```

#### `status`

``` purescript
status :: forall e. Int -> Handler e
```

#### `redirect`

``` purescript
redirect :: forall e a. a -> Handler e
```

#### `statusRedirect`

``` purescript
statusRedirect :: forall e. Int -> String -> Handler e
```


