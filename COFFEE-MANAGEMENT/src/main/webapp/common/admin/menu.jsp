<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pagina" value="${requestScope['javax.servlet.forward.request_uri']}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="sidebar"
	class="sidebar                  responsive                    ace-save-state">
	<script type="text/javascript">
        try{ace.settings.loadState('sidebar')}catch(e){}
    </script>
	<div class="sidebar-shortcuts" id="sidebar-shortcuts">
		<div class="sidebar-shortcuts-large">
			<button class="btn btn-success">
				<i class="ace-icon fa fa-signal"></i>
			</button>

			<button class="btn btn-info">
				<i class="ace-icon fa fa-pencil"></i>
			</button>

			<button class="btn btn-warning">
				<i class="ace-icon fa fa-users"></i>
			</button>

			<button class="btn btn-danger">
				<i class="ace-icon fa fa-cogs"></i>
			</button>
		</div>
		<div class="sidebar-shortcuts-mini">
			<span class="btn btn-success"></span> <span class="btn btn-info"></span>

			<span class="btn btn-warning"></span> <span class="btn btn-danger"></span>
		</div>
	</div>
	<ul class="nav nav-list " id="menu">
		<security:authorize ifAnyGranted="admin">
			<li class="${activeHome}"><a href="<c:url value="/admin/home"/>">
					<i class="menu-icon fa fa-tachometer"></i> <span class="menu-text"></span>
					Trang Chủ

			</a></li>

			<li class="${activeReport}"><a href="<c:url value="/admin/report/list" /> ">
					<i class="menu-icon fa fa-bar-chart"></i> <span class="menu-text"></span>
					Doanh Thu

			</a></li>
			<li class="${activeUsers}" ><a href="<c:url value="/admin/user/list"/>"> <i
					class="menu-icon fa fa-users"></i> <span class="menu-text"></span>
					Quản Lí Nhân Viên

			</a></li>
			<li class="${activeProduct} ${activeProductCategorie}"><a href="#" class="dropdown-toggle"> <i
					class="menu-icon fa fa-coffee"></i> <span class="menu-text"></span>
					Quản Lí Đồ Uống <b class="arrow fa fa-angle-down"></b>
			</a> <b class="arrow"></b>
				<ul class="submenu" >
					<li class="${activeProducts}"><a href="<c:url value="/admin/product/list"/>"> <i
							class="menu-icon fa fa-caret-right"></i> Đồ Uống
					</a> <b class="arrow"></b></li>
					<li class="${activeProductCategories}"> <a href="<c:url value="/admin/productcategory/list"/>">
							<i class="menu-icon fa fa-caret-right"></i> Loại Đồ Uống
					</a> <b class="arrow"></b></li>
				</ul></li>
			<li class="${activeTable} ${activeArea}"> <a href="#" class="dropdown-toggle"> <i
					class="menu-icon fa fa-anchor"></i> <span class="menu-text"></span>
					Quản Lí Tầng, Bàn <b class="arrow fa fa-angle-down"></b>
			</a> <b class="arrow"></b>
				<ul class="submenu">
					<li class="${activeTables}"><a href="<c:url value="/admin/table/list"/>"> <i
							class="menu-icon fa fa-caret-right"></i> Bàn
					</a> <b class="arrow"></b></li>
					<li class="${activeAreas}"><a href="<c:url value="/admin/area/list"/>"> <i
							class="menu-icon fa fa-caret-right"></i> Khu Vực
					</a> <b class="arrow"></b></li>

				</ul></li>
			<li><a href="#" class="dropdown-toggle"> <i
					class="menu-icon fa fa-cutlery"></i> <span class="menu-text"></span>
					Quản Lí Bếp, Bar

			</a></li>

			<li class="${activeTimekeeping}"><a
				href="<c:url value="/admin/report/timekeeping" /> "> <i
					class="menu-icon fa fa-calendar"></i> <span class="menu-text"></span>
					Bảng Chấm Công

			</a></li>

			<li class="${activeOrders}"><a href="/admin/order/table/list" /> <i
				class="menu-icon fa fa-paper-plane"></i> <span class="menu-text"></span>
				Bán Hàng </a></li>


		</security:authorize>
		<security:authorize ifAnyGranted="staff">
			<li class="${activeOrders}"><a href="/admin/order/table/list" /> <i
				class="menu-icon fa fa-paper-plane"></i> <span class="menu-text"></span>
				Bán Hàng </a></li>
			<li class="${activeTimekeeping}"><a
				href="<c:url value="/admin/report/timekeeping" /> "> <i
					class="menu-icon fa fa-calendar"></i> <span class="menu-text"></span>
					Bảng Chấm Công

			</a></li>
		</security:authorize>

	</ul>
	<div class="sidebar-toggle sidebar-collapse">
		<i class="ace-icon fa fa-angle-double-left ace-save-state"
			data-icon1="ace-icon fa fa-angle-double-left"
			data-icon2="ace-icon fa fa-angle-double-right"></i>
	</div>
<script type="text/javascript">
$(document).ready(function () {
    $('.menu ul li ul').find('li').click(function () {
        //removing the previous selected menu state
        $('.menu').find('li.active').removeClass('active');
        //adding the state for this parent menu
        $(this).parents('li').addClass('active');
    });
});
</script>

</div>