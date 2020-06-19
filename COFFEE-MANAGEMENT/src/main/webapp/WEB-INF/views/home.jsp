<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<c:url var="userAPI" value="/api/admin/user"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <title>Trang chủ</title> -->
</head>
<body>
	<div class="main-content">
		<div class="main-content-inner">

			<div class="page-content">

				<div class="row">
					<div class="col-xs-12">
						<security:authorize ifAnyGranted="admin">
							<h1>Quản Trị Viên</h1>
							<div class="row">
								<div
									style="background-color: #E4E6E9; padding: 30px 20px; border: 20px white solid; border-radius:50px;"
									class="col-xs-3">
									<div class="col-xs-3">
										<i
											style="font-size: 50px; background-color: red; color: white; padding: 5px;"
											class="ace-icon fa fa-users"></i>
									</div>
									<div class="col-xs-9">
										<span class="col-xs-8" style="font-size: 20px;">5<br>Nhân
											Viên
										</span>
									</div>
								</div>
								<div
									style="background-color: #E4E6E9; padding: 30px 20px; border: 20px white solid;border-radius:50px;"
									class="col-xs-3">
									<div class="col-xs-3">
										<i
											style="font-size: 50px; background-color: blue; color: white; padding: 5px;"
											class="ace-icon fa fa-coffee"></i>
									</div>
									<div class="col-xs-9">
										<span class="col-xs-8" style="font-size: 20px;">12<br> Đồ Uống
										</span>
									</div>
								</div>
								<div
									style="background-color: #E4E6E9; padding: 30px 20px; border: 20px white solid;border-radius:50px;"
									class="col-xs-3">
									<div class="col-xs-3">
										<i
											style="font-size: 50px; background-color: #ffad33; color: white; padding: 5px;"
											class="ace-icon fa fa-building"></i>
									</div>
									<div class="col-xs-9">
										<span class="col-xs-8" style="font-size: 20px;">4<br>Tầng
										</span>
									</div>
								</div>
								<div
									style="background-color: #E4E6E9; padding: 30px 20px; border: 20px white solid;border-radius:50px;"
									class="col-xs-3">
									<div class="col-xs-3">
										<i
											style="font-size: 50px; background-color: green; color: white; padding: 5px;"
											class="ace-icon fa fa-file-text-o"></i>
									</div>
									<div class="col-xs-9">
										<span class="col-xs-8" style="font-size: 20px;">170<br>Hóa Đơn
										</span>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6">
									<div class="widget-box transparent">
										<div class="widget-header widget-header-flat">
											<h4 class="widget-title lighter">
												<i class="ace-icon fa fa-star orange"></i> DOANH THU NHÂN
												VIÊN
											</h4>

											<div class="widget-toolbar">
												<a href="#" data-action="collapse"> <i
													class="ace-icon fa fa-chevron-up"></i>
												</a>
											</div>
										</div>

										<div class="widget-body">
											<div class="widget-main no-padding">
												<table class="table table-bordered table-striped">
													<thead class="thin-border-bottom">
														<tr>
															<th><i class="ace-icon fa fa-caret-right blue"></i>Họ
																Tên</th>

															<th><i class="ace-icon fa fa-caret-right blue"></i>Tổng
																Doanh Thu</th>

															<th class="hidden-480"><i
																class="ace-icon fa fa-caret-right blue"></i>Trạng Thái</th>
														</tr>
													</thead>

													<tbody>
													
													<c:forEach var="item" items="${users}">
														<tr>
															<td>${item.fullName}</td>

															<td> <b class="green">1.300.000 VNĐ</b></td>

															<td class="hidden-480"><span
																class="label label-info arrowed-right arrowed-in">ACTIVE</span></td>
														</tr>
													
														</c:forEach>
													</tbody>
												</table>
											</div>
											<!-- /.widget-main -->
										</div>
										<!-- /.widget-body -->
									</div>
									<!-- /.widget-box -->
								</div>
								<!-- /.col -->

								<div class="col-sm-6">
									<div class="widget-box transparent">
										<div class="widget-header widget-header-flat">
											<h4 class="widget-title lighter">
												<i class="ace-icon fa fa-signal"></i> DOANH THU HẰNG NGÀY
											</h4>

											<div class="widget-toolbar">
												<a href="#" data-action="collapse"> <i
													class="ace-icon fa fa-chevron-up"></i>
												</a>
											</div>
										</div>

										<div class="widget-body">
											<div class="viewdoanhthu">
												<div class="groupdanhthu">
													<c:if test="${not empty totalPrice}">
									<div class="valuedanhthu">${totalPrice} VNĐ <br>---------GOOD LUCK--------- </div>
									</c:if>
												</div>
											</div>
										</div>
										<!-- /.widget-body -->
									</div>
									<!-- /.widget-box -->
								</div>
								<!-- /.col -->
							</div>
							<!-- /.row -->
					</div>
					</security:authorize>
					<security:authorize ifAnyGranted="staff">

						<h1>NHÂN VIÊN</h1>
					</security:authorize>
				</div>
			</div>
		</div>
	</div>

	<!-- /.main-content -->
	<style>
.viewdoanhthu {
	height: 17em;
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