<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="loadProduct" value="/api/product/order" />
<c:url var="addBillUrl" value="/api/order/" />
<c:url var="formUrl" value="/admin/order/list" />
<c:url var="updateQuantityURL" value="/api/order/" />
<c:url var="deleteURL" value="/api/order" />
<c:url var="checkoutURL" value="/api/order/checkout" />
<c:url var="loadTable" value="/admin/order/table/list" />
<c:url var="billURL" value="/api/order/bill" />

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
			
			</div>
			<div class="page-content-order">
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
												<div class="col-sm-6" style="height: 50px;">
													<form:form action="${loadTable}" commandName="model"
														method="get">
														<form:select path="code" id="areaCode"
															style="border-radius: 20px;width: 137px;text-align: center;">
															<form:option value="" label="Chọn khu vực" />
															<form:options items="${areas}" />
														</form:select>

													</form:form>
												</div>
												<div class="col-sm-6" style="height: 50px;">
													<c:if test="${not empty tableCode}">
														<div class="table-btn-controls">
															<div class="pull-right tableTools-container">
																<div class="dt-buttons btn-overlap btn-group">
																	<button
																		class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
																		data-toggle="tooltip" type="button"
																		title="Thêm món cho bàn" id="btnAddProduct"
																		seatCode="${tableCode}" areaCode="${model.code}">
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
												</div>
												<div class="col-sm-12" style="height: 90px">

													<div>
														<ul class="ace-thumbnails clearfix">
															<c:forEach var="item" items="${tables}">
																<li><c:url var="orderURL" value="/admin/order/list">
																		<c:param name="tableCode" value="${item.code}" />
																		<c:param name="areaCode" value="${model.code}" />
																	</c:url> <c:if test="${item.status eq 'empty_seat'}">
																		<a href="${orderURL}" title="Bàn trống"
																			data-rel="colorbox"> <img width="70" height="70"
																			alt="70x70" border=" #130d28 1.5px solid"
																			src="<c:url value="/template/admin/assets/images/gallery/thumb-1.jpg"/>" />
																		</a>
																	</c:if> <c:if test="${item.status eq 'full_seat'}">
																		<a href="${orderURL}" title="Bàn đã có người"
																			data-rel="colorbox"> <img width="70" height="70"
																			alt="70x70"
																			src="<c:url value="/template/admin/assets/images/gallery/thumb-6.jpg"/>" />
																		</a>
																	</c:if>
																	<div class="tags">
																		<span class="label"
																			style="background-color: hsla(140, 100%, 30%, 0.5);">${item.name}</span>
																	</div></li>
															</c:forEach>
														</ul>
													</div>
												</div>


												<div class="col-sm-6" style="height: 50px;">
													<select id="productCategory"
														style="border-radius: 20px; width: 137px;"
														onchange="loadProduct($('#btnAddProduct').attr('seatCode'),$('#productCategory').val())">
														<option value="Chọn Loại Đồ Uống">Chọn Loại Đồ
															Uống
															<c:forEach var="item" items="${productCategories}">
																<option value="${item.code}">${item.name}</option>
															</c:forEach>
													</select>
												</div>

												<div class="col-sm-6" style="height: 50px;">
													<div class="pull-right tableTools-container">
														<button
															class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
															data-toggle="tooltip" type="button" title="Thêm vào bàn"
															id="btnAddProductToTable" seatCode="${tableCode}"
															areaCode="${model.code}">
															<i class="fa fa-plus-circle bigger-110 purple"></i>
														</button>
													</div>
													<table style="background-color: hsl(60, 20%, 75%);" class="table table-hover table-bordered"  id="productTable">

														<tbody>
														</tbody>
													</table>
												</div>

											</div>
										</div>
									</div>

								</div>
							</div>
							<!-- Begin Content Right-->
							<div class="col-sm-6" id="contentleft" style="padding-top: 20px;">
								<c:if test="${not empty tableCode}">
									<div id="ContentRight_danhmuc">

										<table class="table table-condensed " id="orderTable"
											style="text-align: center;">
											<thead>
												<tr>
													<th class="text-center" style="width: 58px;">Chọn</th>
													<th class="text-center">Tên món</th>
													<th class="text-center" style="width: 68px;">Số lượng</th>
													<th class="text-center">Giá</th>
													<th class="text-center">Thành tiền</th>

													<th class="text-center">Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="${not empty orders}">
													<c:forEach var="item" items="${orders}">
														<tr>
															<td style="padding-left: 20px;"><input
																type="checkbox" value="${item.id}"
																id="checkbox_${item.id}" class="check-box-element" checked/></td>
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
											<hr>
											<h3 style="text-align: right;">
												<i>Tổng tiền: ${totalPrice} VNĐ</i>
											</h3>
											<button type="button" class="btn btn-primary"
												id="btnExportBill" seatCode="${tableCode}">Xuất hóa
												đơn</button>
										</c:if>
										<br /> <br />
										<c:if test="${not empty urlBill}">
											<c:set var="billDownload" value="/repository/${urlBill}" />
											<p>
												Tải hóa đơn tại đây: <a href="${billDownload}">HÓA ĐƠN</a>
											</p>
										</c:if>
									</div>
								</c:if>
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
				<div class="modal-header"></div>
				<div class="modal-body">
					<label for="productCategory">Chọn loại đồ uống</label> <select
						class="form-control" id="productCategory">
						<c:forEach var="item" items="${productCategories}">
							<option value="${item.code}">${item.name}</option>
						</c:forEach>
					</select> <br />
					<button type="button" class="btn btn-sm btn-success"
						id="btnShowProduct">Hiển thị đồ uống</button>
					<br /> <br />
					<table class="table" id="productTable">
						<thead>
							<tr>
								<th class="text-center">Chọn đồ uống</th>
								<th class="text-center">Tên đồ uống</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div id="fieldHidden"></div>
				</div>


			</div>
		</div>
	</div>
	<script type="text/javascript">
    $(document).ready(function () {

    });
    $('select').change(function() {
        $(this).parents('form').submit();
    });
 
    $('#btnAddProduct').click(function (e) {
        e.preventDefault();
        openModalAddProduct();
    });

    $('#btnShowProduct').click(function (e) {
        e.preventDefault();
        var productCategory = $('#productCategory').val();
        loadProduct($('#btnAddProduct').attr('seatCode'), productCategory);
    });

    function openModalAddProduct() {
        $('#assignBuildingModal').modal();
    }
    

    function loadProduct(seatCode, productCategory) {
        var seatCodeHidden = '<input type="hidden" name="seatCode" value=' + seatCode + ' id="seatCode"></input>';
        $('#fieldHidden').html(seatCodeHidden);
        $.ajax({
            url: '${loadProduct}?seatCode=' + seatCode +'&productCategory='+productCategory+'',
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                var row = '';
                $.each(result, function (index, product) {
                    row += '<tr>';
                    row += '<td class="text-center tenDoUong">' + product.name + '</td>';
                    row += '<td class="text-center"><input type="checkbox" name="checkList" value=' + product.id + ' id="checkbox_' + product.id + '" class="check-box-element" ' + product.checked + '/></td>';
                    
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
        var areaCode = $('#btnAddProduct').attr('areaCode');
        var productArrays = $('#productTable').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        addProduct(productArrays, seatCode, areaCode);
    });

    function addProduct(products, seatCode, areaCode) {
        $.ajax({
            url: '${addBillUrl}' + seatCode,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(products),
            success: function (res) {
                window.location.href = "${formUrl}?tableCode="+seatCode+"&areaCode="+areaCode+"";
            },
            error: function (res) {
                console.log(res);
            }
        });
    }

    function updateQuantity(id, btn) {
        var seatCode = $(btn).attr('seatCode');
        var areaCode = $('#btnAddProduct').attr('areaCode');
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
                window.location.href = "${formUrl}?tableCode="+seatCode+"&areaCode="+areaCode+"";
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
        var areaCode = $('#btnAddProduct').attr('areaCode');
        $.ajax({
            url: '${deleteURL}',
            type: 'DELETE',
            contentType:'application/json',
            data: JSON.stringify(data),
            success: function(res) {
                window.location.href = "${formUrl}?tableCode="+seatCode+"&areaCode="+areaCode+"";
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
        var areaCode = $('#btnAddProduct').attr('areaCode');
        $.ajax({
            url: '${checkoutURL}?seatCode='+seatCode,
            type: 'PUT',
            contentType:'application/json',
            data: JSON.stringify(data),
            success: function(res) {
                window.location.href = "${formUrl}?tableCode="+seatCode+"&areaCode="+areaCode+"";
            },
            error: function(res) {
                console.log(res);
            }
        });
    }

    $('#btnExportBill').click(function (e) {
        e.preventDefault();
        var seatCode = $(this).attr('seatCode');
        var areaCode = $('#btnAddProduct').attr('areaCode');
        $.ajax({
            url: '${billURL}?tableCode='+seatCode,
            type: 'GET',
            success: function(res) {
                console.log(res);
                window.location.href = "${formUrl}?tableCode="+seatCode+"&areaCode="+areaCode+"&urlBill="+res+"";
            },
            error: function(res) {
                console.log(res);
            }
        });
    });
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

h3 {
	color: #585858 font-size: 140%;
	font-weight: 700;
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
	margin-top: 40px;
	/*box-shadow: 5px 10px #adad85;
	height: 500px;*/
	background-color: hsl(60, 20%, 75%);
	border-radius: 10px;
}

.list_table {
	padding-top: 15px;
	overflow-y: auto;
}

.tenDoUong {
	color: black;
	font-size: 120%;
	font-weight: 700;
	font-family: 'Open Sans';
}
.page-content-order {
	background-image: url(/template/admin/assets/css/images/anh-nen3.jpg);
	
	position: relative;
	margin: 0;
	padding: 8px 20px 24px
}
</style>
</body>
</html>
