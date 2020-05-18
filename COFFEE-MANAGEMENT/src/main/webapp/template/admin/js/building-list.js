	function assingmentBuilding(buildingId) {
		openModalAssingmentBuilding();
		$('#buildingId').val(buildingId);
		console.log($('#buildingId').val());
		//call api load staff list
		showStaffAssignment();
	}
	
	function openModalAssingmentBuilding() {
		$('#assingmentBuildingModal').modal();
	}
	
	$('#btnAssignBuilding').click(function (e) { 
		e.preventDefault();
		var data = {};
		data['buildingId'] = $('#buildingId').val();
		var staffs = $('#staffList').find('tbody input[type=checkbox]:checked').map(function () {
			return $(this).val();
		}).get();
		data['staffs'] = staffs;
		assignStaff(data);
	});
	
	function assignStaff(data) {
		$.ajax({
	       type: "POST",
	       url: "http://localhost:8080/api-user-assignment",
	       data: JSON.stringify(data),
	       dataType: "json",
	       contentType: "application/json",
	       success: function (response) {
	           console.log('success');
	       },
	       error: function (response) {
	           console.log('failed');
	           console.log(response);
	       }
	   });
	}
	
	function showStaffAssignment(url) {
		$.ajax({
	       type: "GET",
	       url: "http://localhost:8080/api-user?type=SHOW_STAFF_ASSIGNMENT",
	       dataType: "json",
	       success: function (response) {
			   var html = '';
			   $.each(response, function (index, staffOutput) { 
					html += '<tr>';
					html += '<td><input type="checkbox" value="'+staffOutput.staffId+'" id="checkbox_'+staffOutput.staffId+'" '+staffOutput.checked+'/></td>';
					html += '<td>'+staffOutput.fullName+'</td>';
					html += '</tr>'; 
			   });
	    	   $('#staffList tbody').html(html);
	       },
	       error: function (response) {
	           console.log('failed');
	           console.log(response);
	       }
	   });
	}
	
	$('#btnDeleteBuilding').click(function (e) { 
		e.preventDefault();
		var data = {};
		var buildingIds = $('#buildingList').find('tbody input[type=checkbox]:checked').map(function () {
			return $(this).val();
		}).get();
		data['buildingIds'] = buildingIds;
		deleteBuilding(data);
	});
	
	function deleteBuilding(data) {
		$.ajax({
	       type: "DELETE",
	       url: "http://localhost:8080/api-building",
	       data: JSON.stringify(data),
	       dataType: "json",
	       contentType: "application/json",
	       success: function (response) {
	           console.log('success');
	       },
	       error: function (response) {
	           console.log('failed');
	           console.log(response);
	       }
	   });
	}

	$('#btnSearchBuilding').click(function (e) { 
		e.preventDefault();
		$('#formSearchBuilding').submit();
	});