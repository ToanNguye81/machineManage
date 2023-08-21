"use strict";
let gIssueId = "";
let gDepartmentId  = "";
let gEquipementId  = "";
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
      changedParts: gChangedPart,
    };
    console.log(newIssue)
    if (!validateIssue(this.newIssue)) {
      $.ajax({
        url: "/issue",
        method: "POST",
        data: JSON.stringify(this.newIssue),
        contentType: "application/json",
        success: (data) => {
          alert("Issue created successfully");
          getIssueFromDb();
          resetIssueInput();
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
      changedParts: gChangedPart,
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


$.get(`/department`, loadDepartmentToSelect);
$.get(`/spare-part`, loadSparePartToSelect);
$("#inp-issue-date").val((new Date()).toISOString().split('T')[0]);
$("#inp-start").on("blur", function() {calculateDowntime()});
$("#sel-department").change(onGetDepartmentChange);
// Vô hiệu hóa các trường YCSC, downtime, status và sel-part ngay khi trang được tải
const disableFields = () => {$("#inp-ycsc,#inp-notes,#inp-description").prop("disabled", true).val("");};

disableFields();

// Lắng nghe sự kiện khi checkbox bigIssue thay đổi
$("#big-issue").on("change", function () {
  const isChecked = $(this).prop("checked");
  $("#inp-ycsc,#inp-notes,#inp-description").prop("disabled", !isChecked).val("");
});
//Tính downtime
function calculateDowntime() {
  let start=("#inp-start");
  let end=("#inp-end");
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
  $("#inp-dowtime").val(`${hours}:${minutes}:${seconds}`);
}
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
// on get department change
function onGetDepartmentChange(event) {
  gDepartmentId = event.target.value;
  $.get(`/department/${gDepartmentId}/equipment`, loadEquipmentToSelect);
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
  })}
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

let issueTable = $("#issue-table").DataTable({
  responsive: true,
  lengthChange: false,
  autoWidth: false,
  buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
  columns: [
    { data: "id" },
    { data: "department" },
    { data: "equiment" },
    { data: "createBy" },
    { data: "error" },
    { data: "ycsc" },
    { data: "downtime" },
    { data: "status" },
    { data: "description" },
    { data: "action" },
    { data: "notes" },
    { data: "changedParts" },
  ],
  columnDefs: [
    {
      targets: -1,
      defaultContent: `<i class="fas fa-edit text-primary"></i>
      | <i class="fas fa-trash text-danger"></i>`,
    },
  ],
});
function loadIssueOnTable(pIssues) {
  "use strict";
  issueTable.clear();
  issueTable.rows.add(pIssues);
  issueTable
    .draw()
    .buttons()
    .container()
    .appendTo("#issue-table_wrapper .col-md-6:eq(0)");
}

function getIssueFromDb() {
  "use strict";
  $.get("/issue?size=20", (issue) => {
    loadIssueOnTable(issue);
  });
}
getIssueFromDb();

$("#btn-add-issue").click(issue.onCreateNewIssueClick);
$("#issue-table").on("click", ".fa-edit", issue.onUpdateIssueClick);
$("#issue-table").on(
  "click",
  ".fa-trash",
  issue.onDeleteIssueByIdClick
);
$("#update-issue").click(issue.onSaveIssueClick);
$("#delete-issue").click(issue.onDeleteConfirmClick);

function loadIssueToInput(pIssues) {
  $("#inp-department").val(pIssues.department);
  $("#inp-equipment").val(pIssues.equiment);
  $("#inp-createBy").val(pIssues.createBy);
  $("#inp-error").val(pIssues.error);
  $("#inp-ycsc").val(pIssues.ycsc);
  $("#inp-issue-date").val(pIssues.issueDate);
  $("#inp-start").val(pIssues.start);
  $("#inp-end").val(pIssues.end);
  $("#inp-downtime").val(pIssues.downtime);
  $("#inp-status").val(pIssues.status);
  $("#inp-description").val(pIssues.description);
  $("#inp-action").val(pIssues.action);
  $("#inp-notes").val(pIssues.notes);
  $("#inp-changedParts").val(pIssues.changedParts);
}

function resetIssueInput() {
  $("#inp-department").val("");
  $("#inp-equipment").val("");
  $("#inp-error").val("");
  $("#inp-ycsc").val("");
  $("#inp-issue-date").val("");
  $("#inp-start").val("");
  $("#inp-end").val("");
  $("#inp-downtime").val("");
  $("#inp-status").val("");
  $("#inp-description").val("");
  $("#inp-action").val("");
  $("#inp-notes").val("");
  $("#inp-changedParts").val([]);
}

function validateIssue(pIssues) {
  "use strict";
  let vResult = true;
  try {
    if (pIssues.department == "") {
      vResult = false;
      throw "100.inp department";
    }
    if (pIssues.equiment == "") {
      vResult = false;
      throw "200.inp equipment";
    }
    if (pIssues.createBy == "") {
      vResult = false;
      throw "300.inp createBy";
    }
    if (pIssues.error == "") {
      vResult = false;
      throw "400.error not valid";
    }
    if (pIssues.issueDate == "") {
      vResult = false;
      throw "600.inp issueDate";
    }
    if (pIssues.start == "") {
      vResult = false;
      throw "600.inp start";
    }
    if (pIssues.end == "") {
      vResult = false;
      throw "700.inp end";
    }
    if (pIssues.downtime == "") {
      vResult = false;
      throw "800.inp downtime";
    }
  } catch (e) {
    alert(e);
  }
  return vResult;
}