const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const app = express();
const port = 3090;
const { v4: uuidv4 } = require("uuid");
const moment = require("moment");

mongoose.connect("mongodb://127.0.0.1/DACN_APP_DuLich", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const Region = require("./models/region");
const Customer = require("./models/customer");
const Province = require("./models/province");
const Admin = require("./models/Admin");

// Middleware để tăng giới hạn kích thước payload
app.use(bodyParser.json({ limit: "10mb" }));
app.use(bodyParser.urlencoded({ extended: true, limit: "10mb" }));

const checkMongoDBConnection = () => {
  mongoose.connection.on("open", () => {
    console.log("Connected to MongoDB");
  });

  mongoose.connection.on("error", (err) => {
    console.error("MongoDB connection error:", err);
  });
};

checkMongoDBConnection();

// ========================== ADMIN =================================================

// thêm địa điểm du lịch
app.post("/addTouristAttraction", async (req, res) => {
  try {
    const {
      idRegion,
      idProvines,
      nameTourist,
      typeTourist,
      address,
      ticket,
      imgTourist,
      touristIntroduction,
      rightTime,
      titleStoryStory,
      contentStoryStory,
      avatarHistory,
      imgHistory,
      videoHistory,
      titleCulture,
      contentCulture,
      imgCulture,
      videoCulture,
      nameDish,
      addressDish,
      imgDish,
      dishIntroduction,
      comment,
    } = req.body;

    const region = await Region.findOne({ idRegion: idRegion });

    if (!region) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy khu vực" });
    }

    let province = region.provinces.find((prov) => prov.idProvines === idProvines);

    if (!province) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy địa điểm" });
    }

    const idHistoryStory = `HIS_${uuidv4()}`;
    const history = [
      {
        idHistoryStory,
        titleStoryStory,
        contentStoryStory,
        avatarHistory,
        imgHistory,
        videoHistory,
      },
    ];

    const idCulture = `CUL_${uuidv4()}`;
    const culture = [
      {
        idCulture,
        titleCulture,
        contentCulture,
        imgCulture,
        videoCulture,
      },
    ];

    const idDish = `SPD_${uuidv4()}`;
    const specialtyDish = [
      {
        idDish,
        nameDish,
        addressDish,
        imgDish,
        dishIntroduction,
      },
    ];

    const idTourist = `TA_${uuidv4()}`;
    const newTouristAttraction = {
      idTourist,
      nameTourist,
      typeTourist,
      address,
      ticket,
      imgTourist,
      touristIntroduction,
      rightTime,
      history,
      culture,
      specialtyDish,
      comment,
    };
    province.touristAttraction.push(newTouristAttraction);

    await region.save();
    res.status(201).json({ success: true, message: "Thêm thành công" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ success: false, error: error.message });
  }
});

// đăng nhập
app.post("/loginAdmin", async (req, res) => {
  try {
    const admin = await Admin.findOne({
      account: req.body.account,
      password: req.body.password,
    });
    console.log(req.body);
    if (!admin) {
      res.status(401).json({
        success: false,
        message: "Tên tài khoản hoặc mật khẩu không đúng",
      });
      console.log("\n------------ sai email hoặc pass ------------\n");
      return;
    }

    res.status(200).json({
      success: true,
      data: admin,
    });
    console.log(
      "\n ------------>>>>> trả về admin: " + admin + "\n------------\n"
    );
  } catch (error) {
    console.log(error);
    return res.status(500).json({ success: false, error: error.message });
  }
});

//=====================================================================================================

//=============================== USER =========================================================

// LỌC ĐỊA ĐIỂM THEO THÀNH PHỐ, NÔNG THÔN, BIỂN, NÚI
app.get("/filterTypeTouist", async (req, res) => {
  try {
    const typeTourist = req.query.typeTourist;
    let touristList = [];
    const region = await Region.find({});

    if (typeTourist) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (touristAttraction.typeTourist === typeTourist) {
              touristList.push(touristAttraction);
            }
          });
        });
      });
    }
    res.status(200).json({ success: true, data: touristList });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// HIỂN THỊ ĐỊA ĐIỂM DU LỊCH TRONG DANH SÁCH YÊU THÍCH
app.get("/getTouristInFavoriteList/:idCus", async (req, res) => {
  const { idCus } = req.params;

  try {
    const customer = await Customer.findOne({ idCus });
    if (!customer) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy thông tin khách hàng.",
      });
    }
    const idTouristList = customer.listSaveTourist.map(
      (tourist) => tourist.idTourist
    );
    const touristAttractions = await Region.aggregate([
      {
        $unwind: "$provinces",
      },
      {
        $unwind: "$provinces.touristAttraction",
      },
      {
        $match: {
          "provinces.touristAttraction.idTourist": { $in: idTouristList },
        },
      },
      {
        $project: {
          _id: 0,
          touristAttraction: "$provinces.touristAttraction",
        },
      },
    ]);
    return res.json({
      success: true,
      data: touristAttractions.map((item) => item.touristAttraction),
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: "Đã xảy ra lỗi trong quá trình xử lý.",
    });
  }
});

// KIỂM TRA TOURIST CÓ TRONG DANH SÁCH YÊU THÍCH HAY CHƯA
app.get("/check-tourist/:idCus/:idTourist", async (req, res) => {
  try {
    const { idCus, idTourist } = req.params;

    const customer = await Customer.findOne({ idCus });

    if (!customer) {
      return res.status(404).json({ message: "Người dùng không tồn tại" });
    }

    const isTouristSaved = customer.listSaveTourist.some(
      (tourist) => tourist.idTourist === idTourist
    );

    res.status(200).json({ isTouristSaved });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Lỗi server" });
  }
});

// XÓA TOURIST KHỎI DANH SÁCH YÊU THÍCH
app.delete("/removeTourist/:idCus/:idTourist", async (req, res) => {
  try {
    const { idCus, idTourist } = req.params;
    const customer = await Customer.findOne({ idCus });
    if (!customer) {
      return res.json({ success: false, message: "Customer not found" });
    }
    const touristIndex = customer.listSaveTourist.findIndex(
      (tourist) => tourist.idTourist === idTourist
    );

    if (touristIndex === -1) {
      return res.json({
        success: false,
        message: "Không tìm thấy địa điểm du lịch yêu thích",
      });
    }
    customer.listSaveTourist.splice(touristIndex, 1);

    await customer.save();

    return res.status(200).json({ success: true, data: customer });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Lỗi kết nối server" });
  }
});

// THÊM TOURIST VÀO DANH SÁCH YÊU THÍCH
app.post("/addTourist/:idCus/:idTourist", async (req, res) => {
  try {
    const { idCus, idTourist } = req.params;

    const customer = await Customer.findOne({ idCus });

    if (!customer) {
      return res.json({ success: false, message: "Customer not found" });
    }

    const touristIndex = customer.listSaveTourist.findIndex(
      (tourist) => tourist.idTourist === idTourist
    );

    if (touristIndex !== -1) {
      return res.status(400).json({
        success: false,
        message: "Địa điểm du lịch đã tồn tại trong danh sách",
      });
    }

    customer.listSaveTourist.push({ idTourist });
    await customer.save();
    return res.status(200).json({ success: true, data: customer });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "lỗi kết nối server" });
  }
});

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

// CẬP NHẬT IMAGE DỰA TRÊN IDCUS
app.put("/updateImage/:idCus", async (req, res) => {
  const idCus = req.params.idCus;
  const newImage = req.body.imgCus;

  try {
    const updatedCustomer = await Customer.findOneAndUpdate(
      { idCus },
      { imgCus: newImage },
      { new: true }
    );

    if (!updatedCustomer) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy khách hàng" });
    }

    console.log("cập nhật hình ảnh thành công: " + updatedCustomer);
    return res.status(200).json({ success: true, data: updatedCustomer });
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
    const region = await Region.find({});

    if (idRegion && !idProvines) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (region.idRegion === idRegion) {
              touristAttractions.push(touristAttraction);
            }
          });
        });
      });
    }
    if (idProvines && idRegion) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (
              region.idRegion === idRegion &&
              province.idProvines === idProvines
            ) {
              touristAttractions.push(touristAttraction);
            }
          });
        });
      });
    }
    res.status(200).json({ success: true, data: touristAttractions });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// lọc địa điểm văn hóa theo idRegion và idProvines
app.get("/filter-culture", async (req, res) => {
  try {
    const idRegion = req.query.idRegion;
    const idProvines = req.query.idProvines;
    let cultures = [];
    const region = await Region.find({});

    if (idRegion && !idProvines) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (region.idRegion === idRegion) {
              cultures.push(...touristAttraction.culture);
            }
          });
        });
      });
    }
    if (idProvines && idRegion) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (
              region.idRegion === idRegion &&
              province.idProvines === idProvines
            ) {
              cultures.push(...touristAttraction.culture);
            }
          });
        });
      });
    }
    res.status(200).json({ success: true, data: cultures });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// lọc món ăn theo idRegion và idProvines
app.get("/filter-specialDish", async (req, res) => {
  try {
    const idRegion = req.query.idRegion;
    const idProvines = req.query.idProvines;
    let specialDish = [];
    const region = await Region.find({});

    if (idRegion && !idProvines) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (region.idRegion === idRegion) {
              specialDish.push(...touristAttraction.specialtyDish);
            }
          });
        });
      });
    }
    if (idProvines && idRegion) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (
              region.idRegion === idRegion &&
              province.idProvines === idProvines
            ) {
              specialDish.push(...touristAttraction.specialtyDish);
            }
          });
        });
      });
    }
    res.status(200).json({ success: true, data: specialDish });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// lọc lịch sử theo idRegion và idProvines
app.get("/filter-history", async (req, res) => {
  try {
    const idRegion = req.query.idRegion;
    const idProvines = req.query.idProvines;
    let historyList = [];
    const region = await Region.find({});

    if (idRegion && !idProvines) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (region.idRegion === idRegion) {
              historyList.push(...touristAttraction.history);
            }
          });
        });
      });
    }
    if (idProvines && idRegion) {
      region.forEach((region) => {
        region.provinces.forEach((province) => {
          province.touristAttraction.forEach((touristAttraction) => {
            if (
              region.idRegion === idRegion &&
              province.idProvines === idProvines
            ) {
              historyList.push(...touristAttraction.history);
            }
          });
        });
      });
    }
    res.status(200).json({ success: true, data: historyList });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// ----------------------------------------------------------------------------

// kiểm tra bình luận có phải người đó đăng hay không
app.get("/tourist/checkCommentOwnership", async (req, res) => {
  try {
    const { idTourist, idCus, idcmt } = req.body;
    const regions = await Region.find({});
    const customer = await Customer.findOne({ idCus: idCus });
    if (!customer) {
      return res
        .status(404)
        .json({ success: false, message: "Khách hàng không tồn tại" });
    }
    let isCommentOwner = false;

    for (const region of regions) {
      for (const province of region.provinces) {
        for (const attraction of province.touristAttraction) {
          if (attraction.idTourist === idTourist) {
            const existingComment = attraction.comment.find(
              (comment) => comment.idcmt === idcmt
            );

            if (!existingComment) {
              return res
                .status(404)
                .json({ success: false, message: "Bình luận không tồn tại" });
            }

            if (existingComment.idCus !== idCus) {
              return res.status(403).json({
                success: false,
                message: "Bạn không có quyền xóa bình luận này",
              });
            } else {
              isCommentOwner = true;
            }
          }
        }
      }
    }
    console.log("la chu so huu");
    res.status(200).json({ success: true, isCommentOwner });
  } catch (error) {
    console.log("kh phai chu so huu");
    console.error(error);
    res.status(500).json({
      success: false,
      error: "Lỗi khi kiểm tra quyền sở hữu bình luận",
    });
  }
});

// hiển thị tất cả bình luận của địa điểm đó (IdTourist)
app.get("/tourist/getComments/:touristId", async (req, res) => {
  try {
    const { touristId } = req.params;

    const regions = await Region.find({});
    const comments = [];

    if (!regions) {
      return res
        .status(404)
        .json({ success: false, message: "Khu vực không tồn tại" });
    }

    regions.forEach((region) => {
      region.provinces.forEach((province) => {
        province.touristAttraction.forEach((attraction) => {
          attraction.comment.forEach((cmt) => {
            if (attraction.idTourist === touristId) {
              comments.push(cmt);
            }
          });
        });
      });
    });

    if (comments.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Không có bình luận nào cho địa điểm du lịch này",
      });
    }

    res.status(200).json({ success: true, data: comments });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Lỗi khi lấy bình luận" });
  }
});

// thêm bình luận
app.post("/tourist/addComment", async (req, res) => {
  try {
    const { idTourist, idCus, commentData } = req.body;
    const regions = await Region.find({});
    const customer = await Customer.findOne({ idCus: idCus });
    if (!customer) {
      return res
        .status(404)
        .json({ success: false, message: "Khách hàng không tồn tại" });
    }
    let found = false;
    for (const region of regions) {
      for (const province of region.provinces) {
        for (const attraction of province.touristAttraction) {
          if (attraction.idTourist === idTourist) {
            const newComment = {
              idcmt: `CMT_${uuidv4()}`,
              idCus: idCus,
              nameCus: customer.name,
              imgCus: customer.imgCus,
              content: commentData,
              atTime: moment().format("YYYY-MM-DD HH:mm:ss"),
            };

            attraction.comment.push(newComment);
            found = true;
          }
        }
      }
      await region.save();
    }
    if (!found) {
      return res
        .status(404)
        .json({ success: false, message: "Điểm du lịch không tồn tại" });
    }
    res
      .status(200)
      .json({ success: true, message: "Bình luận đã được thêm thành công" });
    console.log("Bình luận đã được thêm thành công");
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Lỗi khi thêm bình luận" });
  }
});

// sửa bình luận
app.put("/tourist/updateComment", async (req, res) => {
  try {
    const { touristId, idCus, idcmt, newCommentData } = req.body;
    const regions = await Region.find({});
    const customer = await Customer.findOne({ idCus: idCus });

    if (!customer) {
      return res
        .status(404)
        .json({ success: false, message: "Khách hàng không tồn tại" });
    }

    let found = false;

    for (const region of regions) {
      for (const province of region.provinces) {
        for (const attraction of province.touristAttraction) {
          if (attraction.idTourist === touristId) {
            const existingComment = attraction.comment.find(
              (comment) => comment.idcmt === idcmt
            );

            if (!existingComment) {
              return res
                .status(404)
                .json({ success: false, message: "Bình luận không tồn tại" });
            }

            if (existingComment.idCus !== idCus) {
              return res.status(403).json({
                success: false,
                message: "Bạn không có quyền sửa bình luận này",
              });
            }

            existingComment.content = newCommentData;
            existingComment.atTime = moment().format("YYYY-MM-DD HH:mm:ss");

            found = true;
          }
        }
      }
      await region.save();
    }

    if (!found) {
      return res
        .status(404)
        .json({ success: false, message: "Điểm du lịch không tồn tại" });
    }

    res
      .status(200)
      .json({ success: true, message: "Bình luận đã được sửa thành công" });
    console.log("Bình luận đã được sửa thành công");
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Lỗi khi sửa bình luận" });
  }
});

// xóa bình luận
app.delete("/tourist/deleteComment", async (req, res) => {
  try {
    const { touristId, idCus, idcmt } = req.body;
    const regions = await Region.find({});
    const customer = await Customer.findOne({ idCus: idCus });

    if (!customer) {
      return res
        .status(404)
        .json({ success: false, message: "Khách hàng không tồn tại" });
    }

    let found = false;

    for (const region of regions) {
      for (const province of region.provinces) {
        for (const attraction of province.touristAttraction) {
          if (attraction.idTourist === touristId) {
            const existingCommentIndex = attraction.comment.findIndex(
              (comment) => comment.idcmt === idcmt
            );

            if (existingCommentIndex === -1) {
              return res
                .status(404)
                .json({ success: false, message: "Bình luận không tồn tại" });
            }

            if (attraction.comment[existingCommentIndex].idCus !== idCus) {
              return res.status(403).json({
                success: false,
                message: "Bạn không có quyền xóa bình luận này",
              });
            }

            attraction.comment.splice(existingCommentIndex, 1);

            found = true;
          }
        }
      }
      await region.save();
    }

    if (!found) {
      return res
        .status(404)
        .json({ success: false, message: "Điểm du lịch không tồn tại" });
    }

    res
      .status(200)
      .json({ success: true, message: "Bình luận đã được xóa thành công" });
    console.log("Bình luận đã được xóa thành công");
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Lỗi khi xóa bình luận" });
  }
});

// ----------------------------------------------------------------------------

// hiển thị danh sách các khu vực
app.get("/regions", async (req, res) => {
  try {
    const regions = await Region.find({});
    res.status(200).json({ success: true, data: regions });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// tổng địa điểm du lịch
app.get("/totalTouristAttraction", async (req, res) => {
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
    const totalAttractions = parseInt(tatCaDiaDiemDuLich.length);
    console.log(typeof totalAttractions);
    res.status(200).json({ success: true, data: totalAttractions });
  } catch (error) {
    console.log(e);
    res.status(500).json({
      success: false,
      error: "Lỗi khi lấy danh sách các địa điểm du lịch",
    });
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
          tatCaMonDacSan.push(...attraction.specialtyDish);
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
          tatCaThongTinVanHoa.push(...attraction.culture);
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
          tatCaThongTinLichSu.push(...attraction.history);
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

// tạo tài khoản
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
