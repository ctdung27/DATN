<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="formUrl" value="/api/product"/>
<html>
<head>
	
    <title>Chi tiết sản phẩm</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
            </script>
            <ul class="breadcrumb">
             
                <h2>Thêm Đồ Uống</h2>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
					<div class="container" style="width:600px;">
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
										<label class="col-sm-3 control-label no-padding-right">Thể
											loại sản phẩm</label>
										<div class="col-sm-9">
											<form:select path="productCategoryCode"
												id="productCategoryCode">
												<form:option value="" label="--- Chọn thể loại ---" />
												<form:options items="${productcategories}" />
											</form:select>
										</div>
									</div>
									<br>
									<br>
									<div class="form-group">
										<label class="col-sm-3 control-label">Tên sản phẩm</label>
										<div class="col-sm-9">
											<form:input path="name" id="name" cssClass="form-control" />
										</div>
									</div>
									<br>
									<br>
									<div class="form-group">
										<label class="col-sm-3 control-label">Mã sản phẩm</label>
										<div class="col-sm-9">
											<form:input path="code" id="code" cssClass="form-control" />
										</div>
									</div>
									<br>
									<br>
									<div class="form-group">
										<label class="col-sm-3 control-label">Giá</label>
										<div class="col-sm-9">
											<input type="number" class="form-control" name="price"
												id="price" value="${model.price}" />
										</div>
									</div>
							</div>
							<div class="panel-footer">
								<div class="form-group">
									<div class="row">
										<c:if test="${not empty model.id}">
											<div>
												<input type="button" class="btn btn-success btn-bold"
													value="Cập nhật" id="btnAddOrUpdateProduct" /> <a
													href="/admin/product/list"
													class="btn  btn-warning btn-bold">Trở về</a>
											</div>
										</c:if>
										<c:if test="${empty model.id}">
											<div>
												<input type="button" class="btn btn-success btn-bold"
													value="Thêm mới" id="btnAddOrUpdateProduct" /> 
													<a
													href="/admin/product/list" class="btn  btn-warning btn-bold">Trở
													về</a>
											</div>
										</c:if>
									</div>
								</div>
								<form:hidden path="id" id="productId" />
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

	$('#btnAddOrUpdateProduct').click(function(event) {
		event.preventDefault();
		var data = {};
		var formData = $('#formEdit').serializeArray();
		$.each(formData, function(i, v) {
			data["" + v.name + ""] = v.value;
		});
		var id = $('#productId').val();
		if (id == "") {
			addProduct(data);
		} else {
			updateProduct(data);
		}
	});

	function addProduct(data) {
		$.ajax({
			url : '${formUrl}',
			type : 'POST',
			dataType : 'json',
			contentType : 'application/json',
			data : JSON.stringify(data),
			success : function(res) {
				window.location.href = "<c:url value='/admin/product/edit?id="
						+ res.id + "&message=insert_success'/>";
			},
			error : function(res) {
				window.location.href = "<c:url value='/admin/product/edit?id="
						+ res.id + "&message=error_system'/>";
			}
		});
	}

	function updateProduct(data) {
		$.ajax({
			url : '${formUrl}',
			type : 'PUT',
			dataType : 'json',
			contentType : 'application/json',
			data : JSON.stringify(data),
			success : function(res) {
				window.location.href = "<c:url value='/admin/product/edit?id="
						+ res.id + "&message=update_success'/>";
			},
			error : function(res) {
				window.location.href = "<c:url value='/admin/product/edit?id="
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
