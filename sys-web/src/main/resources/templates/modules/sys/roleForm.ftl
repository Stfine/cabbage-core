<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.role.management"></@spring.message></title>
	<script type="text/javascript">
		$(document).ready(function(){
				
			<#if role?? && role.permissionIds?? && role.permissionIds!="">
			var permIds = "${role.permissionIds!}".split(",");
			for(var i=0; i<permIds.length; i++) {
				if(permIds[i] != ""){
					$("#permName_"+permIds[i]).prop("checked",true);
				}
			}
			<#list permissionGroupNameList as g>
				parentCheck(${g_index});
			</#list>
			</#if>
			
			$("input[id^='permName_']").change(function(){
				var pid = $(this).attr("pid");
				var pidNum = pid.split("_")[1];
				if(pidNum!="")
					parentCheck(pidNum);
			});
			
			$("input[id^='groupName_']").change(function(){
	 			var id = $(this).attr("id");
	 			var idNum = id.split("_")[1];
	 			if($(this).prop("checked")){
	 				$("#groupDiv_"+idNum).find("input[id^='permName_']").each(function(){
	 					$(this).prop("checked",true);
	 				});
	 			}else{
	 				$("#groupDiv_"+idNum).find("input[id^='permName_']").each(function(){
	 					$(this).prop("checked",false);
	 				});
	 			}
	 		});
		
			$("#name").focus();
			$("#inputForm").validate({
				rules: {
					name: {remote: "${ctx}/sys/role/checkName?id=${role.id!}"}
				},
				messages: {
					name: {remote: "<@spring.message code="core.role.theRoleNameHasAlreadyExisted"></@spring.message>"}
				},
				submitHandler: function(form){
				 	var ids = "";
		 			$("input[id^='permName_']").each(function(){
		 				if($(this).prop("checked")){
		 					ids += $(this).val();
		 					ids += ",";
		 				}
		 			});
					$("#permissionIds").val(ids);
					loading('<@spring.message code="core.itIsBeingSubmittedPleaseWaitAMoment"></@spring.message>...');
					form.submit();
				}
			});
		});
 		
 		function parentCheck(id){
 			if(id!=""){
	 			var count = $("#permDiv_"+id).find("input:checkbox").length;
				var checkFlag = 0;
				$("#permDiv_"+id).find("input:checkbox").each(function(){
					if($(this).prop('checked')){
						checkFlag += 1;
					}
				});
				if(checkFlag==count){
					$("#groupName_"+id).prop("checked",true);
				}else{
					$("#groupName_"+id).prop("checked",false);
				}
 			}
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
                    <span><@spring.message code="core.role.management"></@spring.message><i class="fa fa-angle-right"></i></span>
                </li>
                <li>
                    <span>
                    <@shiro.hasPermission name="sys:role:edit">
					 	<#if role.id??>
							<@spring.message code="core.modify"></@spring.message>
						<#else >
							<@spring.message code="core.add"></@spring.message>
						</#if>
                    </@shiro.hasPermission>
                    </span>
                </li>
            </ul>
        </div>
        <div class="portlet light ">
	       <ul class="nav nav-tabs mb-25">
	            <li >
	                <a  href="${ctx}/sys/role/list"><@spring.message code="core.role.list"></@spring.message> </a>
	            </li>
	            <li class="active">
					<a data-toggle="tab" href="${ctx}/sys/role/form">
						<#if role.id??>
							<@spring.message code="core.modify"></@spring.message>
						<#else>
							<@spring.message code="core.add"></@spring.message>
						</#if>
					</a>
	            </li>
	        </ul>
            <div class="portlet-body form">
			<@form.form id="inputForm" modelAttribute="role" action="${ctx}/sys/role/save" method="post" class="form-horizontal">
				<@form.hidden path="id"/>
				<@tags.message content=message! />
				 <div class="form-body">
				 
				 	<div class="form-group">
						<label class="col-md-3 control-label"><@spring.message code="core.role.ownershipOrganization"></@spring.message>:</label>
						<div class="col-md-4">
			                <@tags.treeselect id="office" name="officeId" value=(role.office.id)! labelName="officeName" labelValue=(role.office.name)! 
								title='<@spring.message code="core.user.belongingDepartment"></@spring.message>' url="/sys/office/treeData?type=2" cssClass="form-control required" allowClear=false />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label"><@spring.message code="core.role.name"></@spring.message>:</label>
						<div class="col-md-4">
							<input id="oldName" name="oldName" type="hidden" value="${role.name!}">
							<@form.input path="name" htmlEscape=false maxlength="50" class="form-control required"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label"><@spring.message code="core.role.roleIdentification"></@spring.message>:</label>
						<div class="col-md-4">
							<input id="oldName" name="oldName" type="hidden" value="${role.name!}">
							<@form.input path="code" htmlEscape=false maxlength="50" class="form-control" />
						</div>
					</div>
					
<!-- 					<div class="form-group">
						<label class="col-md-3 control-label">数据范围:</label>
						<div class="col-md-4">
							<@form.select path="dataScope"  cssClass="form-control">
								<@form.options items=fns.getDictList('sys_data_scope') itemLabel="label" itemValue="value" htmlEscape=false/>
							</@form.select>
						</div>
					</div> -->
					
<!-- 					<div class="form-group">
						<label class="col-md-3 control-label">角色类型:</label>
						<div class="col-md-4">
							<@form.select path="roleType"  cssClass="form-control">
								<@form.option value="">--<@spring.message code="core.pleaseChoose"></@spring.message>--</@form.option>
								<@form.option value="3"><@spring.message code="core.role.taskAllocation"></@spring.message></@form.option>
								<@form.option value="2"><@spring.message code="core.role.managementRole"></@spring.message></@form.option>
								<@form.option value="1"><@spring.message code="core.role.commonRole"></@spring.message></@form.option>
							</@form.select>
						</div>
					</div> -->
					
<!-- 					<div class="form-group">
						<label class="col-md-3 control-label">是否系统数据:</label>
						<div class="col-md-4">
							<@form.select path="isSys"  cssClass="form-control">
								<@form.option value="">--<@spring.message code="core.pleaseChoose"></@spring.message>--</@form.option>
								<@form.option value="1"><@spring.message code="core.yes"></@spring.message></@form.option>
								<@form.option value="0"><@spring.message code="core.no"></@spring.message></@form.option>
							</@form.select>
						</div>
					</div> -->
					
					<div class="form-group">
						<label class="col-md-3 control-label"><@spring.message code="core.role.isItAvailable"></@spring.message>:</label>
						<div class="col-md-4">
							<@form.select path="useable"  cssClass="form-control">
								<@form.option value="">--<@spring.message code="core.pleaseChoose"></@spring.message>--</@form.option>
								<@form.option value="1"><@spring.message code="core.yes"></@spring.message></@form.option>
								<@form.option value="0"><@spring.message code="core.no"></@spring.message></@form.option>
							</@form.select>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-3 control-label"><@spring.message code="core.role.roleAuthorization"></@spring.message>:</label>
						<div class="col-md-8">
							<#list permissionGroupNameList as groupName>
							<div id="groupDiv_${groupName_index}" style="padding-bottom: 10px;">
						 		<div style="padding-top: 8px;"><label><input id="groupName_${groupName_index}" type="checkbox" value="" /><b> ${groupName!}</b></label></div>
								<div id="permDiv_${groupName_index}">
							 	<#list permissionList as perm>
							 		<#if perm.groupName==groupName>
							 			<label style="display: inline-block; min-width: 110px; padding-right: 10px; white-space: nowrap;"><input id="permName_${perm.id!}" type="checkbox" value="${perm.id!}" pid="groupName_${groupName_index}" /> ${perm.name!}</label>
							 		</#if>
							 	</#list>
						 		</div>
						 	</div>
						 	</#list>
							<@form.hidden path="permissionIds"/>
						</div>
					</div>
					<div class="form-actions">
						<@shiro.hasPermission name="sys:role:edit">
							<input id="btnSubmit" class="btn btn-primary" type="submit" value="<@spring.message code="core.save"></@spring.message>"/>&nbsp;
						</@shiro.hasPermission>
						<input id="btnCancel" class="btn" type="button" value="<@spring.message code="core.goBack"></@spring.message>" onclick="history.go(-1)"/>
					</div>
				</div>
			</@form.form>
            </div>
        </div>
	</div>
</body>
</html>