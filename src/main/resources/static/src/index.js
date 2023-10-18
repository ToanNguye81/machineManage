$("#btn-search").click(loadSearchIssueToTable);

// Search issue function
function loadSearchIssueToTable() {
  // Lấy giá trị của các input
  let departmentId = $("#departmentId-search").val()
  let equipmentId = $("#equipmentId-search").val();
  let error = $("#error-search").val();
  let bigIssue = $("#bigIssue-search").val();
  let ycsc = $("#ycsc-search").val();
  let issueDateStart = $("#issueDate-search").data('daterangepicker').startDate.format("YYYY-MM-DD");
  let issueDateEnd = $("#issueDate-search").data('daterangepicker').endDate.format("YYYY-MM-DD");
  let createDateStart = $("#created-issue-search").data('daterangepicker').startDate.format("YYYY-MM-DD");
  let createDateEnd = $("#created-issue-search").data('daterangepicker').endDate.format("YYYY-MM-DD");
  let status = $("#status-search").val();

  // Tạo một đối tượng chứa điều kiện tìm kiếm
  let condition = {
    departmentId: departmentId,
    equipmentId: equipmentId,
    error: error,
    bigIssue: bigIssue,
    ycsc: ycsc,
    issueDateStart: issueDateStart,
    issueDateEnd: issueDateEnd,
    createDateStart: createDateStart,
    createDateEnd: createDateEnd,
    status: status
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

//Get issue from data page
function getSearchIssueFromDb(condition) {
  console.log(condition)
  $.get("issue/search", condition, (issue) => {
    console.log(issue);
    loadIssueToTable(issue);
  });
}

changedColor();

function clearForm() {
  $(
    "#inp-ycsc, #inp-downtime, #inp-notes, #inp-description, #big-issue,#inp-action"
  ).val("");
  $("btn-update-issue").prop("disabled", true);
  gChangedParts = [];
  updatePartTable();
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
    { data: "bigIssue" },
    { data: "status" },
    {
      data: "changedParts",
      render: function (data, type, row) {
        return buildChangedPartsCell(data);
      },
    },
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
      .map((part, index) => `${part.quantity} - ${part.code} - ${part.name} `)
      .join("<br>");
  }

  return ""; // Trả về chuỗi trống nếu changedParts không phải là mảng
}

function loadIssueToTable(pIssue) {
  "use strict";
  issueTable.clear();
  issueTable.rows.add(pIssue);
  issueTable
    .draw()
    .buttons()
    .container()
    .appendTo("#issue-table_wrapper .col-md-6:eq(0)");
}

function changedColor() {
  const selectedOption = $("#sel-status option:selected");
  const backgroundColor = selectedOption.css("background-color");
  $("#sel-status").css("background-color", backgroundColor);
}
