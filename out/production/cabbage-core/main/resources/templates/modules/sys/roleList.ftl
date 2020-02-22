<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.role.management"></@spring.message></title>
	<script type="text/javascript">
	    function deleteThis(uuid){
	    	 top.jBox.confirm('<@spring.message code="core.role.doYouWantToDeleteThisRole"></@spring.message>？', '<@spring.message code="core.prompt"></@spring.message>', function (v, h, f) {
	            if (v === 'ok') {
	                  window.location.href="${ctx}/sys/role/delete?id="+uuid;
	            }
	            return true;
 			 });
	    }
	</script>
</head>
<body>

	<div class="page-container-custom">
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
                    <span><@spring.message code="core.role.management"></@spring.message></span>
                </li>
            </ul>
        </div>
        
        <div class="portlet light portlet-fit portlet-datatable ">
	       <ul class="nav nav-tabs mb-25">
	            <li class="active">
	                <a data-toggle="tab" href="javascript:;"><@spring.message code="core.role.list"></@spring.message> </a>
	            </li>
                <@shiro.hasPermission name="sys:role:edit">
	            <li class="">
					<a href="${ctx}/sys/role/form"><@spring.message code="core.add"></@spring.message></a>
	            </li>
                </@shiro.hasPermission>
	        </ul>
            
	        <div class="portlet-body">
	            <div id="sample_4_wrapper" class="dataTables_wrapper">
				<@tags.message content=message! />
                <div class="table-scrollable">
				<table id="contentTable" class="table table-striped table-bordered table-hover table-checkable order-column dataTable">
					<tr>
						<th><@spring.message code="core.role.name"></@spring.message></th>
						<th><@spring.message code="core.role.roleIdentification"></@spring.message></th>
						<th><@spring.message code="core.role.ownershipOrganization"></@spring.message></th>
<!-- 						<th>数据范围</th>
						<th>角色类型</th>
						<th><@spring.message code="core.yes"></@spring.message>否系统数据</th> -->
						<th><@spring.message code="core.role.isItAvailable"></@spring.message></th>
						<@shiro.hasPermission name="sys:role:edit"><th><@spring.message code="core.operation"></@spring.message></th></@shiro.hasPermission>
					</tr>
					<#list list as role>
						<tr>
							<td><a href="form?id=${role.id}">${role.name!}</a></td>
							<td>${role.code!}</td>
							<td>${role.officeName!}</td>
							<!-- <td>
								${fns.getDictLabel(role.dataScope, 'sys_data_scope', '无')}
							</td>
							<td>
								<#if role.roleType??>
									<#if role.roleType==1>
									<@spring.message code="core.role.commonRole"></@spring.message>
									<#elseif role.roleType==2>
									<@spring.message code="core.role.managementRole"></@spring.message>
									<#elseif role.roleType==3>
									<@spring.message code="core.role.taskAllocation"></@spring.message>
									</#if>
								</#if>
							</td>
							<td>
								<#if role.isSys??>
									<#if role.isSys==1>
									<@spring.message code="core.yes"></@spring.message>
									<#elseif role.isSys==0>
									<@spring.message code="core.no"></@spring.message>
									</#if>
								</#if>
							</td> -->
							<td>
								<#if role.useable??>
									<#if role.useable==1>
									<@spring.message code="core.yes"></@spring.message>
									<#elseif role.useable==0>
									<@spring.message code="core.no"></@spring.message>
									</#if>
								</#if>
							</td>
							<@shiro.hasPermission name="sys:role:edit">
							<td>
								<a href="${ctx}/sys/role/form?id=${role.id}"><@spring.message code="core.modify"></@spring.message></a>
								<a onclick="deleteThis(${role.id!})"><@spring.message code="core.delete"></@spring.message></a>
							</td>
							</@shiro.hasPermission>	
						</tr>
					</#list>
				</table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>