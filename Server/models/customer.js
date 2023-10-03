const mongoose = require("mongoose");

const customerSchema = new mongoose.Schema({
  idKCus: String,
  nameCus: String,
  emailCus: String,
  birthday: Date,
  address: String,
  listBookingHotel: [
    {
      idHotel: String,
      idRoom: String,
    },
  ],
});

const Customer = mongoose.model('Customer', customerSchema ,'Customer');
module.exports = Customer;