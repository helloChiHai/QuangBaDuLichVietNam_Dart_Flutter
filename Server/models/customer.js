const mongoose = require("mongoose");

const customerSchema = new mongoose.Schema({
  idCus: String,
  email: String,
  password: String,
  name: String,
  address: String,
  birthday: String,
});

const Customer = mongoose.model("Customer", customerSchema, "Customer");
module.exports = Customer;
