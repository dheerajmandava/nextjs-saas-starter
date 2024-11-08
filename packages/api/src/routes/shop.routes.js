const { Router } = require('express');
const { ShopController } = require('../controllers/shop.controller');
const { authenticate, requireShopOwner } = require('../middleware/auth');
const { validateShop } = require('../middleware/validation');

const router = Router();
const shopController = new ShopController();

router
  .route('/')
  .get(authenticate, shopController.getAllShops)
  .post(requireShopOwner, validateShop, shopController.createShop);

router
  .route('/:id')
  .get(authenticate, shopController.getShopById)
  .patch(requireShopOwner, validateShop, shopController.updateShop)
  .delete(requireShopOwner, shopController.deleteShop);

module.exports = router; 