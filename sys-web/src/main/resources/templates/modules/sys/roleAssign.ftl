<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.role.distributionRole"></@spring.message></title>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/role/"><@spring.message code="core.role.list"></@spring.message></a></li>
		<li class="active"><a href="${ctx}/sys/role/assign?id=${role.id!}"><@shiro.hasPermission name="sys:role:edit"><@spring.message code="core.role.roleAssignment"></@spring.message></@shiro.hasPermission><@shiro.lacksPermission name="sys:role:edit"><@spring.message code="core.role.staffList"></@spring.message></@shiro.lacksPermission></a></li>
	</ul>
	<div class="container-fluid breadcrumb">
		<div class="row-fluid span12">
			<span class="span4"><@spring.message code="core.role.name"></@spring.message>: <b>${role.name}</b></span>
		</div>
	</div>
	<@tags.message content=message! />
	<div class="breadcrumb">
		<form id="assignRoleForm" action="" method="post" class="hide"></form>
		<a id="assignButton" href="javascript:" class="btn btn-primary"><@spring.message code="core.role.distributionRole"></@spring.message></a>
		<script type="text/javascript">
			$("#assignButton").click(function(){
				top.$.jBox.open("iframe:${ctx}/sys/role/usertorole?id=${role.id}", "<@spring.message code="core.role.distributionRole"></@spring.message>",810,$(top.document).height()-240,{
					buttons:{"<@spring.message code="core.role.determineAllocation"></@spring.message>":"ok", "<@spring.message code="core.role.scavenging"></@spring.message>":"clear", "<@spring.message code="core.close"></@spring.message>":true}, bottomText:"<@spring.message code="core.role.bySelectingDepartmentsAssigningRolesToTheListedPersonnel"></@spring.message>。",submit:function(v, h, f){
						var pre_ids = h.find("iframe")[0].contentWindow.pre_ids;
						var ids = h.find("iframe")[0].contentWindow.ids;
						//nodes = selectedTree.getSelectedNodes();
						if (v=="ok"){
							// 删除''的元素
							if(ids[0]==''){
								ids.shift();
								pre_ids.shift();
							}
							if(pre_ids.sort().toString() == ids.sort().toString()){
								top.$.jBox.tip("<@spring.message code="core.role.notGiven"></@spring.message>【${role.name}】<@spring.message code="core.role.newMembers"></@spring.message>！", 'info');
								return false;
							};
					    	// 执行保存
					    	loading('<@spring.message code="core.itIsBeingSubmittedPleaseWaitAMoment"></@spring.message>...');
					    	var idsArr = "";
					    	for (var i = 0; i<ids.length; i++) {
					    		idsArr = (idsArr + ids[i]) + (((i + 1)== ids.length) ? '':',');
					    	}
					    	$('#assignRoleForm').attr('action','${ctx}/sys/role/assignrole?id=${role.id}&idsArr='+idsArr).submit();
					    	return true;
						} else if (v=="clear"){
							h.find("iframe")[0].contentWindow.clearAssign();
							return false;
		                }
					}, loaded:function(h){
						$(".jbox-content", top.document).css("overflow-y","hidden");
					}
				});
			});
		</script>
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th><@spring.message code="core.user.ownershipCompany"></@spring.message></th><th><@spring.message code="core.user.belongingDepartment"></@spring.message></th><th><@spring.message code="core.user.loginName"></@spring.message></th><@shiro.hasPermission name="sys:user:edit"><th><@spring.message code="core.operation"></@spring.message></th></@shiro.hasPermission></tr></thead>
		<tbody>
		<#list  users as user>
			<tr>
				<td>${((user.company.name))!}</td>
				<td>${((user.office.name))!}</td>
				<td><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
				<@shiro.hasPermission name="sys:role:edit"><td>
					<a href="${ctx}/sys/role/outrole?userId=${user.id}&roleId=${role.id}" 
						onclick="return confirmx('<@spring.message code="core.role.confirmToTheUser"></@spring.message><b>[${user.loginName!}]</b><@spring.message code="core.role.follow"></@spring.message><b>[${role.name!}]</b><@spring.message code="core.role.isTheRoleRemoved"></@spring.message>？', this.href)"><@spring.message code="core.remove"></@spring.message></a>
				</td></@shiro.hasPermission>
			</tr>
		</#list>
		</tbody>
	</table>
</body>
</html>
