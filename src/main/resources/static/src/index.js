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

//load sparePart to select
function loadSparePartToSelect(pSparePart) {
  console.log(pSparePart);
  pSparePart.forEach((sparePart) => {
    $("<option>", {
      text: sparePart.code + "-" + sparePart.name,
      value: sparePart.id, // Set the value to spare part's ID
      "data-code": sparePart.code,
      "data-name": sparePart.name,
      "data-price": sparePart.price,
    }).appendTo($("#sel-spare-part"));
  });
}

function addPartToTable() {
  var selectedOption = $("#sel-spare-part option:selected");
  var partId = selectedOption.val(); // Get the selected part's ID
  var partCode = selectedOption.data("code");
  var partName = selectedOption.data("name");

  if (!partId) return; // Check if partId is not empty or falsy

  var existingPart = gChangedParts.find((part) => part.id === partId);
  if (existingPart) {
    existingPart.quantity++;
  } else {
    gChangedParts.push({
      id: partId, // Store the selected part's ID
      code: partCode,
      name: partName,
      quantity: 1,
    });
  }
  updateTable();
}

function updateTable() {
  var tbody = $("#part-table tbody").empty();

  gChangedParts.forEach((part) => {
    if (part.quantity > 0) {
      var row = createTableRow(part.id, part.code, part.name, part.quantity); // Pass part's ID to createTableRow
      tbody.append(row);
    }
  });
}

function createTableRow(id, code, name, quantity) {
  var row = $("<tr></tr>").append(
    `<td>${code}</td><td>${name}</td><td><button class="btn btn-sm btn-success btn-increment">+</button> <span class="quantity">${quantity}</span> <button class="btn btn-sm btn-warning btn-decrement">-</button></td><td><button class="btn btn-danger btn-sm btn-remove">Remove</button></td>`
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
    updateTable();
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
    }).appendTo($("#sel-department"));
  });
}
//load equipment to select
function loadEquipmentToSelect(pEquipment) {
  console.log(pEquipment);
  $("#sel-equipment")
    .empty()
    .append('<option selected="selected" value="0">Choose equipment</option>');
  pEquipment.forEach((equipment) => {
    $("<option>", {
      text: equipment.name,
      value: equipment.id,
    }).appendTo($("#sel-equipment"));
  });
}


// on get department change
function onGetDepartmentChange(event) {
  gDepartmentId = $(event.target).find(':selected').data('id');
  if (event.target.value == 0) {
    $("#sel-equipment").empty().append('<option selected="selected" value="0">Choose equipment</option>');
  }
  else {
    $.get(`/department/${gDepartmentId}/equipment`, loadEquipmentToSelect);
  }
}
let issue = {
  newIssue: {
    departmentId: "",
    equipmentId: "",
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
      departmentId: $("#sel-department").val().trim(),
      equipmentId: $("#sel-equipment").val().trim(),
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
      bigIssue: $("#big-issue").prop("checked"),
      notes: $("#inp-notes").val(),
      changedParts: gChangedParts,
    };
    console.log(this.newIssue)
    if (validateIssue(this.newIssue)) {
      $.ajax({
        url: `/issue`,
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
    let vSelectedData = $(this).attr("id"); // Use closest() instead of parents() for better accuracy
    gIssueId = vSelectedData;
    console.log(gIssueId)
    $.get(`/issue/${gIssueId}`, loadIssueToInput);
  },
  onSaveIssueClick() {
    this.newIssue = {
      department: $("#inp-department").val().trim(),
      equipment: $("#inp-equipment").val().trim(),
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
  $.get("/issue", (issue) => {
    console.log(issue)
    loadIssueOnTable(issue);
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
    { data: "department" },
    { data: "equipment" },
    { data: "error" },
    { data: "downtime" },
    { data: "description" },
    { data: "action" },
    { data: "bigIssue" },
    { data: "status" },
    {
      data: "changedParts",
      render: function (data, type, row) {
        return buildChangedPartsCell(data);
      }
    },
    {data: "id",
    render: (data) =>
      `<div>
        <i class="fas fa-edit text-primary" id="${data}"></i>
        <i class="fas fa-trash text-danger" id="${data}"></i>
      </div>` },

  ],
});

function buildChangedPartsCell(changedParts) {
  // Đảm bảo rằng changedParts thực sự là một mảng
  if (Array.isArray(changedParts)) {
    return changedParts.map((part, index) => `${part.quantity} - ${part.code} - ${part.name} `).join("<br>");
  }

  return ""; // Trả về chuỗi trống nếu changedParts không phải là mảng
}

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


$("#issue-table").on("click", ".fa-edit", issue.onUpdateIssueClick);
$("#issue-table").on(
  "click",
  ".fa-trash",
  issue.onDeleteIssueByIdClick
);
$("#update-issue").click(issue.onSaveIssueClick);
$("#delete-issue").click(issue.onDeleteConfirmClick);

function loadIssueToInput(pIssues) {
  console.log(pIssues)

  $("#sel-department").val(pIssues.department);
  $("#sel-equipment").val(pIssues.equipment);
  $("#inp-createBy").val(pIssues.createBy);
  $("#inp-error").val(pIssues.error);
  $("#inp-ycsc").val(pIssues.ycsc);
  $("#inp-issue-date").val(pIssues.issueDate);
  $("#inp-start").val(pIssues.start);
  $("#inp-end").val(pIssues.end);
  $("#inp-downtime").val(pIssues.downtime);
  $(".status-radio").val(pIssues.status);
  $("#inp-description").val(pIssues.description);
  $("#inp-action").val(pIssues.action);
  $("#big-issue").val(pIssues.bigIssue);
  $("#inp-notes").val(pIssues.notes);
  $("#inp-notes").val(pIssues.notes);
  gChangedParts=pIssues.changedParts;
}
