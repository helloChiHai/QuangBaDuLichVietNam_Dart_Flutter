const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const app = express();
const port = 3090;
const { v4: uuidv4 } = require("uuid");

mongoose.connect("mongodb://127.0.0.1/DACN_APP_DuLich", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const Region = require("./models/region");
const Customer = require("./models/customer");

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

// hiển thị danh sách các khách hàng
app.get("/customers", async (req, res) => {
  try {
    const user = await Customer.find({});
    res.status(200).json({ success: true, data: user });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// đăng nhập
app.post("/login", async (req, res) => {
  try {
    const user = await Customer.findOne({
      email: req.body.email,
      password: req.body.password,
    });
    console.log(req.body);
    if (!user) {
      res.status(401).json({
        success: false,
        message: "Tên tài khoản hoặc mật khẩu không đúng",
      });
      console.log("\n------------ sai email hoặc pass ------------\n");
      return;
    }

    res.status(200).json({
      success: true,
      data: user,
    });
    console.log(
      "\n ------------>>>>> trả về user: " + user + "\n------------\n"
    );
  } catch (error) {
    console.log(error); // In lỗi ra console để xem
    return res.status(500).json({ success: false, error: error.message });
  }
});

// tạo tài khoảng
app.post("/createAccount", async (req, res) => {
  try {
    const { email, password, name, address, birthday } = req.body;

    // kiểm tra email đã tồn tại hay chưa
    const existingUser = await Customer.findOne({ email: email });

    if (existingUser) {
      res
        .status(409)
        .json({ success: false, message: "Email đã tồn tại trong hệ thống" });
      return;
    }

    const customer = new Customer({
      idCus: uuidv4(),
      email,
      password,
      name,
      address,
      birthday,
    });
    await customer.save();
    res.status(201).json(customer);
    console.log(
      "\n ------------>>>>> thông tin tài khoản mới: " +
        customer +
        "\n------------\n"
    );
  } catch (error) {
    console.error(error);
    res.status(500).send("Lỗi khi thêm khách hàng mới");
  }
});

// ---------------
app.listen(port, () => console.log(`listening at http://localhost:${port}`));
