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
const Province = require("./models/province");

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

// XÓA TÀI KHOẢN DỰA VÀO IDCus
app.delete("/deleteCustomer/:idCus", async (req, res) => {
  const idCus = req.params.idCus;

  try {
    const deletedCustomer = await Customer.findOneAndRemove({ idCus });

    if (!deletedCustomer) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy khách hàng" });
    }

    return res
      .status(200)
      .json({ success: true, message: "Tài khoản đã được xoá thành công" });
  } catch (error) {
    return res.status(500).json({ error: "Lỗi server" });
  }
});

// CẬP NHẬT EMAIL DỰA TRÊN IDCUS
app.put("/updateEmail/:idCus", async (req, res) => {
  const idCus = req.params.idCus;
  const newEmail = req.body.email;

  try {
    const updatedCustomer = await Customer.findOneAndUpdate(
      { idCus },
      { email: newEmail },
      { new: true }
    );

    if (!updatedCustomer) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy khách hàng" });
    }

    console.log("cập nhật Eamil thành công: " + updatedCustomer);
    return res.status(200).json({ success: true, data: updatedCustomer });
  } catch (error) {
    return res.status(500).json({ error: "Lỗi server" });
  }
});

// CẬP NHẬT NAME DỰA TRÊN IDCUS
app.put("/updateName/:idCus", async (req, res) => {
  const idCus = req.params.idCus;
  const newName = req.body.name;

  try {
    const updatedCustomer = await Customer.findOneAndUpdate(
      { idCus },
      { name: newName },
      { new: true }
    );

    if (!updatedCustomer) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy khách hàng" });
    }

    console.log("cập nhật Name thành công: " + updatedCustomer);
    return res.status(200).json({ success: true, data: updatedCustomer });
  } catch (error) {
    return res.status(500).json({ error: "Lỗi server" });
  }
});

// CẬP NHẬT PASSWORD DỰA TRÊN IDCUS
app.put("/updatePassword/:idCus", async (req, res) => {
  const idCus = req.params.idCus;
  const newPassword = req.body.password;

  try {
    const updatedCustomer = await Customer.findOneAndUpdate(
      { idCus },
      { password: newPassword },
      { new: true }
    );

    if (!updatedCustomer) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy khách hàng" });
    }

    return res.status(200).json({ success: true, data: updatedCustomer });
  } catch (error) {
    return res.status(500).json({ error: "Lỗi server" });
  }
});

// CẬP NHẬT ADDRESS DỰA TRÊN IDCUS
app.put("/updateAddress/:idCus", async (req, res) => {
  const idCus = req.params.idCus;
  const newAddress = req.body.address;

  try {
    const updatedCustomer = await Customer.findOneAndUpdate(
      { idCus },
      { address: newAddress },
      { new: true }
    );

    if (!updatedCustomer) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy khách hàng" });
    }

    return res.status(200).json({ success: true, data: updatedCustomer });
  } catch (error) {
    return res.status(500).json({ error: "Lỗi server" });
  }
});

// CẬP NHẬT BIRTHDAY DỰA TRÊN IDCUS
app.put("/updateBirthday/:idCus", async (req, res) => {
  const idCus = req.params.idCus;
  const newBirthday = req.body.birthday;

  try {
    const updatedCustomer = await Customer.findOneAndUpdate(
      { idCus },
      { birthday: newBirthday },
      { new: true }
    );

    if (!updatedCustomer) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy khách hàng" });
    }

    return res.status(200).json({ success: true, data: updatedCustomer });
  } catch (error) {
    return res.status(500).json({ error: "Lỗi server" });
  }
});

// hiển thị danh sách các tỉnh thành phố
app.get("/getAllProvinces", async (req, res) => {
  try {
    const province = await Province.find({});
    res.status(200).json({ success: true, data: province });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// lọc địa điểm du lịch theo idRegion và idProvines
app.get("/filter-tourist-attractions", async (req, res) => {
  try {
    const idRegion = req.query.idRegion;
    const idProvines = req.query.idProvines;
    let touristAttractions = [];
    const result = await Region.find({});

    if (idRegion) {
      result.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (region.idRegion === idRegion) {
              touristAttractions.push(touristAttraction);
            }
          });
        });
      });
    } else if (idProvines) {
      result.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (province.idProvines === idProvines) {
              touristAttractions.push(touristAttraction);
            }
          });
        });
      });
    } else {
      result.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            touristAttractions.push(touristAttraction);
          });
        });
      });
    }

    res.status(200).json({ success: true, data: touristAttractions });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

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

// hiển thị các địa điểm du lịch
app.get("/getAllTouristAttraction", async (req, res) => {
  try {
    const regions = await Region.find({});
    const tatCaDiaDiemDuLich = [];

    regions.forEach((region) => {
      region.provinces.forEach((province) => {
        province.touristAttraction.forEach((touristAttraction) => {
          tatCaDiaDiemDuLich.push(touristAttraction);
        });
      });
    });
    res.status(200).json({ success: true, data: tatCaDiaDiemDuLich });
  } catch (error) {
    console.log(e);
    res.status(500).json({
      success: false,
      error: "Lỗi khi lấy danh sách các địa điểm du lịch",
    });
  }
});

// hiển thị địa điểm du lịch theo idTourist (CHI TIẾT ĐỊA ĐIỂM DU LỊCH THEO IdTourist)
app.get("/getTouristAttractionByIdTourist/:idTourist", async (req, res) => {
  try {
    const idTourist = req.params.idTourist;
    let matchingTouristAttraction = null;

    const regions = await Region.find({}); // Lấy tất cả dữ liệu vùng

    regions.some((region) => {
      return region.provinces.some((province) => {
        return province.touristAttraction.some((attraction) => {
          if (attraction.idTourist === idTourist) {
            matchingTouristAttraction = attraction;
            return true;
          }
          return false;
        });
      });
    });

    if (!matchingTouristAttraction) {
      return res.status(404).json({
        success: false,
        message:
          "Không tìm thấy điểm du lịch nào dựa trên idTourist đã cung cấp",
      });
    }

    res.status(200).json({ success: true, data: matchingTouristAttraction });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      error: "Lỗi khi lấy thông tin điểm du lịch dựa trên idTourist",
    });
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
          attraction.specialtyDish.forEach((specialtyDish) => {
            tatCaMonDacSan.push(specialtyDish);
          });
        });
      });
    });

    res.status(200).json({ success: true, data: tatCaMonDacSan });
  } catch (error) {
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
    res.status(500).json({
      success: false,
      error: "Lỗi khi lấy danh sách thông tin văn hóa",
    });
  }
});

// HIỂN THỊ TẤT CẢ LỊCH SỬ
app.get("/getAllHistory", async (req, res) => {
  try {
    const regions = await Region.find({});
    const tatCaThongTinLichSu = [];

    regions.forEach((region) => {
      region.provinces.forEach((province) => {
        province.touristAttraction.forEach((attraction) => {
          attraction.history.forEach((_history) => {
            tatCaThongTinLichSu.push(_history);
          });
        });
      });
    });

    res.status(200).json({ success: true, data: tatCaThongTinLichSu });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      error: "Lỗi khi lấy danh sách thông tin lịch sử",
    });
  }
});

// hiển thị địa điểm du lịch theo idCulture (VĂN HÓA)
app.get("/getTouristAttractionByIdCulture/:idCulture", async (req, res) => {
  try {
    const idCulture = req.params.idCulture;
    let matchingTouristAttraction = null;

    const regions = await Region.find({}); // Lấy tất cả dữ liệu vùng

    regions.some((region) => {
      return region.provinces.some((province) => {
        return province.touristAttraction.some((attraction) => {
          return attraction.culture.some((culture) => {
            if (culture.idCulture === idCulture) {
              matchingTouristAttraction = attraction;
              return true;
            }
            return false;
          });
        });
      });
    });

    if (!matchingTouristAttraction) {
      return res.status(404).json({
        success: false,
        message:
          "Không tìm thấy điểm du lịch nào dựa trên idCulture đã cung cấp",
      });
    }

    res.status(200).json({ success: true, data: matchingTouristAttraction });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      error: "Lỗi khi lấy thông tin điểm du lịch dựa trên idCulture",
    });
  }
});

// hiển thị địa điểm du lịch theo idDish (MÓN ĂN)
app.get("/getTouristAttractionByIdDish/:idDish", async (req, res) => {
  try {
    const idDish = req.params.idDish;
    let matchingTouristAttraction = null;

    const regions = await Region.find({});

    regions.some((region) => {
      return region.provinces.some((province) => {
        return province.touristAttraction.some((attraction) => {
          return attraction.specialtyDish.some((specialtyDish) => {
            if (specialtyDish.idDish === idDish) {
              matchingTouristAttraction = attraction;
              return true;
            }
            return false;
          });
        });
      });
    });

    if (!matchingTouristAttraction) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy điểm du lịch nào dựa trên idDish đã cung cấp",
      });
    }

    res.status(200).json({ success: true, data: matchingTouristAttraction });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      error: "Lỗi khi lấy thông tin điểm du lịch dựa trên idDish",
    });
  }
});

// hiển thị địa điểm du lịch theo idHistoryStory (LỊCH SỬ)
app.get(
  "/getTouristAttractionByidHistoryStory/:idHistoryStory",
  async (req, res) => {
    try {
      const idHistoryStory = req.params.idHistoryStory;
      let matchingTouristAttraction = null;

      const regions = await Region.find({});

      regions.some((region) => {
        return region.provinces.some((province) => {
          return province.touristAttraction.some((attraction) => {
            return attraction.history.some((history) => {
              if (history.idHistoryStory === idHistoryStory) {
                matchingTouristAttraction = attraction;
                return true;
              }
              return false;
            });
          });
        });
      });

      if (!matchingTouristAttraction) {
        return res.status(404).json({
          success: false,
          message:
            "Không tìm thấy điểm du lịch nào dựa trên idHistory đã cung cấp",
        });
      }

      res.status(200).json({ success: true, data: matchingTouristAttraction });
    } catch (error) {
      console.error(error);
      res.status(500).json({
        success: false,
        error: "Lỗi khi lấy thông tin điểm du lịch dựa trên idHistory",
      });
    }
  }
);

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
    const { email, password, name, imgCus, address, birthday, role } = req.body;

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
      imgCus,
      address,
      birthday,
      role,
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