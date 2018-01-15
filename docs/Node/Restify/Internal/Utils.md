## Module Node.Restify.Internal.Utils

#### `eitherToMaybe`

``` purescript
eitherToMaybe :: forall a e. Either e a -> Maybe a
```

#### `nextWithError`

``` purescript
nextWithError :: forall e a. Fn2 (RestifyM e Unit) Error (RestifyM e a)
```


