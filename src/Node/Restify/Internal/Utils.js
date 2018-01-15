"use strict";

// module Node.Restify.Internal.Utils

exports.nextWithError = function(next, error) {
    return function() {
        next(error);
    };
};
