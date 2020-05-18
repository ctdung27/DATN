<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="formUrl" value="/api/table"/>
<html>
<head>
    <title>Chi tiết bàn</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            
            <ul class="breadcrumb">
                
                <h2>Chỉnh sửa bàn</h2>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
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
                            <label class="col-sm-3 control-label no-padding-right">Tên bàn</label>
                            <div class="col-sm-9">
                                <form:input path="name" id="name" cssClass="form-control"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Mã bàn</label>
                            <div class="col-sm-9">
                                <form:input path="code" id="code" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <c:if test="${not empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold" value="Cập nhật bàn" id="btnAddOrUpdateTable"/>
                                </c:if>
                                <c:if test="${empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold" value="Thêm mới bàn" id="btnAddOrUpdateTable"/>
                                </c:if>
                            </div>
                        </div>
                        <form:hidden path="id" id="tableId"/>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
    });

    $('#btnAddOrUpdateTable').click(function (event) {
        event.preventDefault();
        var data = {};
        var formData = $('#formEdit').serializeArray();
        $.each(formData, function (i,v) {
            data["" + v.name + ""] = v.value;
        });
        var id = $('#tableId').val();
        if (id == "") {
            addTable(data);
        } else {
            updateTable(data);
        }
    });

    function addTable(data) {
        $.ajax({
            url: '${formUrl}',
            type: 'POST',
            dataType: 'json',
            contentType:'application/json',
            data: JSON.stringify(data),
            success: function(res) {
                window.location.href = "<c:url value='/admin/table/edit?id="+res.id+"&message=insert_success'/>";
            },
            error: function(res) {
                window.location.href = "<c:url value='/admin/table/edit?id="+res.id+"&message=error_system'/>";
            }
        });
    }

    function updateTable(data) {
        $.ajax({
            url: '${formUrl}',
            type: 'PUT',
            dataType: 'json',
            contentType:'application/json',
            data: JSON.stringify(data),
            success: function(res) {
                window.location.href = "<c:url value='/admin/table/edit?id="+res.id+"&message=update_success'/>";
            },
            error: function(res) {
                window.location.href = "<c:url value='/admin/table/edit?id="+res.id+"&message=error_system'/>";
            }
        });
    }
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
</style>
</body>
</html>
