class ApiError extends Error {
  constructor(statusCode, message, code) {
    super(message);
    this.statusCode = statusCode;
    this.code = code;
    this.name = 'ApiError';
  }
}

const errorHandler = (error) => {
  if (error instanceof ApiError) {
    return {
      statusCode: error.statusCode,
      message: error.message,
      code: error.code
    };
  }

  return {
    statusCode: 500,
    message: 'Internal server error',
    code: 'INTERNAL_ERROR'
  };
};

module.exports = { 
  ApiError, 
  errorHandler 
}; 