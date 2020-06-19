<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="formUrl" value="/api/admin/user/profile" />
<html>
<head>
<link rel="stylesheet" href="<c:url value='/template/admin/assets/css/ace.min.css' />" class="ace-main-stylesheet" id="main-ace-style" />
<title>Thông tin cá nhân</title>
</head>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="breadcrumbs" id="breadcrumbs">

				<ul class="breadcrumb">

					<h2>Thông tin cá nhân</h2>
				</ul>
				<!-- /.breadcrumb -->
			</div>
			<div class="page-content">
				<div class="row">
					<div class="container" style="width: 600px;">
						<div class="panel panel-default">
							<div class="panel-body">
								<c:if test="${not empty messageResponse}">
									<div class="alert alert-block alert-${alert}">
										<button type="button" class="close" data-dismiss="alert">
											<i class="ace-icon fa fa-times"></i>
										</button>
										${messageResponse}
									</div>
								</c:if>
								<form:form id="formEdit" commandName="model">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right">Tên
											đăng nhập</label>
										<div class="col-sm-9">
											<form:input path="userName" id="userName"
												cssClass="form-control" />
										</div>
									</div>
									<br />
									<br />
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right">Họ
											tên</label>
										<div class="col-sm-9">
											<form:input path="fullName" id="fullName"
												cssClass="form-control" />
										</div>
									</div>
									<br />
									<br />
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right">Địa
											chỉ </label>
										<div class="col-sm-9">
											<form:input path="diachi" id="diachi" cssClass="form-control" />
										</div>
									</div>
									<br />
									<br />
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right">Số
											điện thoại</label>
										<div class="col-sm-9">
											<form:input path="sdienthoai" id="sdienthoai"
												cssClass="form-control" />
										</div>
									</div>
									<br />
									<br />
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right">Email</label>
										<div class="col-sm-9">
											<form:input path="email" id="email" cssClass="form-control" />
										</div>
									</div>
									<br />
									<br />
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right">Mật
											khẩu</label>
										<div class="col-sm-9">
											<input type="password" class="form-control" id="password"
												name="password"
												placeholder="Nhập mật khẩu muốn đổi" />
										</div>
									</div>
							</div>
							<div class="panel-footer">
								<div class="form-group">

									<c:if test="${not empty model.id}">
										<input type="button" class="btn btn-success btn-bold"
											value="Cập nhật" id="btnAddOrUpdateUser" />
										<a href="/admin/home" class="btn  btn-warning btn-bold">Trở
											về </a>


									</c:if>
									<c:if test="${empty model.id}">
										<input type="button" class="btn btn-success btn-bold"
											value="Thêm mới" id="btnAddOrUpdateUser" />
										<a href="/admin/home" class="btn  btn-warning btn-bold">Trở
											về</a>
									</c:if>
								</div>
							</div>
							<form:hidden path="id" id="userId" />
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$(document).ready(function() {
			});
			$('#btnAddOrUpdateUser').click(function(event) {
				event.preventDefault();
				var data = {};
				var formData = $('#formEdit').serializeArray();
				$.each(formData, function(i, v) {
					data["" + v.name + ""] = v.value;
				});
				updateUser(data);
			});
			function updateUser(data) {
				$
						.ajax({
							url : '${formUrl}',
							type : 'PUT',
							dataType : 'json',
							contentType : 'application/json',
							data : JSON.stringify(data),
							success : function(res) {
								window.location.href = "<c:url value='/admin/user/profile?id="
										+ res.id + "&message=update_success'/>";
							},
							error : function(res) {
								window.location.href = "<c:url value='/admin/user/profile?id="
										+ res.id + "&message=error_system'/>";
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
</style>
</body>
</html>