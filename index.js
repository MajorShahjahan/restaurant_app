const express = require('express');
const bodyParser = require('body-parser');
const router = express.Router();
const cors = require('cors');
const app = express();
const port = 9000;
const { uuid } = require('uuidv4');

// Import Dish class from dish.js
const Dish = require('./dish');

// setup middleware
app.use(bodyParser.json());
app.use(cors());

// dishes array
let _dishes = [];

// get dishes
router.get('/dishes', (req, res) => {
  res.json({
    status: 'OK',
    data: _dishes,
  });
});

// clear dishes
router.get('/dishes/clear', (req, res) => {
  _dishes = [];

  res.json({
    status: 'OK',
  });
});

// get dish by id
router.get('/dishes/:_id', (req, res) => {
  const dish = _dishes.find((x) => x._id === req.params._id);

  res.json({
    status: 'OK',
    data: dish ? dish : null,
  });
});

// insert dish
router.post('/insertDish', (req, res) => {
  if (!req.body) {
    res.json({
      status: 'Failed',
      message: 'No content provided',
    });
  } else {
    const dishData = req.body;
    const dish = new Dish(
      dishData.name,
      dishData.shortDescription,
      dishData.price,
      dishData.category,
      dishData.availability,
      dishData.isActive,
      dishData.waitTime
    );

    dish._id = uuid();
    dish._Created = new Date();
    dish._Changed = null;

    _dishes.push(dish);

    res.json({
      status: 'OK',
      data: dish,
    });
  }
});

// update dish
router.put('/updateDish/:_id', (req, res) => {
  if (!req.body) {
    res.json({
      status: 'Failed',
      message: 'No content provided',
    });
  } else {
    const dishData = req.body;
    const dishIndex = _dishes.findIndex((x) => x._id === req.params._id);

    if (dishIndex >= 0) {
      const dish = _dishes[dishIndex];
      dish.name = dishData.name;
      dish.shortDescription = dishData.shortDescription;
      dish.price = dishData.price;
      dish.category = dishData.category;
      dish.availability = dishData.availability;
      dish._Changed = new Date();

      _dishes[dishIndex] = dish;

      res.json({
        status: 'OK',
        data: dish,
      });
    } else {
      res.json({
        status: `dish not found for _id ${req.params._id}`,
      });
    }
  }
});

// delete dish
router.delete('/deleteDish/:_id', (req, res) => {
  const dishIndex = _dishes.findIndex((x) => x._id === req.params._id);

  if (dishIndex !== -1) {
    _dishes.splice(dishIndex, 1);

    res.json({
      status: 'OK',
      message: 'Dish deleted',
    });
  } else {
    res.json({
      status: 'Failed',
      message: 'Dish not found',
    });
  }
});

// use router middleware
app.use(router);

// start server
app.listen(port, () => {
  console.log(`API is ready on http://localhost:${port}`);
});
