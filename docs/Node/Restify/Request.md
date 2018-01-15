## Module Node.Restify.Request

#### `getRouteParam`

``` purescript
getRouteParam :: forall e a. RequestParam a => a -> HandlerM (restify :: RESTIFY | e) (Maybe String)
```

Get route param value. If it is a named route, e.g. `/user/:id`, then
`getRouteParam "id"` returns the matched part of the route. If it is a
regex route, e.g. `/user/(\d+)`, then `getRouteParam 1` returns the
part that matched `(\d+)` and `getRouteParam 0` returns the whole route.


