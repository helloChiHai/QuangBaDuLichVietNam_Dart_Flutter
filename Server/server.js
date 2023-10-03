const express = require("express");
const mongoose = require("mongoose");
const app = express();
const port = 3090;

const Region = require("./models/region");

mongoose.connect("mongodb://127.0.0.1/DACN_APP_DuLich", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const checkMongoDBConnection = () => {
  mongoose.connection.on('open', () => {
    console.log('Connected to MongoDB');
  });

  mongoose.connection.on('error', (err) => {
    console.error('MongoDB connection error:', err);
  });
};

checkMongoDBConnection();

app.get('/regions', async (req, res) => {
  try {
    const regions = await Region.find({});
    res.status(200).json({ success: true, data: regions });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

app.listen(port, () => console.log(`listening at http://localhost:${port}`));
