let gChangedParts = [];


$.get(`/department`, loadDepartmentToSelect);
$.get(`/spare-part`, loadSparePartToSelect);
$("#btn-add-part").click(addPartToTable);
$("#btn-clear-form").click(clearForm);
$("#inp-issue-date").val((new Date()).toISOString().split('T')[0]);
$("#sel-department").change(onGetDepartmentChange);

$("#inp-end,#inp-start").on("blur", function () {
  calculateDowntime();
});
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
function addPartToTable() {
  var selectedOption = $("#sel-spare-part option:selected");
  var code = selectedOption.val();

  if (code === "" || code === "0") return;

  var existingPart = gChangedParts.find((part) => part.code === code);
  if (existingPart) {
    existingPart.quantity++;
  } else {
    gChangedParts.push({
      code: code,
      name: selectedOption.text(),
      quantity: 1,
    });
  }
  updateTable();
}

function updateTable() {
  var tbody = $("#part-table tbody").empty();

  gChangedParts.forEach((part) => {
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
  var part = gChangedParts.find((part) => part.code === code);
  if (part) {
    part.quantity += increment;
    updateTable();
  }
}

function incrementQuantity(code) {
  updateQuantity(code, 1);
}

function decrementQuantity(code) {
  var part = gChangedParts.find((part) => part.code === code);
  if (part && part.quantity > 1) {
    updateQuantity(code, -1);
  } else {
    removePart(code);
  }
}

function removePart(code) {
  gChangedParts = gChangedParts.filter((part) => part.code !== code);
  updateTable();
}

// Vô hiệu hóa các trường YCSC, downtime, status và sel-part ngay khi trang được tải
const disableFields = () => {
  $("#inp-ycsc,#inp-notes,#inp-description").prop("disabled", true).val("");
};

disableFields();

// Lắng nghe sự kiện khi checkbox bigIssue thay đổi
$("#big-issue").on("change", function () {
  const isChecked = $(this).prop("checked");
  $("#inp-ycsc,#inp-notes,#inp-description").prop("disabled", !isChecked).val("");
});

//load department to select
function loadDepartmentToSelect(pDepartment) {
  console.log(pDepartment);
  pDepartment.forEach((department) => {
    $("<option>", {
      text: department.name,
      value: department.id,
      "data-code": department.code,
    }).appendTo($("#sel-department"));
  });
}
//load equipment to select
function loadEquipmentToSelect(pEquipment) {
  console.log(pEquipment);
  $("#sel-equipment")
    .empty()
    .append('<option selected="selected" value="">Choose equipment</option>');
  pEquipment.forEach((equipment) => {
    $("<option>", {
      text: equipment.name,
      value: equipment.id,
    }).appendTo($("#sel-equipment"));
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
    }).appendTo($("#sel-spare-part"));
  });
}
// on get department change
function onGetDepartmentChange(event) {
  gDepartmentId = event.target.value;
  $.get(`/department/${gDepartmentId}/equipment`, loadEquipmentToSelect);
}
let issue = {
  newIssue: {
    department: "",
    equiment: "",
    createBy: "",
    error: "",
    ycsc: "",
    issueDate: "",
    start: "",
    end: "",
    downtime: "",
    status: "",
    description: "",
    action: "",
    notes: "",
    changedParts: [],
  },

  onCreateNewIssueClick() {
    this.newIssue = {
      department : $("#sel-department").val(),
      equipment : $("#sel-equipment").val(),
      createBy: $("#inp-createBy").val().trim(),
      error : $("#inp-error").val().trim(),
      ycsc : $("#inp-ycsc").val().trim(),
      issueDate: $("#inp-issue-date").val().trim(),
      start: $("#inp-start").val().trim(),
      end: $("#inp-end").val().trim(),
      downtime: $("#inp-downtime").val().trim(),
      status : $(".status-radio:checked").filter(":checked").val() || "done",
      description : $("#inp-description").val().trim(),
      action : $("#inp-action").val().trim(),
      bigIssue : $("#big-issue").prop("checked"),
      notes : $("#inp-notes").val(),
      changedParts: gChangedParts,
    };
    console.log(this.newIssue)
    if (validateIssue(this.newIssue)) {
      $.ajax({
        url: "/issue",
        method: "POST",
        data: JSON.stringify(this.newIssue),
        contentType: "application/json",
        success: (data) => {
          alert("Issue created successfully");
          getIssueFromDb();
          // resetIssueInput();
        },
        error: (err) => alert(err.responseText),
      });
    }
  },
  onUpdateIssueClick() {
    let vSelectedRow = $(this).parents("tr");
    let vSelectedData = issueTable.row(vSelectedRow).data();
    gIssueId = vSelectedData.id;
    $.get(`/issue/${gIssueId}`, loadIssueToInput);
  },
  onSaveIssueClick() {
    this.newIssue = {
      department: $("#inp-department").val().trim(),
      equiment: $("#inp-equipment").val().trim(),
      createBy: $("#inp-createBy").val().trim(),
      error: $("#inp-error").val().trim(),
      ycsc: $("#inp-ycsc").val().trim(),
      issueDate: $("#inp-issue-date").val().trim(),
      start: $("#inp-start").val().trim(),
      end: $("#inp-end").val().trim(),
      downtime: $("#inp-downtime").val().trim(),
      status: $(".status-radio:checked").filter(":checked").val() || "done",
      description: $("#inp-description").val().trim(),
      action: $("#inp-action").val().trim(),
      notes: $("#inp-notes").val().trim(),
      changedParts: gChangedParts,
    };
    if (validateIssue(this.newIssue)) {
      $.ajax({
        url: `/issue/${gIssueId}`,
        method: "PUT",
        data: JSON.stringify(this.newIssue),
        contentType: "application/json",
        success: (data) => {
          alert("Issue updated successfully");
          getIssueFromDb();
          gIssueId = 0;
          resetIssueInput();
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
    if (gIssueId == 0) {
      $.ajax({
        url: "/issue",
        method: "DELETE",
        success: () => {
          alert("All issue were successfully deleted");
          getIssueFromDb();
          $("#modal-delete-issue").modal("hide");
        },
        error: (err) => alert(err.responseText),
      });
    } else {
      $.ajax({
        url: `/issue/${gIssueId}`,
        method: "DELETE",
        success: () => {
          alert(`Issue with id: ${gIssueId} was successfully deleted`);
          getIssueFromDb();
          $("#modal-delete-issue").modal("hide");
        },
        error: (err) => alert(err.responseText),
      });
    }
  },
};

$("#btn-add-issue").click(issue.onCreateNewIssueClick);

// // Hàm thêm một issue mới
// function addIssue() {
//   const newIssue = gatherIssueData();

//   console.log(newIssue);
//   // Gửi yêu cầu tạo issue mới
//   createNewIssue(newIssue);
// }

// // Hàm thu thập dữ liệu của issue từ các trường nhập liệu
// function gatherIssueData() {
//   let department = $("#sel-department").val();
//   let equipment = $("#sel-equipment").val();
//   let error = $("#sel-error").val();
//   let description = $("#inp-description").val();
//   let bigIssue = $("#big-issue").prop("checked");
//   let ycsc = $("#inp-ycsc").val();
//   let notes = $("#inp-notes").val();
//   let status = $(".status-radio:checked").filter(":checked").val() || "done";
//   let action = $("#inp-action").val();

//   return {
//     department,
//     equipment,
//     error,
//     description,
//     bigIssue,
//     ycsc,
//     notes,
//     // createDate: null,
//     start,
//     end,
//     downtime,
//     // updatedDate: null,
//     status,
//     // createBy: null,
//     // updateBy: null,
//     issueDate: start,
//     action,
//     gChangedParts,
//   };
// }

// // Hàm gửi yêu cầu tạo issue mới
// function createNewIssue(newIssue) {
//   console.log(newIssue);
//   $.ajax({
//     url: "/issue",
//     method: "POST",
//     data: JSON.stringify(newIssue),
//     contentType: "application/json",
//     success: handleIssueCreationSuccess,
//     error: handleIssueCreationError,
//   });
// }

// // Hàm xử lý thành công khi tạo vấn đề mới
// function handleIssueCreationSuccess(data) {
//   console.log("New issue created:", data);
//   // Thực hiện hành động sau khi tạo issue thành công
// }

// // Hàm xử lý lỗi khi tạo vấn đề mới
// function handleIssueCreationError(error) {
//   console.error("Error creating new issue:", error);
//   // Xử lý lỗi hoặc hiển thị thông báo lỗi
// }

function clearForm() {
  $(
    "#inp-ycsc, #inp-downtime, #inp-notes, #inp-description, #big-issue, .status-radio:checked,#inp-action"
  ).val("");
  gChangedParts = [];
  updateTable();
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
    if (pIssue.equiment == "") {
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
  $.get("/issue", (issue) => {
    console.log(issue)
    loadIssueOnTable(issue);
  });
}
let issueTable = $("#issue-table").DataTable({
  // responsive: true,
  lengthChange: false,
  // autoWidth: false,
  buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
  columns: [
    {data: "id" },
    {data: "department"},
    {data: "equipment"},
    {data: "error"},
    {data: "ycsc"},
    {data: "issueDate"},
    {data: "downtime"},
    {data: "status"},
    {data: "description"},
    {data: "action"},
    {data: "bigIssue"},
    {data: "notes"},
    {data: "changedParts"},
    {data: "handle" },
  ],
  columnDefs: [
    {
      targets: -1,
      defaultContent: `<i class="fas fa-edit text-primary"></i>
      | <i class="fas fa-trash text-danger"></i>`,
    },
  ],
});

function loadIssueOnTable(pIssue) {
  "use strict";
  issueTable.clear();
  issueTable.rows.add(pIssue);
  issueTable
    .draw()
    .buttons()
    .container()
    .appendTo("#issue-table_wrapper .col-md-6:eq(0)");
}