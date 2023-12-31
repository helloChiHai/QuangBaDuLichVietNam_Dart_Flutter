const mongoose = require("mongoose");

const regionSchema = new mongoose.Schema({
  idRegion: String,
  nameRegion: String,
  provinces: [
    {
      idProvines: String,
      nameProvines: String,
      touristAttraction: [
        {
          idTourist: String,
          nameTourist: String,
          typeTourist: String,
          address: String,
          ticket: String,
          imgTourist: String,
          touristIntroduction: String,
          rightTime: [String],
          history: [
            {
              idHistoryStory: String,
              titleStoryStory: String,
              contentStoryStory: String,
              avatarHistory: String,
              imgHistory: String,
              videoHistory: String,
            }
          ],
          culture: [
            {
              idCulture: String,
              titleCulture: String,
              contentCulture: String,
              imgCulture: String,
              videoCulture: String,
            },
          ],
          specialtyDish: [
            {
              idDish: String,
              nameDish: String,
              addressDish: String,
              imgDish: String,
              dishIntroduction: String,
            },
          ],
          comment: [
            {
              idcmt: String,
              idCus: String,
              nameCus: String,
              imgCus: String,
              content: String,
              atTime: String,
            },
          ],
        },
      ],
    },
  ],
});

const Region = mongoose.model("Region", regionSchema, "Region");

module.exports = Region;
