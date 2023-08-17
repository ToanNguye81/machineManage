let sparePartSelect = $("#sel-spare-part");
let equipmentSelect = $("#sel-equipment");
let errorSelect = $("#sel-error");
let changedParts = [];
let date = $("#inp-date");
let start = $("#inp-start");
let end = $("#inp-end");
let downtime = $("#inp-downtime");

$.get(`/department`, loadDepartmentToSelect);
$.get(`/spare-part`, loadSparePartToSelect);
$("#btn-add-part").click(addPartToTable);
$("#btn-add-issue").click(addIssue);
$("#btn-clear-form").click(clearForm);
departmentSelect.change(onGetDepartmentChange);

end.on("blur", function () {
  calculateDowntime();
});
function calculateDowntime() {
  const [startHour, startMinute, startSecond] = start
    .val()
    .split(":")
    .map(Number);
  const [endHour, endMinute, endSecond] = end.val().split(":").map(Number);

  let downtimeInSeconds =
    endHour * 3600 +
    endMinute * 60 +
    endSecond -
    (startHour * 3600 + startMinute * 60 + startSecond);

  if (downtimeInSeconds < 0) {
    downtimeInSeconds += 86400; // Thêm 1 ngày (24 giờ) nếu thời gian kết thúc nhỏ hơn thời gian bắt đầu
  }

  const hours = Math.floor(downtimeInSeconds / 3600);
  const minutes = Math.floor((downtimeInSeconds % 3600) / 60);
  const seconds = Math.floor(downtimeInSeconds % 60);

  // Đặt giá trị vào input downtime
  downtime.val(`${hours}:${minutes}:${seconds}`);
}
function addPartToTable() {
  var selectedOption = $("#sel-spare-part option:selected");
  var code = selectedOption.val();

  if (code === "" || code === "0") return;

  var existingPart = changedParts.find((part) => part.code === code);
  if (existingPart) {
    existingPart.quantity++;
  } else {
    changedParts.push({
      code: code,
      name: selectedOption.text(),
      quantity: 1,
    });
  }
  updateTable();
}

function updateTable() {
  var tbody = $("#part-table tbody").empty();

  changedParts.forEach((part) => {
    if (part.quantity > 0) {
      var row = createTableRow(part.code, part.name, part.quantity);
      tbody.append(row);
    }
  });
}

function createTableRow(code, name, quantity) {
  var row = $("<tr></tr>").append(
    `<td>${code}</td><td>${name}</td><td><button class="btn btn-sm btn-success btn-increment">+</button> <span class="quantity">${quantity}</span> <button class="btn btn-sm btn-warning btn-decrement">-</button></td><td><button class="btn btn-danger btn-sm btn-remove">Remove</button></td>`
  );

  row.find(".btn-increment").click(() => incrementQuantity(code));
  row.find(".btn-decrement").click(() => decrementQuantity(code));
  row.find(".btn-remove").click(() => removePart(code));

  return row;
}

function updateQuantity(code, increment) {
  var part = changedParts.find((part) => part.code === code);
  if (part) {
    part.quantity += increment;
    updateTable();
  }
}

function incrementQuantity(code) {
  updateQuantity(code, 1);
}

function decrementQuantity(code) {
  var part = changedParts.find((part) => part.code === code);
  if (part && part.quantity > 1) {
    updateQuantity(code, -1);
  } else {
    removePart(code);
  }
}

function removePart(code) {
  changedParts = changedParts.filter((part) => part.code !== code);
  updateTable();
}

// Vô hiệu hóa các trường YCSC, downtime, status và sel-part ngay khi trang được tải
const disableFields = () => {
  $("#inp-ycsc, #inp-notes").prop("disabled", true).val("");
};

disableFields();

// Lắng nghe sự kiện khi checkbox bigIssue thay đổi
$("#big-issue").on("change", function () {
  const isChecked = $(this).prop("checked");
  $("#inp-ycsc, #inp-notes").prop("disabled", !isChecked).val("");
});

//load department to select
function loadDepartmentToSelect(pDepartment) {
  console.log(pDepartment);
  pDepartment.forEach((department) => {
    $("<option>", {
      text: department.name,
      value: department.id,
      "data-code": department.code,
    }).appendTo(departmentSelect);
  });
}
//load equipment to select
function loadEquipmentToSelect(pEquipment) {
  console.log(pEquipment);
  equipmentSelect
    .empty()
    .append('<option selected="selected" value="">Choose equipment</option>');
  pEquipment.forEach((equipment) => {
    $("<option>", {
      text: equipment.name,
      value: equipment.id,
    }).appendTo(equipmentSelect);
  });
  $.get(`/department/${gDepartmentId}/error`, loadErrorToSelect);
}
//load error to select
function loadErrorToSelect(pError) {
  console.log(pError);
  errorSelect
    .empty()
    .append('<option selected="selected" value="">Choose error</option>');
  pError.forEach((error) => {
    $("<option>", {
      text: error.name,
      value: error.id,
    }).appendTo(errorSelect);
  });
}

//load sparePart to select
function loadSparePartToSelect(pSparePart) {
  console.log(pSparePart);
  pSparePart.forEach((sparePart) => {
    $("<option>", {
      text: sparePart.code + "-" + sparePart.name,
      value: sparePart.id,
      "data-code": sparePart.code,
      "data-price": sparePart.price,
    }).appendTo(sparePartSelect);
  });
}
// on get department change
function onGetDepartmentChange(event) {
  gDepartmentId = event.target.value;
  $.get(`/department/${gDepartmentId}/equipment`, loadEquipmentToSelect);
}

// Hàm thêm một issue mới
function addIssue() {
  const newIssue = gatherIssueData();

  console.log(newIssue);
  // Gửi yêu cầu tạo issue mới
  createNewIssue(newIssue);
}

// Hàm thu thập dữ liệu của issue từ các trường nhập liệu
function gatherIssueData() {
  let department = $("#sel-department").val();
  let equipment = $("#sel-equipment").val();
  let error = $("#sel-error").val();
  let description = $("#inp-description").val();
  let bigIssue = $("#big-issue").prop("checked");
  let ycsc = $("#inp-ycsc").val();
  let notes = $("#inp-notes").val();
  let status = $(".status-radio:checked").filter(":checked").val() || "done";
  let action = $("#inp-action").val();

  return {
    department,
    equipment,
    error,
    description,
    bigIssue,
    ycsc,
    notes,
    // createDate: null,
    start,
    end,
    downtime,
    // updatedDate: null,
    status,
    // createBy: null,
    // updateBy: null,
    issueDate: start,
    action,
    changedParts,
  };
}

// Hàm gửi yêu cầu tạo issue mới
function createNewIssue(newIssue) {
  console.log(newIssue);
  $.ajax({
    url: "/issue",
    method: "POST",
    data: JSON.stringify(newIssue),
    contentType: "application/json",
    success: handleIssueCreationSuccess,
    error: handleIssueCreationError,
  });
}

// Hàm xử lý thành công khi tạo vấn đề mới
function handleIssueCreationSuccess(data) {
  console.log("New issue created:", data);
  // Thực hiện hành động sau khi tạo issue thành công
}

// Hàm xử lý lỗi khi tạo vấn đề mới
function handleIssueCreationError(error) {
  console.error("Error creating new issue:", error);
  // Xử lý lỗi hoặc hiển thị thông báo lỗi
}

function clearForm() {
  $(
    "#inp-ycsc, #inp-downtime, #inp-notes, #inp-description, #big-issue, .status-radio:checked,#inp-action"
  ).val("");
  changedParts = [];
  updateTable();
}
