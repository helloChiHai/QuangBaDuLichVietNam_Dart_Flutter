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
            id: String,
            name: String,
            avatar: String,
            about: String,
            address: String,
            Ticket: String,
            introducing: [
              {
                idIntro: String,
                contentIntro: String,
                imageIntro: String,
              },
            ],
            perfectTime: String,
            placesAround: [
              {
                id: String,
                name: String,
                contentIntroducing: String,
              },
            ],
          },
        ],
      },
    ],
  });
  
const Region = mongoose.model('Region', regionSchema, 'Region');

module.exports = Region;
