<#include "/include/taglib.ftl" >
<html>
<head>
	<title></title>
	<#include "/include/treetable.ftl" >
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	    
	    function deleteOrg(uid){
	    	 top.jBox.confirm('<@spring.message code="core.office.doYouWantToMakeSureThatYouWantToDeleteTheAgencyAndAllTheSubAgencyTtems"></@spring.message>？', '<@spring.message code="core.prompt"></@spring.message>', function (v, h, f) {
	            if (v === 'ok') {
	                  window.location.href="${ctx}/sys/office/delete?id="+uid;
	            }
	            return true;
 			 });
	    }
	</script>
</head>
<body>
	<div class="page-container-custom">
	<#-- 
        <div class="page-bar">
            <ul class="page-breadcrumb">
                <li>
                    <i class="icon-home"></i>
                    <a target="_parent" href="${ctx}"><@spring.message code="core.home"></@spring.message></a>
                    <i class="fa fa-angle-right"></i>
                </li>
                <li>
				    <span><@spring.message code="core.systemSetup"></@spring.message><i class="fa fa-angle-right"></i></span>
				</li>
                <li>
                    <span><@spring.message code="core.office.organizationalManagement"></@spring.message></span>
                </li>
            </ul>
        </div>
	 -->
         <div class="portlet light portlet-fit portlet-datatable ">
         	 <ul class="nav nav-tabs mb-25">
            <li class="active">
                <a data-toggle="tab" href="javascript:;">
             <@spring.message code="core.office.organizationalManagement"></@spring.message></a>
            </li>
            <@shiro.hasPermission name="sys:office:edit">
            <li class="">
                <a  href="${ctx}/sys/office/form">
             <@spring.message code="core.add"></@spring.message> </a>
            </li>
            </@shiro.hasPermission>
        	</ul>
			<div class="portlet-body">
		            <div id="sample_4_wrapper" class="dataTables_wrapper">
		            	<@tags.message content=message! />
		                <div class="table-scrollable">
							<table id="treeTable" class="table table-striped table-bordered table-hover table-checkable order-column dataTable">
								<tr>
								<th><@spring.message code="core.office.org.name"></@spring.message></th>
								<th><@spring.message code="core.office.attributionArea"></@spring.message></th>
								<th><@spring.message code="core.office.org.code"></@spring.message></th>
								<th><@spring.message code="core.office.org.type"></@spring.message></th>
								<th><@spring.message code="core.user.remarks"></@spring.message></th>
								<@shiro.hasPermission name="sys:office:edit">
								<th><@spring.message code="core.operation"></@spring.message></th></@shiro.hasPermission>
								</tr>
								<#list list as item>
									<tr id="${item.id}" pId="${(item.parentId != office.id)?string(item.parentId,'0')}">
										<td><a href="${ctx}/sys/office/form?id=${item.id}">${item.name}</a></td>
										<td>
											${fns.getDictFullLabel(item.areaId,'vc.thinker.sys.bo.DicAreaBO',' ')}
										</td>
										<td>${item.code}</td>
										<td>${fns.getDictLabel(item.type, 'sys_office_type', '无')}</td>
										<td>${item.remarks}</td>
										<@shiro.hasPermission name="sys:office:edit"><td>
											<a href="${ctx}/sys/office/form?id=${item.id}"><@spring.message code="core.modify"></@spring.message></a>
											<a  onclick="deleteOrg(${item.id})"><@spring.message code="core.delete"></@spring.message></a>
											<a href="${ctx}/sys/office/form?parentId=${item.id}"><@spring.message code="core.office.addingLowerLevelMechanism"></@spring.message></a>
										</td></@shiro.hasPermission>
									</tr>
								</#list>
							</table>
						</div>
					</div>
			</div>
		</div>
	</div>
</body>
</html>