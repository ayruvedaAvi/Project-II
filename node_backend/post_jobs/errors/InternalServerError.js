const { StatusCodes } = require('http-status-codes');
const CustomAPIError = require('./custom-api');

class InternalServerError extends Error {
    constructor(message) {
        super(message);
        this.name = 'InternalServerError';
        this.statusCode = StatusCodes.INTERNAL_SERVER_ERROR;
    }
}

module.exports =InternalServerError;