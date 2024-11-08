const { prisma } = require('../lib/prisma');
const { ApiError } = require('../utils/errors');

class ShopService {
  async getAllShops() {
    return await prisma.shop.findMany();
  }

  async getShopById(id) {
    const shop = await prisma.shop.findUnique({ where: { id } });
    if (!shop) throw new ApiError(404, 'Shop not found');
    return shop;
  }

  async createShop(data) {
    return await prisma.shop.create({ 
      data: {
        ...data,
        createdAt: new Date(),
        updatedAt: new Date()
      } 
    });
  }

  async updateShop(id, data) {
    const shop = await this.getShopById(id);
    return await prisma.shop.update({
      where: { id },
      data: {
        ...data,
        updatedAt: new Date()
      }
    });
  }

  async deleteShop(id) {
    await this.getShopById(id);
    await prisma.shop.delete({ where: { id } });
  }
}

module.exports = { ShopService };