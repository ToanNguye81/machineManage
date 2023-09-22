// Lắng nghe sự kiện click vào nút "Login"
// Lấy giá trị từ các trường input
let user = {
  userInfo: {
    username: "",
    password: "",
  },

  login() {
    this.userInfo = {
      username: $("#inp-username").val(),
      password: $("#inp-password").val(),
    };

    // Kiểm tra nếu các trường input không trống
    if (
      this.userInfo.username.trim() !== "" &&
      this.userInfo.password.trim() !== ""
    ) {
      // Gửi thông tin đăng nhập đến server
      $.ajax({
        url: "/machine/login",
        type: "POST",
        data: JSON.stringify(this.userInfo),
        contentType: "application/json",
        success: (res) => {

          // Đặt thời gian hết hạn của cookie (ví dụ: 1 giờ)
          const expirationDate = new Date();
          expirationDate.setHours(expirationDate.getHours() + 1);
          // Đặt cookie với tên "token", giá trị là token, và thời gian hết hạn
          document.cookie = `token=${res.token}; expires=${expirationDate.toUTCString()}; path=/`;

          // Chuyển hướng người dùng đến trang sau khi đăng nhập thành công
          window.location.href = "index.html";
        },
        error: (e) => {
          // Xử lý lỗi nếu có
          console.log("Lỗi trong quá trình đăng nhập. Vui lòng thử lại sau.");
          console.log(e);
        },
      });
    }
  },
  register() {
    this.userInfo = {
      username: $("#inp-username").val(),
      password: $("#inp-password").val(),
    };
    // Kiểm tra nếu các trường input không trống
    if (
      this.userInfo.username.trim() !== "" &&
      this.userInfo.password.trim() !== ""
    ) {
      // Gửi thông tin đăng nhập đến server
      $.ajax({
        url: "register",
        type: "POST",
        data: JSON.stringify(this.userInfo),
        contentType: "application/json",
        success: (res) => {
          alert("Đăng kí thành công. Hãy đăng nhập lại");

        },
        error: (e) => {
          // Xử lý lỗi nếu có
          console.log("Có lỗi xảy ra trong quá trình đăng kí");
        },
      });
    }
  },
};


$("#btn-login").on("click", function (e) {
  e.preventDefault();
  user.login();
});
$("#btn-register").on("click", function (e) {
  e.preventDefault();
  user.register();
});