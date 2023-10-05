const mongoose = require("mongoose");

const customerSchema = new mongoose.Schema({
  idKCus: String,
  type: Number,
  account: String,
  password: String,
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
  token: String,
});

const Customer = mongoose.model("Customer", customerSchema, "Customer");
module.exports = Customer;
