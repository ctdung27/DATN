<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="formUrl" value="/admin/product/list" />
<c:url var="productAPI" value="/api/product" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Danh sách sản phẩm</title>
</head>
<body>

	<div class="main-content">
		<%--<form:form commandName="model" action="${formUrl}" id="listForm" method="GET">--%>
		<div class="main-content-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<ul class="breadcrumb">
					<h2>
						ĐỒ UỐNG
						<h2>
				</ul>
				<!-- /.breadcrumb -->
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

							<div class="col-sm-4">
								<input type="text" id="myInput" onkeyup="myFunction()"
									placeholder="Tìm kiếm theo tên ...">
							</div>
							<div class="col-sm-8">
								<div class="table-btn-controls">
									<div class="pull-right tableTools-container">
										<div class="dt-buttons btn-overlap btn-group">
											<a flag="info"
												class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title="Thêm sản phẩm"
												href='<c:url value="/admin/product/edit"/>'> <span>
													<i class="fa fa-plus-circle bigger-110 purple"></i>
											</span>
											</a>
											<button id="btnDelete" type="button"
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title="Xóa sản phẩm"
												onclick="warningBeforeDelete()">
												<span> <i class="fa fa-trash-o bigger-110 pink"></i>
												</span>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>


						<div class="row">
							<div class="col-xs-12">
								<div>
									<table id="dynamic-table" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th class="center"><label class="pos-rel"> <input
														type="checkbox" class="ace" /> <span class="lbl"></span>
												</label></th>
												<th class="center">Tên Đồ Uống</th>
												<th class="center">Mã Đồ Uống</th>
												<th class="center hidden-480">Loại Đồ Uống</th>

												<th class="center">Giá</th>
												<th class="center hidden-480">Thao Tác</th>


											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${products}">
												<tr>
													<td style="text-align: center"><label class="pos-rel">
															<input type="checkbox" class="ace" name="checkList"
															value="${item.id}" id="checkbox_${item.id}" /> <span
															class="lbl"></span>
													</label></td>
													<td style="text-align: center">${item.name}</td>
													<td style="text-align: center">${item.code}</td>
													<td style="text-align: center">${item.getProductCategoryCode()}</td>
													<td style="text-align: center">${item.price}VNĐ</td>
													<td style="text-align: center"><c:url
															var="editProduct" value="/admin/product/edit">
															<c:param name="id" value="${item.id}" />
														</c:url> <a class="btn btn-sm btn-primary btn-edit"
														data-toggle="tooltip" title="Cập nhật sản phẩm"
														href='${editProduct}'><i class="fa fa-pencil-square-o"
															aria-hidden="true"></i> <span class="menu-text"></span>
															Cập nhật</a></td>
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
		<%--</form:form>--%>
	</div>
	
	<script type="text/javascript">

	//initiate dataTables plugin
	var myTable = 
	$('#dynamic-table')
	//.wrap("<div class='dataTables_borderWrap' />")   //if you are applying horizontal scrolling (sScrollX)
	.DataTable( {
		bAutoWidth: false,
		"aoColumns": [
		  { "bSortable": false },
		  null, null,null, null, null,
		  { "bSortable": false }
		],
		"aaSorting": [],
		
		
		//"bProcessing": true,
        //"bServerSide": true,
        //"sAjaxSource": "http://127.0.0.1/table.php"	,

		//,
		//"sScrollY": "200px",
		//"bPaginate": false,

		//"sScrollX": "100%",
		//"sScrollXInner": "120%",
		//"bScrollCollapse": true,
		//Note: if you are applying horizontal scrolling (sScrollX) on a ".table-bordered"
		//you may want to wrap the table inside a "div.dataTables_borderWrap" element

		//"iDisplayLength": 50


		select: {
			style: 'multi'
		}
    } );

	
	
	$.fn.dataTable.Buttons.defaults.dom.container.className = 'dt-buttons btn-overlap btn-group btn-overlap';
	
	new $.fn.dataTable.Buttons( myTable, {
		buttons: [
		  {
			"extend": "colvis",
			"text": "<i class='fa fa-search bigger-110 blue'></i> <span class='hidden'>Show/hide columns</span>",
			"className": "btn btn-white btn-primary btn-bold",
			columns: ':not(:first):not(:last)'
		  },
		  {
			"extend": "copy",
			"text": "<i class='fa fa-copy bigger-110 pink'></i> <span class='hidden'>Copy to clipboard</span>",
			"className": "btn btn-white btn-primary btn-bold"
		  },
		  {
			"extend": "csv",
			"text": "<i class='fa fa-database bigger-110 orange'></i> <span class='hidden'>Export to CSV</span>",
			"className": "btn btn-white btn-primary btn-bold"
		  },
		  {
			"extend": "excel",
			"text": "<i class='fa fa-file-excel-o bigger-110 green'></i> <span class='hidden'>Export to Excel</span>",
			"className": "btn btn-white btn-primary btn-bold"
		  },
		  {
			"extend": "pdf",
			"text": "<i class='fa fa-file-pdf-o bigger-110 red'></i> <span class='hidden'>Export to PDF</span>",
			"className": "btn btn-white btn-primary btn-bold"
		  },
		  {
			"extend": "print",
			"text": "<i class='fa fa-print bigger-110 grey'></i> <span class='hidden'>Print</span>",
			"className": "btn btn-white btn-primary btn-bold",
			autoPrint: false,
			message: 'This print was produced using the Print button for DataTables'
		  }		  
		]
	} );
	myTable.buttons().container().appendTo( $('.tableTools-container') );
	
	//style the message box
	var defaultCopyAction = myTable.button(1).action();
	myTable.button(1).action(function (e, dt, button, config) {
		defaultCopyAction(e, dt, button, config);
		$('.dt-button-info').addClass('gritter-item-wrapper gritter-info gritter-center white');
	});
	
	
	var defaultColvisAction = myTable.button(0).action();
	myTable.button(0).action(function (e, dt, button, config) {
		
		defaultColvisAction(e, dt, button, config);
		
		
		if($('.dt-button-collection > .dropdown-menu').length == 0) {
			$('.dt-button-collection')
			.wrapInner('<ul class="dropdown-menu dropdown-light dropdown-caret dropdown-caret" />')
			.find('a').attr('href', '#').wrap("<li />")
		}
		$('.dt-button-collection').appendTo('.tableTools-container .dt-buttons')
	});

	////

	setTimeout(function() {
		$($('.tableTools-container')).find('a.dt-button').each(function() {
			var div = $(this).find(' > div').first();
			if(div.length == 1) div.tooltip({container: 'body', title: div.parent().text()});
			else $(this).tooltip({container: 'body', title: $(this).text()});
		});
	}, 500);
	
	
	
	
	
	myTable.on( 'select', function ( e, dt, type, index ) {
		if ( type === 'row' ) {
			$( myTable.row( index ).node() ).find('input:checkbox').prop('checked', true);
		}
	} );
	myTable.on( 'deselect', function ( e, dt, type, index ) {
		if ( type === 'row' ) {
			$( myTable.row( index ).node() ).find('input:checkbox').prop('checked', false);
		}
	} );




	/////////////////////////////////
	//table checkboxes
	$('th input[type=checkbox], td input[type=checkbox]').prop('checked', false);
	
	//select/deselect all rows according to table header checkbox
	$('#dynamic-table > thead > tr > th input[type=checkbox], #dynamic-table_wrapper input[type=checkbox]').eq(0).on('click', function(){
		var th_checked = this.checked;//checkbox inside "TH" table header
		
		$('#dynamic-table').find('tbody > tr').each(function(){
			var row = this;
			if(th_checked) myTable.row(row).select();
			else  myTable.row(row).deselect();
		});
	});
	
	//select/deselect a row when the checkbox is checked/unchecked
	$('#dynamic-table').on('click', 'td input[type=checkbox]' , function(){
		var row = $(this).closest('tr').get(0);
		if(this.checked) myTable.row(row).deselect();
		else myTable.row(row).select();
	});



	$(document).on('click', '#dynamic-table .dropdown-toggle', function(e) {
		e.stopImmediatePropagation();
		e.stopPropagation();
		e.preventDefault();
	});
	
	
	
	
	
		$(document).ready(function() {
		$('#myInput').on('keyup',function(event) {event.preventDefault();
		var tukhoa = $(this).val().toLowerCase();
		$('#myTable tr').filter(function() {
			$(this).toggle($(this).text().toLowerCase().indexOf(tukhoa) > -1);
	});
});
});
		function warningBeforeDelete() {
			showAlertBeforeDelete(function() {
				event.preventDefault();
				var dataArray = $(' tbody input[type=checkbox]:checked').map(
						function() {
							return $(this).val();
						}).get();
				deleteProduct(dataArray);
			});
		}

		function deleteProduct(data) {
			$
					.ajax({
						url : '${productAPI}',
						type : 'DELETE',
						contentType : 'application/json',
						data : JSON.stringify(data),
						success : function(res) {
							window.location.href = "<c:url value='/admin/product/list?message=delete_success'/>";
						},
						error : function(res) {
							console.log(res);
							window.location.href = "<c:url value='/admin/product/list?message=error_system'/>";
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
