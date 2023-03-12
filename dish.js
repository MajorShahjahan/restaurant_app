class Dish {
  constructor(name, shortDescription, price, category, availability, isActive,waitTime) {
    this.name = name;
    this.shortDescription = shortDescription;
    this.price = price;
    this.category = category;
    this.availability = availability;
    this.isActive = isActive;
    this.waitTime = waitTime;
  }
}
module.exports = Dish;