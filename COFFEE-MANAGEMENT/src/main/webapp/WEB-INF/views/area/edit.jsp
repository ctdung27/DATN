<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="formUrl" value="/api/area" />
<html>
<head>
<title>Chi tiết khu vực</title>
</head>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<script type="text/javascript">
					try {
						ace.settings.check('breadcrumbs', 'fixed')
					} catch (e) {
					}
				</script>
				<ul class="breadcrumb">

					<h2>Chỉnh sửa khu vực</h2>
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
											khu vực</label>
										<div class="col-sm-9">
											<form:input path="name" id="name" cssClass="form-control" />
										</div>
									</div>
									<br />
									<br />
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right">Mã
											khu vực</label>
										<div class="col-sm-9">
											<form:input path="code" id="code" cssClass="form-control" />
										</div>
									</div>
							</div>
							<div class="panel-footer">
								<div class="form-group">
									<c:if test="${not empty model.id}">
										<input type="button" class="btn btn-success btn-bold"
											value="Cập nhật" id="btnAddOrUpdateArea" />
										<a href="/admin/area/list" class="btn  btn-warning btn-bold">Trở
											về</a>
									</c:if>
									<c:if test="${empty model.id}">
										<input type="button" class="btn btn-success btn-bold"
											value="Thêm mới" id="btnAddOrUpdateArea" />
										<a href="/admin/area/list" class="btn  btn-warning btn-bold">Trở
											về</a>
									</c:if>
								</div>
								<form:hidden path="id" id="areaId" />
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
		});
		$('#btnAddOrUpdateArea').click(function(event) {
			event.preventDefault();
			var data = {};
			var formData = $('#formEdit').serializeArray();
			$.each(formData, function(i, v) {
				data["" + v.name + ""] = v.value;
			});
			var id = $('#areaId').val();
			if (id == "") {
				addArea(data);
			} else {
				updateArea(data);
			}
		});
		function addArea(data) {
			$.ajax({
				url : '${formUrl}',
				type : 'POST',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify(data),
				success : function(res) {
					window.location.href = "<c:url value='/admin/area/edit?id="
							+ res.id + "&message=insert_success'/>";
				},
				error : function(res) {
					window.location.href = "<c:url value='/admin/area/edit?id="
							+ res.id + "&message=error_system'/>";
				}
			});
		}
		function updateArea(data) {
			$.ajax({
				url : '${formUrl}',
				type : 'PUT',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify(data),
				success : function(res) {
					window.location.href = "<c:url value='/admin/area/edit?id="
							+ res.id + "&message=update_success'/>";
				},
				error : function(res) {
					window.location.href = "<c:url value='/admin/area/edit?id="
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
	margin: 0px;
	font-family: 'Open Sans';
}
</style>
</body>
</html>