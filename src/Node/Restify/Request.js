"use strict";

// module Node.Restify.Request

exports._getRouteParam = function(req, name) {
    return function() {
        return req.params[name];
    };
};
