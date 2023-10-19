"use strict";
var selectedCountries = [
  "usa",
  "canada",
  "Australia",
  "germany",
  "Poland",
  "France",
  "Sweden",
];
$.get(
  "/issue/count?countries=" + selectedCountries.join(","),
  loadCustomerOnChart
);
let gCustomerId = 0;
let issue = {
  newCustomer: {
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

  onCreateNewCustomerClick() {
    this.newCustomer = {
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
    if (validateCustomer(this.newCustomer)) {
      $.ajax({
        url: "/issue",
        method: "POST",
        data: JSON.stringify(this.newCustomer),
        contentType: "application/json",
        success: (data) => {
          alert("Customer created successfully");
          getCustomerFromDb();
          resetCustomerInput();
        },
        error: (err) => alert(err.responseText),
      });
    }
  },
  onUpdateCustomerClick() {
    let vSelectedRow = $(this).parents("tr");
    let vSelectedData = issueTable.row(vSelectedRow).data();
    gCustomerId = vSelectedData.id;
    $.get(`/issue/${gCustomerId}`, loadCustomerToInput);
  },
  onSaveCustomerClick() {
    this.newCustomer = {
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
    if (validateCustomer(this.newCustomer)) {
      $.ajax({
        url: `/issue/${gCustomerId}`,
        method: "PUT",
        data: JSON.stringify(this.newCustomer),
        contentType: "application/json",
        success: (data) => {
          alert("Customer updated successfully");
          getCustomerFromDb();
          gCustomerId = 0;
          resetCustomerInput();
        },
        error: (err) => alert(err.responseText),
      });
    }
  },
  onDeleteCustomerByIdClick() {
    $("#modal-delete-issue").modal("show");
    let vSelectedRow = $(this).parents("tr");
    let vSelectedData = issueTable.row(vSelectedRow).data();
    gCustomerId = vSelectedData.id;
  },
  onDeleteAllCustomerClick() {
    $("#modal-delete-issue").modal("show");
    gCustomerId = 0;
  },
  onDeleteConfirmClick() {
    if (gCustomerId == 0) {
      $.ajax({
        url: "/issue",
        method: "DELETE",
        success: () => {
          alert("All issue were successfully deleted");
          getCustomerFromDb();
          $("#modal-delete-issue").modal("hide");
        },
        error: (err) => alert(err.responseText),
      });
    } else {
      $.ajax({
        url: `/issue/${gCustomerId}`,
        method: "DELETE",
        success: () => {
          alert(`Customer with id: ${gCustomerId} was successfully deleted`);
          getCustomerFromDb();
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
function loadCustomerOnTable(pCustomers) {
  "use strict";
  issueTable.clear();
  issueTable.rows.add(pCustomers);
  issueTable
    .draw()
    .buttons()
    .container()
    .appendTo("#issue-table_wrapper .col-md-6:eq(0)");
}

function getCustomerFromDb() {
  "use strict";
  $.get("/issue?size=20", (issue) => {
    loadCustomerOnTable(issue);
  });
}
getCustomerFromDb();

$("#create-issue").click(issue.onCreateNewCustomerClick);
$("#issue-table").on("click", ".fa-edit", issue.onUpdateCustomerClick);
$("#issue-table").on(
  "click",
  ".fa-trash",
  issue.onDeleteCustomerByIdClick
);
$("#update-issue").click(issue.onSaveCustomerClick);
$("#delete-all-issue").click(issue.onDeleteAllCustomerClick);
$("#delete-issue").click(issue.onDeleteConfirmClick);

function loadCustomerToInput(pCustomers) {
  $("#input-first-name").val(pCustomers.firstName);
  $("#input-last-name").val(pCustomers.lastName);
  $("#input-phone-number").val(pCustomers.phoneNumber);
  $("#input-email").val(pCustomers.email);
  $("#input-address").val(pCustomers.address);
  $("#input-city").val(pCustomers.city);
  $("#input-state").val(pCustomers.state);
  $("#input-country").val(pCustomers.country);
  $("#input-postal-code").val(pCustomers.postalCode);
  $("#input-employee-number").val(pCustomers.creditLimit);
  $("#input-credit-limit").val(pCustomers.salesRepEmployeeNumber);
}

function resetCustomerInput() {
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

function validateCustomer(pCustomers) {
  "use strict";
  let vResult = true;
  try {
    if (pCustomers.firstName == "") {
      vResult = false;
      throw "100.input first name";
    }
    if (pCustomers.lastName == "") {
      vResult = false;
      throw "200.input last name";
    }
    if (!/^\d{10}$/.test(pCustomers.phoneNumber)) {
      vResult = false;
      throw "300.input phone number is 10 digitals";
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(pCustomers.email)) {
      vResult = false;
      throw "400.Email not valid";
    }
    if (pCustomers.address == "") {
      vResult = false;
      throw "500.input address";
    }
    if (pCustomers.city == "") {
      vResult = false;
      throw "600.input city";
    }
    if (pCustomers.country == "") {
      vResult = false;
      throw "700.input country";
    }
    if (pCustomers.postalCode == "") {
      vResult = false;
      throw "800.input postal code";
    }
    if (!/^\d+$/.test(pCustomers.salesRepEmployeeNumber)) {
      vResult = false;
      throw "900.Sales rep employee number is digitals";
    }
    if (!/^\d+$/.test(pCustomers.creditLimit)) {
      vResult = false;
      throw "1000.Sales rep employee number is digitals";
    }
  } catch (e) {
    alert(e);
  }
  return vResult;
}

function loadCustomerOnChart(countList) {
  let areaChartData = {
    labels: countList.map((data) => data.country),
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
        data: countList.map((data) => data.issueCount),
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
