const { errorHandler } = require('../utils/errors');

const errorMiddleware = (err, req, res, next) => {
  const error = errorHandler(err);
  res.status(error.statusCode).json({
    success: false,
    ...error
  });
};

module.exports = { errorMiddleware }; 