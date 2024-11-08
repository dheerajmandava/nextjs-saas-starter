const { z } = require('zod');
const { ApiResponse } = require('../utils/response');

const shopSchema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
  phone: z.string().optional(),
  address: z.string()
});

const validateShop = (req, res, next) => {
  const result = shopSchema.safeParse(req.body);
  
  if (!result.success) {
    return ApiResponse.error(res, 400, 'Validation failed', result.error.issues);
  }
  
  next();
};

// You might want to add more validation schemas and middleware
const jobCardSchema = z.object({
  customerName: z.string().min(2),
  customerPhone: z.string(),
  customerEmail: z.string().email().optional(),
  vehicleMake: z.string(),
  vehicleModel: z.string(),
  vehicleYear: z.number().optional(),
  registrationNo: z.string(),
  mileage: z.number().optional(),
  description: z.string(),
  estimatedCost: z.number().optional()
});

const validateJobCard = (req, res, next) => {
  const result = jobCardSchema.safeParse(req.body);
  
  if (!result.success) {
    return ApiResponse.error(res, 400, 'Validation failed', result.error.issues);
  }
  
  next();
};

module.exports = {
  validateShop,
  validateJobCard,
  shopSchema,
  jobCardSchema
}; 