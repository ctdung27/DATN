<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="sidebar" class="sidebar                  responsive                    ace-save-state">
      <script type="text/javascript">
        try{ace.settings.loadState('sidebar')}catch(e){}
    </script>
    <div class="sidebar-shortcuts">
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
            <span class="btn btn-success"></span>

            <span class="btn btn-info"></span>

            <span class="btn btn-warning"></span>

            <span class="btn btn-danger"></span>
        </div>
    </div>
     <ul class="nav nav-list">
	    <security:authorize ifAnyGranted="admin">
	    	
	    	 
		    <li >
	            <a href="<c:url value="/admin/report/list"/>" >
	                <i class="menu-icon fa fa-bar-chart"></i>
	                <span class="menu-text"></span>
	                Doanh Thu
	               
	            </a>
	            
	        </li>
            <li >
                <a href="<c:url value="/admin/user/list"/>" >
                    <i class="menu-icon fa fa-users"></i>
                    <span class="menu-text"></span>
                    Quản lí nhân viên
                    
                </a>
               
            </li>
            <li >
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-coffee"></i>
                    <span class="menu-text"></span>
                    Đồ uống
                    <b class="arrow fa fa-angle-down"></b>
                </a>
                <b class="arrow"></b>
                <ul class="submenu">
                    <li>
                        <a href="<c:url value="/admin/product/list"/>">
                            <i class="menu-icon fa fa-caret-right"></i>
                            DS sản phẩm
                        </a>
                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>
            <li >
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-anchor"></i>
                    <span class="menu-text"></span>
                    Quản lí tầng, bàn
                    <b class="arrow fa fa-angle-down"></b>
                </a>
                <b class="arrow"></b>
                <ul class="submenu">
                    <li>
                        <a href="<c:url value="/admin/table/list"/>">
                            <i class="menu-icon fa fa-caret-right"></i>
                            DS bàn
                        </a>
                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>
            <li >
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-cutlery"></i>
                    <span class="menu-text"></span>
                    Quản lí bếp, bar
                    
                </a>
                
            </li>
            <li >
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-money"></i>
                    <span class="menu-text"></span>
                    Quản lí hóa đơn
                    
                </a>
                
            </li>
	    </security:authorize>
         <security:authorize ifAnyGranted="admin,staff">
             <li >
                 <a href="/admin/order/table/list"/> 
                     <i class="menu-icon fa fa-paper-plane"></i>
                     <span class="menu-text"></span>
                     Bán Hàng
                     
                 </a>
                 
             </li>
         </security:authorize>
    </ul>
    <div class="sidebar-toggle sidebar-collapse">
        <i class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
    </div>
</div>