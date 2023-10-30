
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

function getData(){

var selectedEquipmentIds = [];

$("input[name='equipment']:checked").each(function () {
  selectedEquipmentIds.push($(this).val());
});

console.log(selectedEquipmentIds)
$.get(
  "/issue/equipment/issue-count?equipmentIds=" + selectedEquipmentIds.join(","),
  loadIssueOnChart
);
}

$("#btn-search").click(getData);

$("#count-issue").change(function() {
  if ($(this).is(":checked")) {
      $("#count-downtime").prop("checked", false);
  }
});

$("#count-downtime").change(function() {
  if ($(this).is(":checked")) {
      $("#count-issue").prop("checked", false);
  }
});


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
