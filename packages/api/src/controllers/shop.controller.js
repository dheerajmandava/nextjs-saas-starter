const { ShopService } = require('../services/shop.service');
const { ApiResponse } = require('../utils/response');
const { catchAsync } = require('../utils/catchAsync');
const { ApiError } = require('../utils/errors');

class ShopController {
  constructor() {
    this.shopService = new ShopService();
  }

  createShop = catchAsync(async (req, res) => {
    // req.auth.userId is available from Clerk
    const shop = await this.shopService.createShop({
      ...req.body,
      ownerId: req.auth.userId
    });
    
    ApiResponse.success(res, 201, 'Shop created successfully', shop);
  });

  getShopById = catchAsync(async (req, res) => {
    const shop = await this.shopService.getShopById(req.params.id);
    
    // Check if user has access to this shop
    if (shop.ownerId !== req.auth.userId) {
      return ApiResponse.error(res, 403, 'Access denied');
    }
    
    ApiResponse.success(res, 200, 'Shop retrieved successfully', shop);
  });
}

module.exports = { ShopController }; 