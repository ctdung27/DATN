<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="loadProduct" value="/api/product/order" />
<c:url var="addBillUrl" value="/api/order/" />
<c:url var="formUrl" value="/admin/order/list" />
<c:url var="updateQuantityURL" value="/api/order/" />
<c:url var="deleteURL" value="/api/order" />
<c:url var="checkoutURL" value="/api/order/checkout" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="<c:url value='../template/login/style.css' />" type="text/css"
	media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quản lí Bán Hàng</title>
</head>
<body>
	<div class="main-content">
		<%--<form:form commandName="model" action="" id="listForm" method="GET">--%>
		<div class="main-content-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<ul class="breadcrumb">
					<h2>
						BÁN HÀNG
						<h2>
				</ul>
				<!-- /.breadcrumb -->
			</div>
			<div class="page-content-order ">
				<div class="row">
					<div class="col-xs-12">
						<c:if test="${messageResponse!=null}">
							<div class="alert alert-block alert-${alert}">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								${messageResponse}
							</div>
						</c:if>

						<div class="row">
							<!-- PAGE CONTENT BEGINS -->
							<!-- Begin Content Left-->
							<div class="col-sm-6 " id="contentleft"
								style="padding-top: 20px;">
								<div id="Contentleft_danhmuc">
									<div class="widget-main">
										<div class="form-horizontal">
											<%--danh sach ban--%>
											<div class="row">
												<div class="col-xs-12">
													<!-- PAGE CONTENT BEGINS -->
													<div>
														<ul class="ace-thumbnails clearfix">
															<c:forEach var="item" items="${tables}">
																<li><c:url var="orderURL" value="/admin/order/list">
																		<c:param name="tableCode" value="${item.code}" />
																	</c:url> <c:if test="${item.status eq 'empty_seat'}">
																		<a href="${orderURL}" title="Bàn trống"
																			data-rel="colorbox"> <img width="150"
																			height="150" alt="150x150"
																			border=" #130d28 1.5px solid"
																			src="<c:url value="/template/admin/assets/images/gallery/thumb-1.jpg"/>" />
																		</a>
																	</c:if> <c:if test="${item.status eq 'full_seat'}">
																		<a href="${orderURL}" title="Bàn đã có người"
																			data-rel="colorbox"> <img width="150"
																			height="150" alt="150x150"
																			src="<c:url value="/template/admin/assets/images/gallery/thumb-6.jpg"/>" />
																		</a>
																	</c:if>
																	<div class="tags">
																		<span class="label-holder"> <span
																			class="label label-success">${item.name}</span>
																		</span>
																	</div></li>
															</c:forEach>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>

								</div>
							</div>
							<!-- Begin Content Right-->
							<div class="col-sm-6" id="contentleft" style="padding-top: 20px;">
								<c:if test="${not empty tableCode}">
									<div class="table-btn-controls">
										<div class="pull-right tableTools-container">
											<div class="dt-buttons btn-overlap btn-group">
												<button
													class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
													data-toggle="tooltip" type="button"
													title="Thêm món cho bàn" id="btnAddProduct"
													seatCode="${tableCode}">
													<i class="fa fa-plus-circle bigger-110 purple"></i>
												</button>
												<button
													class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
													data-toggle="tooltip" type="button"
													title="Xác nhận thanh toán" onclick="checkout(this)"
													seatCode="${tableCode}">
													<i class="ace-icon fa fa-check"></i>
												</button>
												<button
													class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
													data-toggle="tooltip" type="button"
													title="Xóa sản phẩm khỏi bàn" id="btnDeleteProduct"
													onclick="deleteProduct(this)" seatCode="${tableCode}">
													<i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
												</button>
											</div>
										</div>
									</div>
								</c:if>
								<div id="ContentRight_danhmuc">
									<table class="table table-bordered" id="orderTable">
										<thead>
											<tr>
												<th style="width: 58px;">Chọn</th>
												<th>Tên món</th>
												<th style="width: 68px;">Số lượng</th>
												<th>Giá</th>
												<th>Thành tiền</th>
												<%--<th>Ghi chú</th>--%>
												<th>Thao tác</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${not empty orders}">
												<c:forEach var="item" items="${orders}">
													<tr>
														<td style="padding-left: 20px;"><input
															type="checkbox" value="${item.id}"
															id="checkbox_${item.id}" class="check-box-element" /></td>
														<td>${item.name}</td>
														<td><input type="number" name="quantity"
															id="quantity_${item.id}" value="${item.quantity}"
															style="height: 33px; width: 43.45503px; padding-left: 8px;">
														</td>
														<td>${item.price}</td>
														<td>${item.totalPrice}VNĐ</td>
														<%--<td>${item.note}</td>--%>
														<td>
															<button class="btn btn-xs btn-primary btn-edit"
																data-toggle="tooltip" type="button"
																title="Cập nhật số lượng"
																onclick="updateQuantity(${item.id}, this)"
																seatCode="${tableCode}">
																<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
															</button>

														</td>
													</tr>
												</c:forEach>
											</c:if>
										</tbody>
									</table>
									<c:if test="${not empty totalPrice}">
										<p>Tổng tiền: ${totalPrice} VNĐ</p>
									</c:if>
								</div>


							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="assignBuildingModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Danh sách món ăn</h4>
				</div>
				<div class="modal-body">
					<table class="table" id="productTable">
						<thead>
							<tr>
								<th class="text-center">Chọn món ăn</th>
								<th class="text-center">Tên món ăn</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div id="fieldHidden"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						id="btnAddProductToTable">Thêm món ăn cho bàn</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
    $(document).ready(function () {

    });

    $('#btnAddProduct').click(function (e) {
        e.preventDefault();
        openModalAddProduct();
        loadProduct($(this).attr('seatCode'));
    });

    function openModalAddProduct() {
        $('#assignBuildingModal').modal();
    }

    function loadProduct(seatCode) {
        var seatCodeHidden = '<input type="hidden" name="seatCode" value=' + seatCode + ' id="seatCode"></input>';
        $('#fieldHidden').html(seatCodeHidden);
        $.ajax({
            url: '${loadProduct}?seatCode=' + seatCode,
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                var row = '';
                $.each(result, function (index, product) {
                    row += '<tr>';
                    row += '<td class="text-center"><input type="checkbox" name="checkList" value=' + product.id + ' id="checkbox_' + product.id + '" class="check-box-element" ' + product.checked + '/></td>';
                    row += '<td class="text-center">' + product.name + '</td>';
                    row += '</tr>';
                });
                $('#productTable tbody').html(row);
            },
            error: function (res) {
                console.log(res);
            }
        });
    }

    $('#btnAddProductToTable').click(function (e) {
        e.preventDefault();
        var seatCode = $('#fieldHidden').find('#seatCode').val();
        var productArrays = $('#productTable').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        addProduct(productArrays, seatCode);
    });

    function addProduct(products, seatCode) {
        $.ajax({
            url: '${addBillUrl}' + seatCode,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(products),
            success: function (res) {
                window.location.href = "${formUrl}?tableCode="+seatCode;
            },
            error: function (res) {
                console.log(res);
            }
        });
    }

    function updateQuantity(id, btn) {
        var seatCode = $(btn).attr('seatCode');
        var currentRow = $(btn).closest("tr");
        var quantity = currentRow.find("input[type=number]").val();
        var data = {};
        data["id"] = id;
        data["quantity"] = quantity;
        $.ajax({
            url: '${updateQuantityURL}',
            type: 'PUT',
            contentType:'application/json',
            data: JSON.stringify(data),
            success: function(res) {
                window.location.href = "${formUrl}?tableCode="+seatCode;
            },
            error: function(res) {
                console.log(res);
            }
        });
    }

    function deleteProduct(btn) {
        var data = $('#orderTable').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        var seatCode = $(btn).attr('seatCode');
        $.ajax({
            url: '${deleteURL}',
            type: 'DELETE',
            contentType:'application/json',
            data: JSON.stringify(data),
            success: function(res) {
                window.location.href = "${formUrl}?tableCode="+seatCode;
            },
            error: function(res) {
                console.log(res);
            }
        });
    }

    function checkout(btn) {
        var data = $('#orderTable').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        var seatCode = $(btn).attr('seatCode');
        $.ajax({
            url: '${checkoutURL}?seatCode='+seatCode,
            type: 'PUT',
            contentType:'application/json',
            data: JSON.stringify(data),
            success: function(res) {
                window.location.href = "${formUrl}?tableCode="+seatCode;
            },
            error: function(res) {
                console.log(res);
            }
        });
    }
</script>
	<style>
h2 {
	color: #438eb9;
	font-size: 140%;
	font-weight: 700;
	text-align: center;
	margin: 0px;
	font-family: 'Open Sans';
}

#contentleft p {
	text-align: center;
}

#Contentleft_danhmuc {
	margin-top: 30px;
	border: 2px solid #000;
	border-radius: 10px;
	height: 500px;
	background-color: hsla(27, 80%, 92%, 0.38);
}

#ContentRight_danhmuc {
	margin-top: 100px;
	border-radius: 20px;
	height: 430px;
	background-color: #438EB9;
}

.list_table {
	padding-top: 15px;
	overflow-y: auto;
}
</style>
</body>
</html>
