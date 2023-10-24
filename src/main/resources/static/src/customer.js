"use strict";
var selectedEquipmentIds = [
  "1",
  "2",
  "3",
  "4",
];
$.get(
  "/issue/count?equipmentIds=" + selectedEquipmentIds.join(","),
  loadIssueOnChart
);
let gIssueId = 0;
let issue = {
  newIssue: {
    firstName: "",
    lastName: "",
    phoneNumber: "",
    email: "",
    address: "",
    city: "",
    state: "",
    country: "",
    postalCode: "",
    salesRepEmployeeNumber: "",
    creditLimit: "",
  },

  onCreateNewIssueClick() {
    this.newIssue = {
      firstName: $("#input-first-name").val().trim(),
      lastName: $("#input-last-name").val().trim(),
      phoneNumber: $("#input-phone-number").val().trim(),
      email: $("#input-email").val().trim(),
      address: $("#input-address").val().trim(),
      city: $("#input-city").val().trim(),
      state: $("#input-state").val().trim(),
      country: $("#input-country").val().trim(),
      postalCode: $("#input-postal-code").val().trim(),
      salesRepEmployeeNumber: $("#input-credit-limit").val().trim(),
      creditLimit: $("#input-employee-number").val().trim(),
    };
    if (validateIssue(this.newIssue)) {
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
      firstName: $("#input-first-name").val().trim(),
      lastName: $("#input-last-name").val().trim(),
      phoneNumber: $("#input-phone-number").val().trim(),
      email: $("#input-email").val().trim(),
      address: $("#input-address").val().trim(),
      city: $("#input-city").val().trim(),
      state: $("#input-state").val().trim(),
      country: $("#input-country").val().trim(),
      postalCode: $("#input-postal-code").val().trim(),
      creditLimit: $("#input-credit-limit").val(),
      salesRepEmployeeNumber: $("#input-employee-number").val(),
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
  onDeleteAllIssueClick() {
    $("#modal-delete-issue").modal("show");
    gIssueId = 0;
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

let issueTable = $("#issue-table").DataTable({
  responsive: true,
  lengthChange: false,
  autoWidth: false,
  buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
  columns: [
    { data: "id" },
    { data: "firstName" },
    { data: "lastName" },
    { data: "phoneNumber" },
    { data: "email" },
    { data: "address" },
    { data: "postalCode" },
    { data: "salesRepEmployeeNumber" },
    { data: "creditLimit" },
    { data: "action" },
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

$("#create-issue").click(issue.onCreateNewIssueClick);
$("#issue-table").on("click", ".fa-edit", issue.onUpdateIssueClick);
$("#issue-table").on(
  "click",
  ".fa-trash",
  issue.onDeleteIssueByIdClick
);
$("#update-issue").click(issue.onSaveIssueClick);
$("#delete-all-issue").click(issue.onDeleteAllIssueClick);
$("#delete-issue").click(issue.onDeleteConfirmClick);

function loadIssueToInput(pIssues) {
  $("#input-first-name").val(pIssues.firstName);
  $("#input-last-name").val(pIssues.lastName);
  $("#input-phone-number").val(pIssues.phoneNumber);
  $("#input-email").val(pIssues.email);
  $("#input-address").val(pIssues.address);
  $("#input-city").val(pIssues.city);
  $("#input-state").val(pIssues.state);
  $("#input-country").val(pIssues.country);
  $("#input-postal-code").val(pIssues.postalCode);
  $("#input-employee-number").val(pIssues.creditLimit);
  $("#input-credit-limit").val(pIssues.salesRepEmployeeNumber);
}

function resetIssueInput() {
  $("#input-first-name").val("");
  $("#input-last-name").val("");
  $("#input-phone-number").val("");
  $("#input-email").val("");
  $("#input-address").val("");
  $("#input-city").val("");
  $("#input-state").val("");
  $("#input-country").val("");
  $("#input-postal-code").val("");
  $("#input-employee-number").val("");
  $("#input-credit-limit").val("");
}

function validateIssue(pIssues) {
  "use strict";
  let vResult = true;
  try {
    if (pIssues.firstName == "") {
      vResult = false;
      throw "100.input first name";
    }
    if (pIssues.lastName == "") {
      vResult = false;
      throw "200.input last name";
    }
    if (!/^\d{10}$/.test(pIssues.phoneNumber)) {
      vResult = false;
      throw "300.input phone number is 10 digitals";
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(pIssues.email)) {
      vResult = false;
      throw "400.Email not valid";
    }
    if (pIssues.address == "") {
      vResult = false;
      throw "500.input address";
    }
    if (pIssues.city == "") {
      vResult = false;
      throw "600.input city";
    }
    if (pIssues.country == "") {
      vResult = false;
      throw "700.input country";
    }
    if (pIssues.postalCode == "") {
      vResult = false;
      throw "800.input postal code";
    }
    if (!/^\d+$/.test(pIssues.salesRepEmployeeNumber)) {
      vResult = false;
      throw "900.Sales rep employee number is digitals";
    }
    if (!/^\d+$/.test(pIssues.creditLimit)) {
      vResult = false;
      throw "1000.Sales rep employee number is digitals";
    }
  } catch (e) {
    alert(e);
  }
  return vResult;
}

function loadIssueOnChart(equipmentIds) {
  console.log(equipmentIds)
  let areaChartData = {
    labels: equipmentIds.map((data) => data.equipmentName),
    datasets: [
      {
        label: "Digital Goods",
        backgroundColor: "rgba(60,141,188,0.9)",
        borderColor: "rgba(60,141,188,0.8)",
        pointRadius: false,
        pointColor: "#3b8bba",
        pointStrokeColor: "rgba(60,141,188,1)",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(60,141,188,1)",
        data: equipmentIds.map((data) => data.issueCount),
      },
    ],
  };

  let barChartCanvas = $("#barChart").get(0).getContext("2d");
  let barChartData = $.extend(true, {}, areaChartData);
  let temp0 = areaChartData.datasets[0];
  barChartData.datasets[0] = temp0;

  let barChartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    datasetFill: false,
  };

  new Chart(barChartCanvas, {
    type: "bar",
    data: barChartData,
    options: barChartOptions,
  });
}
//  $('#reservationdatetime').daterangepicker({
//   opens: 'left'
// }, function(start, end, label) {
//   console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
// });
