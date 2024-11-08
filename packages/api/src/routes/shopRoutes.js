import { Router } from 'express';
import { ShopController } from '../controllers/shop.controller';
import { authenticate } from '../middleware/auth';
import { validateShop } from '../middleware/validation';

const router = Router();
const shopController = new ShopController();

router
  .route('/')
  .get(authenticate, shopController.getAllShops)
  .post(authenticate, validateShop, shopController.createShop);

router
  .route('/:id')
  .get(authenticate, shopController.getShopById)
  .patch(authenticate, validateShop, shopController.updateShop)
  .delete(authenticate, shopController.deleteShop);

export default router; 