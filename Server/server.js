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

// thêm bình luận
app.post("/addComment", async (req, res) => {
  try {
    const { regionId, provinceId, touristId, idCus, commentData } = req.body;
    const region = await Region.findOne({ idRegion: regionId });
    if (!region) {
      return res
        .status(404)
        .json({ success: false, message: "Khu vực không tồn tại" });
    }
    const province = region.provinces.find(
      (prov) => prov.idProvines === provinceId
    );
    if (!province) {
      return res
        .status(404)
        .json({ success: false, message: "Tỉnh/thành phố không tồn tại" });
    }
    const touristAttraction = province.touristAttraction.find(
      (attraction) => attraction.idTourist === touristId
    );
    if (!touristAttraction) {
      return res
        .status(404)
        .json({ success: false, message: "Điểm du lịch không tồn tại" });
    }

    const customer = await Customer.findOne({ idCus: idCus });

    if (!customer) {
      return res
        .status(404)
        .json({ success: false, message: "Khách hàng không tồn tại" });
    }

    const newComment = {
      idcmt: uuidv4(),
      idCus: idCus,
      name: customer.name,
      content: commentData,
      atTime: new Date().toISOString(),
    };
    touristAttraction.comment.push(newComment);
    await region.save();
    res
      .status(200)
      .json({ success: true, message: "Bình luận đã được thêm thành công" });
    console.log("Bình luận đã được thêm thành công");
    console.log(newComment);
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Lỗi khi thêm bình luận" });
  }
});

// sửa bình luận
app.put("/editComment", async (req, res) => {
  try {
    const { regionId, provinceId, touristId, commentId, idCus, editedComment } =
      req.body;
    const region = await Region.findOne({ idRegion: regionId });
    if (!region) {
      return res
        .status(404)
        .json({ success: false, message: "Khu vực không tồn tại" });
    }
    const province = region.provinces.find(
      (prov) => prov.idProvines === provinceId
    );
    if (!province) {
      return res
        .status(404)
        .json({ success: false, message: "Tỉnh/thành phố không tồn tại" });
    }
    const touristAttraction = province.touristAttraction.find(
      (attraction) => attraction.idTourist === touristId
    );
    if (!touristAttraction) {
      return res
        .status(404)
        .json({ success: false, message: "Điểm du lịch không tồn tại" });
    }
    const commentToEdit = touristAttraction.comment.find(
      (comment) => comment.idcmt === commentId
    );
    if (!commentToEdit) {
      return res
        .status(404)
        .json({ success: false, message: "Bình luận không tồn tại" });
    }

    const customer = await Customer.findOne({ idCus: idCus });

    if (!customer) {
      return res
        .status(404)
        .json({ success: false, message: "Khách hàng không tồn tại" });
    }
    commentToEdit.content = editedComment;
    await region.save();
    res
      .status(200)
      .json({ success: true, message: "Bình luận đã được sửa thành công" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Lỗi khi sửa bình luận" });
  }
});

// xóa bình luận
app.delete("/deleteComment", async (req, res) => {
  try {
    const { regionId, provinceId, touristId, commentId, idCus } = req.body;

    const region = await Region.findOne({ idRegion: regionId });

    if (!region) {
      return res
        .status(404)
        .json({ success: false, message: "Khu vực không tồn tại" });
    }

    const province = region.provinces.find(
      (prov) => prov.idProvines === provinceId
    );

    if (!province) {
      return res
        .status(404)
        .json({ success: false, message: "Tỉnh/thành phố không tồn tại" });
    }

    const touristAttraction = province.touristAttraction.find(
      (attraction) => attraction.idTourist === touristId
    );

    if (!touristAttraction) {
      return res
        .status(404)
        .json({ success: false, message: "Điểm du lịch không tồn tại" });
    }

    const customer = await Customer.findOne({ idCus: idCus });

    if (!customer) {
      return res
        .status(404)
        .json({ success: false, message: "Khách hàng không tồn tại" });
    }

    const commentIndex = touristAttraction.comment.findIndex(
      (comment) => comment.idcmt === commentId
    );

    if (commentIndex === -1) {
      return res
        .status(404)
        .json({ success: false, message: "Bình luận không tồn tại" });
    }

    // Xóa bình luận khỏi mảng "comment"
    touristAttraction.comment.splice(commentIndex, 1);

    // Lưu cập nhật vào cơ sở dữ liệu
    await region.save();

    res
      .status(200)
      .json({ success: true, message: "Bình luận đã được xóa thành công" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Lỗi khi xóa bình luận" });
  }
});

// hiển thị danh sách các khu vực
app.get("/regions", async (req, res) => {
  try {
    const regions = await Region.find({});
    res.status(200).json({ success: true, data: regions });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// hiển thị tất cả các món đặc sản
app.get("/getAllSpecialtyDish", async (req, res) => {
  try {
    const regions = await Region.find({});
    const tatCaMonDacSan = [];

    regions.forEach((region) => {
      region.provinces.forEach((province) => {
        province.touristAttraction.forEach((attraction) => {
          tatCaMonDacSan.push(...attraction.specialtyDish);
        });
      });
    });

    res.status(200).json({ success: true, data: tatCaMonDacSan });
    console.log(data);
  } catch (error) {
    console.log(loi);
    console.error(error);
    res
      .status(500)
      .json({ success: false, error: "Lỗi khi lấy danh sách món đặc sản" });
  }
});

// hiển thị tất cả văn hóa
app.get("/getAllCulture", async (req, res) => {
  try {
    const regions = await Region.find({});
    const tatCaThongTinVanHoa = [];

    regions.forEach((region) => {
      region.provinces.forEach((province) => {
        province.touristAttraction.forEach((attraction) => {
          attraction.culture.forEach((culture) => {
            tatCaThongTinVanHoa.push(culture);
          });
        });
      });
    });

    res.status(200).json({ success: true, data: tatCaThongTinVanHoa });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({
        success: false,
        error: "Lỗi khi lấy danh sách thông tin văn hóa",
      });
  }
});

// Hiển thị tất cả các tỉnh/thành phố chứa culture với idCulture cụ thể
app.get("/provincesWithCulture/:idCulture", async (req, res) => {
  try {
    const idCultureToFind = req.params.idCulture; // Lấy idCulture từ yêu cầu

    const regions = await Region.find({});
    const provincesWithCulture = [];

    // Lặp qua các khu vực, tỉnh/thành phố và điểm du lịch để tìm tỉnh/thành phố chứa culture với idCulture tương ứng
    regions.forEach((region) => {
      region.provinces.forEach((province) => {
        province.touristAttraction.forEach((attraction) => {
          const matchingCulture = attraction.culture.find((culture) => culture._id === idCultureToFind);
          if (matchingCulture) {
            provincesWithCulture.push(province);
          }
        });
      });
    });

    res.status(200).json({ success: true, data: provincesWithCulture });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Lỗi khi lấy danh sách tỉnh/thành phố chứa culture" });
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
