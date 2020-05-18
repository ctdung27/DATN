<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title><dec:title default="Trang chủ" /></title>
	
	<link rel="stylesheet" href="<c:url value='/template/admin/assets/css/bootstrap.min.css' />" />
    <link rel="stylesheet" href="<c:url value='/template/admin/font-awesome/4.5.0/css/font-awesome.min.css' />" />
    <link rel="stylesheet" href="<c:url value='/template/admin/assets/css/ace.min.css' />" class="ace-main-stylesheet" id="main-ace-style" />
    <script src="<c:url value='/template/admin/assets/js/ace-extra.min.js' />"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<link rel="stylesheet" href="<c:url value='/template/admin/assets/css/datepicker.min.css' />" />
	<link rel="stylesheet" href="<c:url value='/template/admin/assets/css/bootstrap-timepicker.min.css' />" />
	<link rel="stylesheet" href="<c:url value='/template/admin/assets/css/daterangepicker.min.css' />" />
	<link rel="stylesheet" href="<c:url value='/template/admin/assets/css/bootstrap-datetimepicker.min.css' />" />

	<link rel="stylesheet" href="<c:url value='/template/login/style.css' />"  type="text/css" media="all"/>

	<%--sweetalert css--%>
	<link rel="stylesheet" href="<c:url value="/template/admin/assets/sweetalert2/sweetalert2.min.css"/>">

	<script type='text/javascript' src='<c:url value="/template/admin/js/jquery-2.2.3.min.js" />'></script>

    
</head>
<body class="no-skin">
	<!-- header -->
    <%@ include file="/common/admin/header.jsp" %>
    <!-- header -->
	
	<div class="main-container" id="main-container">
		<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
		</script>
		<!-- menu -->
    	<%@ include file="/common/admin/menu.jsp" %>
    	<!-- menu -->
		
		<dec:body/>
		
		<!-- footer -->
    	<%@ include file="/common/admin/footer.jsp" %>
    	<!-- footer -->
    	
    	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse display">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="<c:url value='/template/admin/assets/js/bootstrap.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/jquery-ui.custom.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/jquery.ui.touch-punch.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/jquery.easypiechart.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/jquery.sparkline.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/jquery.flot.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/jquery.flot.pie.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/jquery.flot.resize.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/ace-elements.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/ace.min.js' />"></script>
	<script src="<c:url value='/template/admin/assets/js/bootstrap.min.js'/>"></script>
	<!-- page specific plugin scripts -->
	<script src="<c:url value='/template/admin/assets/js/jquery-ui.min.js'/>"></script>

	<script src="<c:url value='/template/admin/assets/js/bootstrap-datepicker.min.js'/>"></script>
	<script src="<c:url value='/template/admin/assets/js/moment.min.js'/>"></script>
	<script src="<c:url value='/template/admin/assets/js/bootstrap-timepicker.min.js'/>"></script>
	<script src="<c:url value='/template/admin/assets/js/daterangepicker.min.js'/>"></script>
	<script src="<c:url value='/template/admin/assets/js/bootstrap-datetimepicker.min.js'/>"></script>

	<%--sweetalert js--%>
	<script type='text/javascript' src='<c:url value="/template/admin/assets/sweetalert2/sweetalert2.min.js"/>'></script>

	<script type="text/javascript">
        function showAlertBeforeDelete(callback) {
            swal({
                title: "Xác nhận xóa",
                text: "Bạn có chắc chắn xóa những dòng đã chọn",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "Xác nhận",
                cancelButtonText: "Hủy bỏ",
                confirmButtonClass: "btn btn-success",
                cancelButtonClass: "btn btn-danger"
            }).then(function (isConfirm) {
                if (isConfirm) {
                    callback();
                }
            });
        }
	</script>
</body>
</html>