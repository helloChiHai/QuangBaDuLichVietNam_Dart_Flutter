const mongoose = require("mongoose");

const provinceSchema = new mongoose.Schema({
  idprovince: String,
  nameprovince: String,
});

const Province = mongoose.model("Province", provinceSchema, "Province");
module.exports = Province;
