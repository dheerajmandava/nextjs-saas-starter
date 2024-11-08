const { ClerkExpressWithAuth } = require('@clerk/clerk-express');
const { prisma } = require('../lib/prisma');
const { ApiResponse } = require('../utils/response');

// Basic auth middleware
const authenticate = ClerkExpressWithAuth({
  onError: (err, req, res) => {
    console.error('Auth error:', err);
    return ApiResponse.error(res, 401, 'Unauthorized');
  },
});

// Role-based authorization
const requireRole = (allowedRoles) => {
  return async (req, res, next) => {
    try {
      if (!req.auth?.userId) {
        return ApiResponse.error(res, 401, 'Unauthorized');
      }

      const user = await prisma.user.findUnique({
        where: { clerkId: req.auth.userId },
        select: { role: true }
      });

      if (!user || !allowedRoles.includes(user.role)) {
        return ApiResponse.error(res, 403, 'Insufficient permissions');
      }

      next();
    } catch (error) {
      next(error);
    }
  };
};

// Predefined auth combinations
const requireAdmin = [authenticate, requireRole(['admin'])];
const requireShopOwner = [authenticate, requireRole(['shop_owner'])];

module.exports = {
  authenticate,
  requireRole,
  requireAdmin,
  requireShopOwner
}; 