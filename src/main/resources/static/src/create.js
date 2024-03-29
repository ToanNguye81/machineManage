let gChangedParts = [];
let gEquipmentId = 0;
let gDepartmentId = $("#sel-department").val();

$.get(`department/${gDepartmentId}/equipment`, function (pEquipment) {
  loadEquipmentToSelect(pEquipment);
  // After setting the equipment value,
  $("#sel-equipment").trigger("change");

  //Load sel-search
  loadEquipmentToSelectSearch(pEquipment);
  // After setting the equipment value,
  $("#search-equipment").trigger("change");
});

$("#btn-search-part").click(searchPart);
$("#btn-clear-form").click(clearForm);
$("#btn-search").click(loadSearchIssueToTable);
$("#inp-issue-date").val(new Date().toISOString().split("T")[0]);
$("#sel-department").change(onGetDepartmentChange);
$("#sel-status").change(changedColor);
$("#inp-end,#inp-start").on("blur", calculateDowntime);
changedColor();
function calculateDowntime() {
  let start = $("#inp-start");
  let end = $("#inp-end");
  let downtime = $("#inp-downtime");
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

function addPartToTable(partId,partCode,partName,partPosition) {

  if (!partId) return; // Check if partId is not empty or falsy

  var existingPart = gChangedParts.find((part) => part.id === partId);
  if (existingPart) {
    existingPart.quantity++;
  } else {
    gChangedParts.push({
      id: partId, // Store the selected part's ID
      code: partCode,
      name: partName,
      position: partPosition,
      quantity: 1,
    });
  }
  updatePartTable();
}

function searchPart() {
  var keyWord = $("#inp-search-part").val().trim();
  $.get(`spare-part/search?keyWord=${keyWord}`,loadPartResult);
}

function loadPartResult(result) {
 // Xóa dữ liệu cũ trong bảng
  $("#table-part-result tbody").empty();

  // Thêm dữ liệu mới vào bảng
  result.forEach(part => {
    var row = `<tr>
                  <td>${part.code}</td>
                  <td>${part.spc}</td>
                  <td>${part.name}</td>
                  <td>${part.position}</td>
                  <td>${part.inStock}</td>
                  <td>${part.imageUrl}</td>
                  <td><button class="btn btn-info btn-add-changed-part"
                  data-id="${part.id}"
                  data-position="${part.position}"
                  data-name="${part.name}"
                  data-code="${part.code}">
                  <i class="fas fa-plus"></i></button></td>
                </tr>`;
    $("#table-part-result tbody").append(row);
  });

  // Gán sự kiện click cho nút "Add to List"
  $(".btn-add-changed-part").click(function() {
    var partId = $(this).data("id");
    var partCode = $(this).data("code");
    var partName = $(this).data("name");
    var partPosition = $(this).data("position");
    addPartToTable(partId,partCode, partName,partPosition);
  });
}

function updatePartTable() {
  var tbody = $("#part-table tbody").empty();

  gChangedParts.forEach((part) => {
    if (part.quantity > 0) {
      var row = createTableRow(part.id, part.code, part.name, part.position, part.quantity); // Pass part's ID to createTableRow
      tbody.append(row);
    }
  });
}

function createTableRow(id, code, name,position, quantity) {
  var row = $("<tr></tr>").append(
    `<td>${code}</td>
     <td>${name}</td>
     <td>${position}</td>
     <td><button class="btn btn-sm btn-success btn-increment">+</button> 
     <span class="quantity">${quantity}</span> 
     <button class="btn btn-sm btn-warning btn-decrement">-</button></td>
     <td><button class="btn btn-danger btn-sm btn-remove">Remove</button></td>`
  );

  row.find(".btn-increment").click(() => incrementQuantity(id));
  row.find(".btn-decrement").click(() => decrementQuantity(id));
  row.find(".btn-remove").click(() => removePart(id));

  return row;
}

function updateQuantity(id, increment) {
  var part = gChangedParts.find((part) => part.id === id); // Find the part by ID
  if (part) {
    part.quantity += increment;
    updatePartTable();
  }
}

function incrementQuantity(id) {
  updateQuantity(id, 1);
}

function decrementQuantity(id) {
  var part = gChangedParts.find((part) => part.id === id); // Find the part by ID
  if (part && part.quantity > 1) {
    updateQuantity(id, -1);
  } else {
    removePart(id);
  }
}

function removePart(id) {
  gChangedParts = gChangedParts.filter((part) => part.id !== id); // Filter by ID
  updatePartTable();
}

// Vô hiệu hóa các trường YCSC, downtime, status và sel-part ngay khi trang được tải
const disableFields = () => {
  // $("#inp-notes, #btn-update-issue")
  $("#btn-update-issue")
    .prop("disabled", true)
    .val("");
};

disableFields();

// // Lắng nghe sự kiện khi checkbox bigIssue thay đổi
// $("#big-issue").on("change", function () {
//   const isChecked = $(this).prop("checked");
//   // $("#inp-notes").prop("disabled", !isChecked);
// });

//load department to select
function loadDepartmentToSelect(pDepartment) {
  console.log(pDepartment);
  pDepartment.forEach((department) => {
    $("<option>", {
      text: department.name,
      value: department.id,
    }).appendTo($("#sel-department"));
  });
}

// Function to load equipment options into the select input
function loadEquipmentToSelect(pEquipment) {
  $("#sel-equipment")
    .empty()
    .append('<option value="">Choose equipment</option>');
  pEquipment.forEach((equipment) => {
    $("<option>", {
      text: equipment.name,
      value: equipment.id,
    }).appendTo($("#sel-equipment"));
  });

  if (gEquipmentId !== 0) {
    $("#sel-equipment").val(gEquipmentId);
  }
}

// Function to load equipment options into the select input
function loadEquipmentToSelectSearch(pEquipment) {
  $("#equipment-search")
    .empty()
    .append('<option value="">Choose equipment</option>');
  pEquipment.forEach((equipment) => {
    $("<option>", {
      text: equipment.name,
      value: equipment.id,
    }).appendTo($("#equipment-search"));
  });

  if (gEquipmentId !== 0) {
    $("#equipment-search").val(gEquipmentId);
  }
}
// on get department change
function onGetDepartmentChange(event) {
  gDepartmentId = event.target.value;
  if (gDepartmentId == 0) {
    // Handle the case when "Choose department" is selected
    $("#sel-equipment")
      .empty()
      .append('<option value="">Choose equipment</option>');
  } else {
    // Load equipment based on the selected department
    $.get(`department/${gDepartmentId}/equipment`, function (pEquipment) {
      loadEquipmentToSelect(pEquipment);
      // After setting the equipment value,
      $("#sel-equipment").trigger("change");
      loadEquipmentToSelectSearch(pEquipment);
      // After setting the equipment value,
      $("#equipment-search").trigger("change");
    });
  }
}

let issue = {
  newIssue: {
    departmentId: "",
    equipmentId: "",
    createdBy: "",
    error: "",
    ycsc: "",
    issueDate: "",
    start: "",
    end: "",
    downtime: "",
    status: "",
    description: "",
    action: "",
    // notes: "",
    workOrder:"",
    changedParts: [],
  },

  onCreateNewIssueClick() {
    this.newIssue = {
      departmentId: $("#sel-department").val().trim(),
      equipmentId: $("#sel-equipment").val().trim(),
      createdBy: $("#inp-createdBy").val().trim(),
      error: $("#inp-error").val().trim(),
      ycsc: $("#inp-ycsc").val().trim(),
      workOrder: $("#inp-workOrder").val().trim(),
      issueDate: $("#inp-issue-date").val().trim(),
      start: $("#inp-start").val().trim(),
      end: $("#inp-end").val().trim(),
      downtime: $("#inp-downtime").val().trim(),
      status: $("#sel-status").val() || "done",
      description: $("#inp-description").val().trim(),
      action: $("#inp-action").val().trim(),
      // bigIssue: $("#big-issue").prop("checked"),
      // notes: $("#inp-notes").val(),
      changedParts: gChangedParts,
    };
    console.log(this.newIssue);
    if (validateIssue(this.newIssue)) {
      $.ajax({
        url: `issue`,
        method: "POST",
        data: JSON.stringify(this.newIssue),
        contentType: "application/json",
        success: handleIssueCreationSuccess,
        error: handleIssueCreationError,
      });
    }
  },
  onUpdateIssueClick() {
    let vSelectedData = $(this).attr("id"); // Use closest() instead of parents() for better accuracy
    gIssueId = vSelectedData;
    console.log(gIssueId);
    $.get(`issue/${gIssueId}`, loadIssueToInput);
  },
  onSaveIssueClick() {
    this.newIssue = {
      departmentId: $("#sel-department").val().trim(),
      equipmentId: $("#sel-equipment").val().trim(),
      createdBy: $("#inp-createdBy").val().trim(),
      error: $("#inp-error").val().trim(),
      ycsc: $("#inp-ycsc").val().trim(),
      workOrder: $("#inp-workOrder").val().trim(),
      issueDate: $("#inp-issue-date").val().trim(),
      start: $("#inp-start").val().trim(),
      end: $("#inp-end").val().trim(),
      downtime: $("#inp-downtime").val().trim(),
      status: $("#sel-status").val() || "done",
      description: $("#inp-description").val().trim(),
      action: $("#inp-action").val().trim(),
      // bigIssue: $("#big-issue").prop("checked"),
      
      // notes: $("#inp-notes").val(),
      changedParts: gChangedParts,
    };
    if (validateIssue(this.newIssue)) {
      console.log(this.newIssue);
      $.ajax({
        url: `issue/${gIssueId}`,
        method: "PUT",
        data: JSON.stringify(this.newIssue),
        contentType: "application/json",
        success: (data) => {
          alert("Issue updated successfully");
          clearForm();
          getIssueFromDb();
          gIssueId = 0;
        },
        error: (err) => alert(err.responseText),
      });
    }
  },
  onDeleteIssueByIdClick() {
    $("#modal-delete-issue").modal("show");
    let vSelectedRow = $(this).parents("tr");
    let vSelectedData = issueTable.row(vSelectedRow).data();
    gIssueId = vSelectedData.id;
  },
  onDeleteConfirmClick() {
    $.ajax({
      url: `issue/${gIssueId}`,
      method: "DELETE",
      success: () => {
        alert(`Issue with id: ${gIssueId} was successfully deleted`);
        $("#modal-delete-issue").modal("hide");
        getIssueFromDb();
      },
      error: (err) => alert(err.responseText),
    });
  },
};

let sparePart = {
  newSparePart: {
    code: "",
    name: "",
    price: 0,
    inStock: 0,
    imageUrl: "",
  },
  onCreateNewSparePartClick() {
    $("#modal-create-part").modal("show");
  },

  onSaveNewSparePartClick() {
    // Khởi tạo newSparePart với các trường thông tin khác
    this.newSparePart = {
      code: $("#inp-part-code").val().trim(),
      name: $("#inp-part-name").val().trim(),
      price: $("#inp-part-price").val().trim(),
      imageUrl:""
      //   ? URL.createObjectURL($("#imageInput")[0].files[0])
      //   : "", // Ternary operator to set imageUrl
    };

    console.log(this.newSparePart)

    // Gửi AJAX request (with imageUrl set to the URL of the selected image or an empty string)
    $.ajax({
      url: `spare-part`,
      method: "POST",
      data: JSON.stringify(this.newSparePart),
      contentType: "application/json",
      success: handlePartCreationSuccess,
      error: handleIssueCreationError,
    });
  },
};

// Hàm xử lý thành công khi tạo vấn đề mới
function handlePartCreationSuccess(data) {
  console.log("New data created:", data);
  // Thực hiện hành động sau khi tạo issue thành công
  alert("Data created successfully");
  // getPartFromDb();
  $("#modal-create-part").modal("hide");
}

// Hàm xử lý thành công khi tạo vấn đề mới
function handleIssueCreationSuccess(data) {
  console.log("New data created:", data);
  // Thực hiện hành động sau khi tạo issue thành công
  alert("Data created successfully");
  getIssueFromDb();
}

// Hàm xử lý lỗi khi tạo vấn đề mới
function handleIssueCreationError(error) {
  console.error("Error creating new data:", error);
  // Xử lý lỗi hoặc hiển thị thông báo lỗi
  (error) => alert(error.responseText);
}

function clearForm() {
  //ver 1: $("#inp-ycsc, #inp-downtime, #inp-description, #big-issue,#inp-action","inp-workOrder").val("");
  $("#inp-ycsc, #inp-downtime, #inp-description,#inp-action","inp-workOrder").val("");
  $("btn-update-issue").prop("disabled", true);
  gChangedParts = [];
  updatePartTable();
}
//Valid issue
function validateIssue(pIssue) {
  "use strict";
  let vResult = true;
  try {
    if (pIssue.department == "") {
      vResult = false;
      throw "100.inp department";
    }
    if (pIssue.equipment == "") {
      vResult = false;
      throw "200.inp equipment";
    }
    if (pIssue.error == "") {
      vResult = false;
      throw "300.inp error";
    }
    if (pIssue.issueDate == "") {
      vResult = false;
      throw "500.inp issueDate";
    }
    if (pIssue.start == "") {
      vResult = false;
      throw "600.inp start";
    }
    if (pIssue.end == "") {
      vResult = false;
      throw "700.inp end";
    }
    if (pIssue.downtime == "") {
      vResult = false;
      throw "800.inp downtime";
    }
    if (pIssue.action == "") {
      vResult = false;
      throw "900.inp action";
    }
  } catch (e) {
    alert(e);
  }
  return vResult;
}
getIssueFromDb();
function getIssueFromDb() {
  "use strict";
  $.get("issue", (issue) => {
    console.log(issue);
    loadIssueToTable(issue);
  });
}
let issueTable = $("#issue-table").DataTable({
  responsive: true,
  lengthChange: false,
  autoWidth: false,
  buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
  columns: [
    { data: "id" },
    { data: "issueDate" },
    { data: "department.name" },
    { data: "equipment.name" },
    { data: "error" },
    { data: "downtime" },
    { data: "description" },
    { data: "action" },
    // { data: "bigIssue" },
    { data: "status" },
    {
      data: "changedParts",
      render: function (data, type, row) {
        return buildChangedPartsCell(data);
      },
    },
    { data: "workOrder" },
    { data: "ycsc" },
    {
      data: "id",
      render: (data) =>
        `<div>
        <i class="fas fa-edit text-primary" id="${data}"></i>
        <i class="fas fa-trash text-danger" id="${data}"></i>
      </div>`,
    },
  ],
});

function buildChangedPartsCell(changedParts) {
  // Đảm bảo rằng changedParts thực sự là một mảng
  if (Array.isArray(changedParts)) {
    return changedParts
      .map((part, index) => ` qty: ${part.quantity} |code: ${part.code} |name: ${part.name} | pos: ${part.position} `)
      .join("<br>");
  }

  return ""; // Trả về chuỗi trống nếu changedParts không phải là mảng
}

function loadIssueToTable(pIssue) {
  "use strict";
  console.log("use strict");
  // console.log(pIssue);
  issueTable.clear();
  issueTable.rows.add(pIssue);
  issueTable
    .draw()
    .buttons()
    .container()
    .appendTo("#issue-table_wrapper .col-md-6:eq(0)");
}

function loadIssueToInput(pIssues) {
  gDepartmentId = pIssues.department.id;
  gEquipmentId = pIssues.equipment.id;
  $("#sel-department").val(gDepartmentId);
  $("#sel-equipment").val(gEquipmentId);
  $("#inp-createdBy").val(pIssues.createdBy);
  $("#inp-error").val(pIssues.error);
  $("#inp-ycsc").val(pIssues.ycsc);
  $("#inp-workOrder").val(pIssues.workOrder);
  $("#inp-issue-date").val(pIssues.issueDate);
  $("#inp-start").val(pIssues.start);
  $("#inp-end").val(pIssues.end);
  $("#inp-downtime").val(pIssues.downtime);
  // Set the value of the status radio input
  $("#sel-status").val(pIssues.status);
  $("#inp-description").val(pIssues.description);
  $("#inp-action").val(pIssues.action);
  // $("#big-issue").prop("checked", pIssues.bigIssue);
  gChangedParts = pIssues.changedParts;
  // After setting the department value, trigger a change event to load equipment
  $("select").trigger("change");
  // $("#big-issue").trigger("change");
  $("#btn-update-issue").prop("disabled", false);
  updatePartTable();
}

function changedColor() {
  const selectedOption = $("#sel-status option:selected");
  const backgroundColor = selectedOption.css("background-color");
  $("#sel-status").css("background-color", backgroundColor);
}

$("#btn-add-issue").click(issue.onCreateNewIssueClick);
$("#issue-table").on("click", ".fa-edit", issue.onUpdateIssueClick);
$("#issue-table").on("click", ".fa-trash", issue.onDeleteIssueByIdClick);
$("#btn-update-issue").click(issue.onSaveIssueClick);
$("#btn-confirm-delete-issue").click(issue.onDeleteConfirmClick);
$("#btn-create-new-part").click(sparePart.onCreateNewSparePartClick);
$("#btn-save-new-part").click(sparePart.onSaveNewSparePartClick);
// Lắng nghe sự kiện khi người dùng chọn hình ảnh
$("#imageInput").change(handleImageSelection);


// Xử lý sự kiện khi người dùng chọn hình ảnh và hiển thị nó
function handleImageSelection() {
  const imageInput = $("#imageInput")[0];
  const imagePreview = $("#imagePreview")[0];

  // Kiểm tra xem đã chọn hình ảnh hay chưa
  if (imageInput.files && imageInput.files[0]) {
    const reader = new FileReader();

    reader.onload = function (e) {
      // Hiển thị hình ảnh trên trình duyệt
      imagePreview.src = e.target.result;
    };

    // Đọc và hiển thị hình ảnh
    reader.readAsDataURL(imageInput.files[0]);
  }
}

function loadSearchIssueToTable() {
  // Lấy giá trị của các input
  let departmentId = $("#sel-department").val()
  let equipmentId = $("#sel-equipment").val();
  let error = $("#error-search").val();
  // let bigIssue = $("#bigIssue-search").val();
  let ycsc = $("#ycsc-search").val();
  let issueDateStart = $("#issueDate-search").data('daterangepicker').startDate.format("YYYY-MM-DD");
  let issueDateEnd = $("#issueDate-search").data('daterangepicker').endDate.format("YYYY-MM-DD");
  let createDateStart = $("#created-issue-search").data('daterangepicker').startDate.format("YYYY-MM-DD");
  let createDateEnd = $("#created-issue-search").data('daterangepicker').endDate.format("YYYY-MM-DD");
  let status = $("#status-search").val();
  let workOrder = $("#inp-workOrder").val();

  // Tạo một đối tượng chứa điều kiện tìm kiếm
  let condition = {
    departmentId,
    equipmentId,
    error,
    workOrder,
    // bigIssue,
    ycsc,
    issueDateStart,
    issueDateEnd,
    createDateStart,
    createDateEnd,
    status
  };

  // Gọi hàm để lấy dữ liệu từ backend
  getSearchIssueFromDb(condition);
}
//Date range picker with time picker
$("#issueDate-search").daterangepicker({
  timePicker: true,
  timePickerIncrement: 30,
  locale: {
    format: "MM/DD/YYYY",
  },
});
//Date range picker with time picker
$("#created-issue-search").daterangepicker({
  timePicker: true,
  timePickerIncrement: 30,
  locale: {
    format: "MM/DD/YYYY",
  },
});

function getSearchIssueFromDb(condition) {
  console.log(condition)
  $.get("issue/search", condition, (issue) => {
    console.log(issue);
    loadIssueToTable(issue);
  });
}