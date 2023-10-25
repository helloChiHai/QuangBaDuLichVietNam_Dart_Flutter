const mongoose = require("mongoose");

const regionSchema = new mongoose.Schema({
  idRegion: String,
  nameRegion: String,
  // provinces: [
  //   {
  //     idProvines: String,
  //     nameProvines: String,
  //     touristAttraction: [
  //       {
  //         idTourist: String,
  //         nameTourist: String,
  //         address: String,
  //         ticket: String,
  //         imgTourist: String,
  //         touristIntroduction: String,
  //         rightTime: [String],
  //         history: {
  //           historyStory: String,
  //           imgHistory: String,
  //           videoHistory: String,
  //         },
  //         culture: [
  //           {
  //             idCulture: String,
  //             nameCulture: String,
  //           },
  //         ],
  //         specialtyDish: [
  //           {
  //             idDish: String,
  //             nameDish: String,
  //             imgDish: String,
  //             dishIntroduction: String,
  //           },
  //         ],
  //         comment: [
  //           {
  //             idcmt: String,
  //             idCus: String,
  //             name: String,
  //             content: String,
  //             atTime: String,
  //           },
  //         ],
  //       },
  //     ],
  //   },
  // ],
});

const Region = mongoose.model("Region", regionSchema, "Region");

module.exports = Region;
