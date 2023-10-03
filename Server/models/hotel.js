const mongoose = require("mongoose");

const hotelSchema = new mongoose.Schema({
  idHotel: String,
  nameHotel: String,
  imageHotel: String,
  address: String,
  services: [
    {
      typeServices: String,
      nameServices: String,
    },
  ],
  review: Number,
  star: Number,
  kindOfRoom: [
    {
      idRoom: String,
      typeRoom: Number,
      quantity: Number,
      bed: Number,
      price: Number,
      comfortable: [
        {
          iconComfortable: String,
          nameComfortable: Number,
        },
      ],
      bookingDate: Date,
      checkOutDate: Date,
      statusRoom: Number,
    },
  ],
  statusHotel: Number,
});


const Hotel = mongoose.model('Hotel', hotelSchema ,'Hotel');

module.exports = Hotel;