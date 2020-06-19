<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="reportURL" value="/admin/report/list" />
<c:url var="loadOrderDetail" value="/api/order/details" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thống kê</title>
</head>
<body class="no-skin">
	<div class="main-content">
		<div class="main-content-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<ul class="breadcrumb">
					<h2>
						THỐNG KÊ DOANH THU
						<h2>
				</ul>
			</div>
			<div class="page-content">
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
						<form:form action="${reportURL}" method="get" commandName="model">
							<div class="row">
								<div class="col-xs-6">
									<div class="widget-box table-filter">
										<div class="widget-header">
											<h2 class="widget-title">Tìm kiếm</h2>
											<div class="widget-toolbar">
												<a href="#" data-action="collapse"> <i
													class="ace-icon fa fa-chevron-up"></i>
												</a>
											</div>
										</div>
										<div class="widget-body">
											<div class="widget-main">
												<div class="form-horizontal">
													<div class="form-group">
														<label class="col-sm-2 control-label">Từ Ngày: </label>
														<div class="col-sm-8">
															<div class="input-group">
																<input class="form-control date-picker" id="fromDate"
																	type="text" data-date-format="dd-mm-yyyy"
																	value="${model.fromDate}" name="fromDate" /> <span
																	class="input-group-addon"> <i
																	class="fa fa-calendar bigger-110"></i>
																</span>
															</div>
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label">Đến Ngày: </label>
														<div class="col-sm-8">
															<div class="input-group">
																<input class="form-control date-picker" id="toDate"
																	type="text" data-date-format="dd-mm-yyyy"
																	value="${model.toDate}" name="toDate" /> <span
																	class="input-group-addon"> <i
																	class="fa fa-calendar bigger-110"></i>
																</span>
															</div>
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 control-label"></label>
														<div class="col-sm-8">
															<button type="submit" class="btn btn-sm btn-success"
																id="btnSearch">
																Tìm kiếm <i
																	class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
															</button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-xs-6">

									<div class="viewdoanhthu">
										<div class="groupdanhthu">
											<div class="doanhthutitle">DOANH THU</div>
										<c:if test="${not empty totalPrice}">
												<div class="valuedanhthu">${totalPrice} VNĐ</div>
											</c:if>
										</div>
									</div>

								</div>
							</div>
						</form:form>
						<!-- PAGE CONTENT BEGINS -->
						
							<div class="row">
								<div class="col-xs-12">
									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th class="text-center">Mã Hóa Đơn</th>
												<th class="text-center">Ngày Xuất</th>
												<th class="text-center">Chi Tiết</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${reports}">
												<tr>

													<td class="text-center">${item.code}</td>
													<td class="text-center">${item.createdDate}</td>
													<td class="text-center">
														<button class="btn btn-xs btn-primary btn-edit"
															data-toggle="tooltip" type="button"
															onclick="viewDetail(${item.code})" title="Xem chi tiết">
															<i class="fa fa-pencil-square-o" aria-hidden="true"><span class="menu-text"></span> Chi tiết</i>
														</button>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="orderDetailModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title text-center">Chi tiết hóa đơn</h2>
					<h5 class="modal-title text-center">Nhân Viên: Tiến Dũng</h5>
					
				</div>
				<div class="modal-body">
					<table class="table" id="orderDetailTable">
						<thead>
							<tr>
								<th class="text-center">Tên sản phẩm</th>
								<th class="text-center">Số lượng</th>
								<th class="text-center">Giá</th>
								<th class="text-center">Thành tiền</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<div id="totalPrice"></div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
		$(document).ready(function() {

			//show datetime picker
			$('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			}).next().on(ace.click_event, function() {
				$(this).prev().focus();
			});

		});
		
		 function viewDetail(code) {
		        $('#orderDetailModal').modal();
		        $.ajax({
		            url: '${loadOrderDetail}?code=' + code +'',
		            type: 'GET',
		            dataType: 'json',
		            success: function (result) {
		                var row = '';
		                $.each(result.orders, function (index, product) {
		                    row += '<tr>';
		                    row += '<td class="text-center">' + product.name + '</td>';
		                    row += '<td class="text-center">' + product.quantity + '</td>';
		                    row += '<td class="text-center">' + product.price + ' VNĐ</td>';
		                    row += '<td class="text-center">' + product.totalPrice + ' VNĐ</td>';
		                    row += '</tr>';
		                });
		                $('#orderDetailTable tbody').html(row);
		                $('#totalPrice').html('<p class="text-center">Tổng Tiền: '+result.total+' VNĐ</p>');
		            },
		            error: function (res) {
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
	text-transform: uppercase;
	margin: 0px;
	font-family: 'Open Sans';
}

.viewdoanhthu {
	height: 218.400px;
	border: 1px solid #007bff;
	border-radius: 0.3em;
}

.doanhthutitle {
	background-color: #438eb9;
	text-align: center;
	color: #fff;
	font-size: 20px;
	border-radius: 4px 4px 0px 0px;
	padding: 10px;
}

.valuedanhthu {
	text-align: center;
	font-size: 40px;
	padding: 37px 0 42px 0px;
	color: #007bff;
}
</style>
</body>
</html>
