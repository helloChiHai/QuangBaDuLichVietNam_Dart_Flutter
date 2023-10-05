const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const app = express();
const port = 3090;

mongoose.connect("mongodb://127.0.0.1/DACN_APP_DuLich", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const Region = require("./models/region");
const Customer = require("./models/customer");
const Hotel = require("./models/hotel");

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const checkMongoDBConnection = () => {
  mongoose.connection.on("open", () => {
    console.log("Connected to MongoDB");
  });

  mongoose.connection.on("error", (err) => {
    console.error("MongoDB connection error:", err);
  });
};

checkMongoDBConnection();

app.get("/regions", async (req, res) => {
  try {
    const regions = await Region.find({});
    res.status(200).json({ success: true, data: regions });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// customer
app.get("/customers", async (req, res) => {
  try {
    const customers = await Customer.find({});
    res.status(200).json({ success: true, data: customers });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// hotel
app.get("/hotels", async (req, res) => {
  try {
    const hotels = await Hotel.find({});
    res.status(200).json({ success: true, data: hotels });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// đăng nhập
app.post("/auth/login", async (req, res) => {
  try {
    const { account, password } = req.body;
    const customer = await Customer.findOne(account, password);

    if (!customer) {
      res.status(401).json({
        success: false,
        message: "Tên tài khoản hoặc mật khẩu không đúng",
      });
      return;
    }
    // return res
    //   .status(200)
    //   .json({ success: true, message: "Đăng nhập thành công", data: customer });
    return res.status(200).json({ success: true, data: customer });
  } catch (error) {
    return res.status(500).json({ success: false, error: error.message });
  }
});

app.listen(port, () => console.log(`listening at http://localhost:${port}`));
