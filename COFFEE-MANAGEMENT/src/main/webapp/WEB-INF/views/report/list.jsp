<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="reportURL" value="/admin/report/list"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thống kê</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <ul class="breadcrumb">
                <h2>THỐNG KÊ DOANH THU<h2>
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
                            <div class="col-xs-12">
                                <div class="widget-box table-filter">
                                    <div class="widget-header">
                                        <h2 class="widget-title">Tìm kiếm</h2>
                                        <div class="widget-toolbar">
                                            <a href="#" data-action="collapse">
                                                <i class="ace-icon fa fa-chevron-up"></i>
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
                                                                   type="text" data-date-format="dd-mm-yyyy" value="${model.fromDate}" name="fromDate"/>
                                                            <span class="input-group-addon">
                                                                <i class="fa fa-calendar bigger-110"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">Đến Ngày: </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-group">
                                                            <input class="form-control date-picker" id="toDate"
                                                                   type="text" data-date-format="dd-mm-yyyy" value="${model.toDate}" name="toDate"/>
                                                            <span class="input-group-addon">
                                                                <i class="fa fa-calendar bigger-110"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label"></label>
                                                    <div class="col-sm-8">
                                                        <button type="submit" class="btn btn-sm btn-success" id="btnSearch">
                                                            Tìm kiếm
                                                            <i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form:form>
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="row">
                    	<c:if test="${not empty total}">
							<div class="viewdoanhthu">
								<div class="groupdanhthu">
									<div class="doanhthutitle">DOANH THU</div>
									<div class="valuedanhthu">${total} VNĐ</div>
								</div>
							</div>
						</c:if>
                        <div class="col-xs-12">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>Tên sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Giá</th>
                                    <th>Tổng giá</th>
                                    <th>Ngày</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${reports}">
                                        <tr>
                                            <td>${item.name}</td>
                                            <td>${item.quantity}</td>
                                            <td>${item.price}</td>
                                            <td>${item.totalPrice} VNĐ</td>
                                            <td>${item.createdDate}</td>
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
<script type="text/javascript">

    $(document).ready(function () {

        //show datetime picker
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true
        }).next().on(ace.click_event, function(){
            $(this).prev().focus();
        });

    });

</script>
<style>
h2{
 color: #438eb9;
    font-size: 140%;
    font-weight: 700;
    text-align: center;
    text-transform: uppercase;
    margin: 0px;
    font-family: 'Open Sans';
}
.viewdoanhthu {
	width: 40%;
	height: 15.1em;
	border: 1px solid #007bff;
	border-radius: 0.3em;
	margin-left: 30%;
	margin-bottom: 10px;
	outline-style: none;
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
