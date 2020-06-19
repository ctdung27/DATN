<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="formUrl" value="/admin/user/list"/>
<c:url var="userAPI" value="/api/admin/user"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách tài khoản</title>
</head>
<body class="no-skin">
<div class="main-content">
 
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <ul class="breadcrumb">
                    <h2>Danh sách tài khoản<h2>
                </ul><!-- /.breadcrumb -->
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
                        <!-- PAGE CONTENT BEGINS -->
                         <div class="row">
                            <div class="col-xs-12">
                                <div class="table-btn-controls">
                                    <div class="pull-right tableTools-container">
                                        <div class="dt-buttons btn-overlap btn-group">
                                            <a flag="info" class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
                                               data-toggle="tooltip" title="Thêm tài khoản mới" href='<c:url value="/admin/user/edit"/>'>
                                                    <span>
                                                    <i class="fa fa-plus-circle bigger-110 purple"></i>
                                                </span>
                                            </a>
                                            <button id="btnDelete" type="button" class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
                                                    data-toggle="tooltip" title="Xóa tài khoản" onclick="warningBeforeDelete()">
                                                    <span>
                                                    <i class="fa fa-trash-o bigger-110 pink"></i>
                                                	</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
							<div class="col-xs-12">
								<table id="simple-table"
									class="table  table-bordered table-hover">
									<thead>
										<tr>
											<th class="center"><label class="pos-rel"> <input
													type="checkbox" class="ace" /> <span class="lbl"></span>
											</label></th>
											<th class="detail-col" style="width: 68px;">Chi Tiết</th>
											<th>Tên Tài Khoản</th>
											<th>Họ Tên</th>
											<th>Số Điện Thoại</th>
		


											<th>Cập Nhật</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="item" items="${users}">
											<tr>
												<td class="center">
													<label class="pos-rel">
															<input type="checkbox" class="ace" type="checkbox" name="checkList" value="${item.id}" id="checkbox_${item.id}"/>
															<span class="lbl"></span>
														</label>
													
												</td>
												<td class="center">
													<div class="action-buttons">
															<a href="#" class="green bigger-140 show-details-btn" title="Show Details">
																<i class="ace-icon fa fa-angle-double-down"></i>
																<span class="sr-only">Details</span>
															</a>
														</div>
												</td>
												<td>${item.userName}</td>
												<td>${item.fullName}</td>
												<td>${item.sdienthoai}</td>
												
												
												<td><c:url var="editUser" value="/admin/user/edit">
														<c:param name="id" value="${item.id}" />
													</c:url> <a class="btn btn-sm btn-primary btn-edit"
													data-toggle="tooltip" title="Cập nhật tài khoản"
													href='${editUser}'><i class="fa fa-pencil-square-o"
														aria-hidden="true"></i><span class="menu-text"></span>
															Cập nhật </a></td>
											</tr>
											<tr class="detail-row">
													<td colspan="8">
														<div class="table-detail">
															<div class="row">
																<div class="col-xs-12 col-sm-2">
																	<div class="text-center">
																		<img height="150" class="thumbnail inline no-margin-bottom" alt=" aAvatar3" src="/template/admin/assets/avatars/profile-pic.jpg" />
																		<br />
																		<div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
																			<div class="inline position-relative">
																				<a class="user-title-label" href="#">
																					<i class="ace-icon fa fa-circle light-green"></i>
																					&nbsp;
																					<span class="white">${item.fullName}</span>
																				</a>
																			</div>
																		</div>
																	</div>
																</div>

																<div class="col-xs-12 col-sm-7">
																	<div class="space visible-xs"></div>

																	<div class="profile-user-info profile-user-info-striped">
																		<div class="profile-info-row">
																			<div class="profile-info-name"> Username </div>

																			<div class="profile-info-value">
																				<span>${item.userName}</span>
																			</div>
																		</div>

																		<div class="profile-info-row">
																			<div class="profile-info-name">Họ tên </div>

																			<div class="profile-info-value">
																				
																				<span>${item.fullName}</span>
																			</div>
																		</div>

																		<div class="profile-info-row">
																			<div class="profile-info-name">Số điện thoại </div>

																			<div class="profile-info-value">
																				<span>${item.sdienthoai}</span>
																			</div>
																		</div>

																		

																		<div class="profile-info-row">
																			<div class="profile-info-name"> Email </div>

																			<div class="profile-info-value">
																				<span>${item.email}</span>
																			</div>
																		</div>

																		<div class="profile-info-row">
																			<div class="profile-info-name"> Địa Chỉ </div>

																			<div class="profile-info-value">
																				<span>${item.diachi}</span>
																			</div>
																		</div>
																	</div>
																</div>

																<div class="col-xs-12 col-sm-3">
																	<div class="space visible-xs"></div>
																	<h4 class="header blue lighter less-margin">Send a message to Alex</h4>

																	<div class="space-6"></div>

																	<form>
																		<fieldset>
																			<textarea class="width-100" resize="none" placeholder="Type something…"></textarea>
																		</fieldset>

																		<div class="hr hr-dotted"></div>

																		<div class="clearfix">
																			<label class="pull-left">
																				<input type="checkbox" class="ace" />
																				<span class="lbl"> Email me a copy</span>
																			</label>

																			<button class="pull-right btn btn-sm btn-primary btn-white btn-round" type="button">
																				Submit
																				<i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
																			</button>
																		</div>
																	</form>
																</div>
															</div>
														</div>
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

<script type="text/javascript">
    $(document).ready(function () {

    });
    
    
    
	

	var active_class = 'active';
	$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
		var th_checked = this.checked;//checkbox inside "TH" table header
		
		$(this).closest('table').find('tbody > tr').each(function(){
			var row = this;
			if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
			else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
		});
	});
	
	$('#simple-table').on('click', 'td input[type=checkbox]' , function(){
		var $row = $(this).closest('tr');
		if($row.is('.detail-row ')) return;
		if(this.checked) $row.addClass(active_class);
		else $row.removeClass(active_class);
	});
				/***************/
				$('.show-details-btn').on('click', function(e) {
					e.preventDefault();
					$(this).closest('tr').next().toggleClass('open');
					$(this).find(ace.vars['.icon']).toggleClass('fa-angle-double-down').toggleClass('fa-angle-double-up');
				});
				/***************/

	//table checkboxes
	$('th input[type=checkbox], td input[type=checkbox]').prop('checked', false);
	/***************/
	//select/deselect a row when the checkbox is checked/unchecked
	$('#simple-table').on('click', 'td input[type=checkbox]', function() {
		var $row = $(this).closest('tr');
		if ($row.is('.detail-row '))
			return;

		if (this.checked)
			$row.addClass(active_class);
		else
			$row.removeClass(active_class);
	});

	
	
	
	
	
	
	
	function warningBeforeDelete() {
		showAlertBeforeDelete(function() {
			event.preventDefault();
			var dataArray = $(' tbody input[type=checkbox]:checked').map(
					function() {
						return $(this).val();
					}).get();
			deleteUser(dataArray);
		});
	}

	function deleteUser(data) {
		$
				.ajax({
					url : '${userAPI}',
					type : 'DELETE',
					contentType : 'application/json',
					data : JSON.stringify(data),
					success : function(res) {
						window.location.href = "<c:url value='/admin/user/list?message=delete_success'/>";
					},
					error : function(res) {
						console.log(res);
						window.location.href = "<c:url value='/admin/user/list?message=error_system'/>";
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
