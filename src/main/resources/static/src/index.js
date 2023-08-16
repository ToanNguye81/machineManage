// let gCustomerId = "";
// let gDepartmentId = 0;
// let gOrderId = "";
// let gCart = [];
// let gOrderDetailId = "";
// let customerSelect = $("#sel-customer");
// let orderSelect = $("#sel-order");
//load customer to select
// function loadCustomerToSelect(pCustomer) {
//   pCustomer.forEach((customer) => {
//     $("<option>", {
//       text: customer.firstName + " " + customer.lastName,
//       value: customer.id,
//     }).appendTo(customerSelect);
//   });
// }
// event onChange customer select
// $.get(`/customers/${gCustomerId}`, loadCustomerToSelect);
let departmentSelect = $("#sel-department");
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

// // event onChange customer select
// customerSelect.change(onGetCustomerChange);

// // event onChange order select
// orderSelect.change(onGetOrderChange);

// // on get customer change
// function onGetCustomerChange(event) {
//   gCustomerId = event.target.value;
//   $("#customer-of-order").val($("#sel-customer option:selected").text());
//   $.get(`/customers/${gCustomerId}/order`, loadOrderToTable);
// }

// // on get order change
// function onGetOrderChange(event) {
//   gOrderId = event.target.value;
// }
// //load order to select
// function loadOrderToSelect(pOrder) {
//   orderSelect
//     .empty()
//     .append('<option selected="selected" value="">Choose order</option>');
//   pOrder.forEach((order) => {
//     $("<option>", {
//       text: order.comments,
//       value: order.id,
//     }).appendTo(orderSelect);
//   });
// }

// // order
// let order = {
//   newOrder: {
//     customerId: "",
//     comments: "",
//     status: "",
//     cart: [],
//   },
//   onCreateNewOrderClick() {
//     this.newOrder = {
//       customerId: parseInt(gCustomerId, 10),
//       comments: $("#inp-comments").val().trim(),
//       cart: gCart,
//     };
//     console.log(this.newOrder);
//     if (validateOrder(this.newOrder)) {
//       $.ajax({
//         url: `/order`,
//         method: "POST",
//         data: JSON.stringify(this.newOrder),
//         contentType: "application/json",
//         success: () => {
//           alert(`Order created successfully`);
//           $.get(`/customers/${gCustomerId}/order`, loadOrderToTable);
//         },
//       });
//     }
//   },
// };

// $("#btn-save-order").click(onSaveOrderClick);
// $("#btn-create-order").click(order.onCreateNewOrderClick);
// $("#btn-confirm-delete-order").click(onConfirmDeleteOrderClick);

// function loadOrderToInput(pOrder) {
//   $("#inp-order-date").val(pOrder.orderDate);
//   $("#inp-required-date").val(pOrder.requiredDate);
//   $("#inp-shipped-date").val(pOrder.shippedDate);
//   $("#inp-status").val(pOrder.status);
//   $("#inp-update-comments").val(pOrder.comments);
// }

// function validateOrder(pOrder) {
//   let vResult = true;
//   console.pOrder;
//   try {
//     if (isNaN(pOrder.customerId)) {
//       vResult = false;
//       throw `Customer can't be empty`;
//     }
//     if (pOrder.cart.length == 0) {
//       vResult = false;
//       throw `Cart can't be empty`;
//     }
//   } catch (e) {
//     alert(e);
//   }
//   return vResult;
// }
// let orderTable = $("#order-table").DataTable({
//   columns: [
//     { data: "id" },
//     { data: "orderDate" },
//     { data: "shippedDate" },
//     { data: "requiredDate" },
//     { data: "status" },
//     { data: "comments" },
//     { data: "Action" },
//   ],
//   columnDefs: [
//     {
//       targets: -1,
//       defaultContent: `<i class="fas fa-edit text-primary"></i>
//       | <i class="fas fa-trash text-danger"></i>`,
//     },
//   ],
// });

// //Cart
// let cartTable = $("#cart-table").DataTable({
//   columns: [
//     { data: "department.id" },
//     { data: "department.departmentName" },
//     { data: "department.departmentCode" },
//     { data: "department.buyPrice" },
//     { data: "quantity" },
//     { data: "Action" },
//   ],
//   columnDefs: [
//     {
//       targets: -1,
//       defaultContent: `<i class="fas fa-plus text-primary"></i>
//       | <i class="fas fa-minus text-danger"></i>
//       | <i class="fas fa-trash text-danger"></i>`,
//     },
//   ],
// });

// function loadCartToTable(departments) {
//   cartTable.clear();
//   cartTable.rows.add(departments);
//   cartTable.draw();
// }

// function loadOrderToTable(pOrder) {
//   orderTable.clear();
//   orderTable.rows.add(pOrder);
//   orderTable.draw();
// }

// //Add to cart
// $("#order-table").on("click", ".fa-edit", onUpdateOrderClick);
// $("#order-table").on("click", ".fa-trash", onDeleteOrderClick);
// $("#cart-table").on("click", ".fa-plus", onPlusClick);
// $("#cart-table").on("click", ".fa-minus", onSubtractClick);
// $("#cart-table").on("click", ".fa-trash", onDeleteClick);
// $("#btn-add-to-cart").on("click", addToCart);

// function onPlusClick() {
//   let vSelectedRow = $(this).parents("tr");
//   let vSelectedData = cartTable.row(vSelectedRow).data();
//   let departmentId = vSelectedData.department.id;

//   let index = gCart.findIndex((item) => item.department.id === departmentId);
//   if (index !== -1) {
//     gCart[index].quantity++;
//   }
//   loadCartToTable(gCart);
// }

// function onSubtractClick() {
//   let vSelectedRow = $(this).parents("tr");
//   let vSelectedData = cartTable.row(vSelectedRow).data();
//   let departmentId = vSelectedData.department.id;

//   let index = gCart.findIndex((item) => item.department.id === departmentId);
//   if (index !== -1) {
//     if (gCart[index].quantity > 1) {
//       gCart[index].quantity--;
//     } else {
//       gCart.splice(index, 1);
//     }
//   }
//   loadCartToTable(gCart);
// }

// function onDeleteClick() {
//   let vSelectedRow = $(this).parents("tr");
//   let vSelectedData = cartTable.row(vSelectedRow).data();
//   let departmentId = vSelectedData.department.id;
//   let index = gCart.findIndex((item) => item.department.id === departmentId);
//   if (index !== -1) {
//     gCart.splice(index, 1);
//   }
//   loadCartToTable(gCart);
// }
// // Add department
// function addToCart() {
//   if (gDepartmentId !== 0) {
//     let existingItemIndex = gCart.findIndex(
//       (item) => item.department.id === gDepartmentId
//     );

//     if (existingItemIndex !== -1) {
//       gCart[existingItemIndex].quantity += 1;
//     } else {
//       let cartItem = {
//         departmentId: parseInt(gDepartmentId, 10),
//         department: {
//           id: gDepartmentId,
//           departmentCode: $("#sel-department option:selected").data("code"),
//           departmentName: $("#sel-department option:selected").data("name"),
//           buyPrice: $("#sel-department option:selected").data("price"),
//         },
//         quantity: 1,
//       };
//       gCart.push(cartItem);
//     }
//     loadCartToTable(gCart);
//   } else {
//     alert("Choose 1 department!");
//   }
// }

// //update order
// function onSaveOrderClick() {
//   newOrder = {
//     status: $("#inp-status").val().trim(),
//     orderDate: $("#inp-order-date").val().trim(),
//     comments: $("#inp-update-comments").val().trim(),
//     requiredDate: $("#inp-required-date").val().trim(),
//     shippedDate: $("#inp-shipped-date").val().trim(),
//   };

//   $.ajax({
//     url: `/customers/${gCustomerId}/orders/${gOrderId}`,
//     method: "PUT",
//     contentType: "application/json",
//     data: JSON.stringify(newOrder),
//     success: () => {
//       alert("successfully update order with id: " + gOrderId);
//       $.get(`/customers/${gCustomerId}/order`, loadOrderToTable);
//       $("#modal-update-order").modal("hide");
//     },
//     error: (err) => alert(err.responseText),
//   });
// }

// //Delete order
// function onDeleteOrderClick() {
//   let vSelectedRow = $(this).parents("tr");
//   let vSelectedData = orderTable.row(vSelectedRow).data();
//   gOrderId = vSelectedData.id;
//   $.get(`/orders/${gOrderId}`, loadOrderToInput);
//   $("#modal-delete-order").modal("show");
// }

// function onUpdateOrderClick() {
//   let vSelectedRow = $(this).parents("tr");
//   let vSelectedData = orderTable.row(vSelectedRow).data();
//   gOrderId = vSelectedData.id;
//   $.get(`/orders/${gOrderId}`, loadOrderToInput);
//   $("#modal-update-order").modal("show");
// }

// function onConfirmDeleteOrderClick() {
//   $.ajax({
//     url: `/orders/${gOrderId}`,
//     method: "DELETE",
//     success: () => {
//       alert("successfully delete order with id:" + gOrderId);
//       $.get(`/customers/${gCustomerId}/order`, loadOrderToTable);
//       $("#modal-delete-order").modal("hide");
//     },
//     error: (err) => alert(err.responseText),
//   });
// }
