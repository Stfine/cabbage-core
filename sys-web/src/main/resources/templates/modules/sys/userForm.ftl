<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.user.management"></@spring.message></title>
	<#include "/include/treeview.ftl" >
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginName").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?id="+$('#uid').val()}
				},
				messages: {
					loginName: {remote: "<@spring.message code="core.user.theUsernameHasAlreadyExisted"></@spring.message>"},
					confirmNewPassword: {equalTo: "<@spring.message code="core.user.enterTheSamePasswordAsAbove"></@spring.message>"}
				},
				submitHandler: function(form){
					var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
					for(var i=0; i<nodes2.length; i++) {
						ids2.push(nodes2[i].id);
					}
					$("#officeIds").val(ids2);
					loading('<@spring.message code="core.itIsBeingSubmittedPleaseWaitAMoment"></@spring.message>...');
					form.submit();
				}
			});
			
			var setting = {
				check:{enable:true,nocheckInherit:true},
				view:{selectedMulti:false},
				data:{
					simpleData:{enable:true}
				},
				callback:{
					beforeClick:function(id, node){
						tree.checkNode(node, !node.checked, true, true);
						return false;
					}
				}
			};
			
			// 用户-机构
			var zNodes2=[
				<#list officeList as office >
					{id:${office.id!}, pId:${office.parentId!0}, name:'${office.name!}'},
            	</#list>];
			// 初始化树结构
			var tree2 = $.fn.zTree.init($("#officeTree"), setting, zNodes2);
			// 不选择父节点
			tree2.setting.check.chkboxType = { "Y" : "s", "N" : "s" };
			// 默认选择节点
			var ids2 = "${user.officeIds}".split(",");
			for(var i=0; i<ids2.length; i++) {
				var node = tree2.getNodeByParam("id", ids2[i]);
				try{tree2.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree2.expandAll(true);
			
			// 刷新（显示/隐藏）机构
			refreshOfficeTree();
			$("#dataScope").change(function(){
				refreshOfficeTree();
			});
		});
		
		function refreshOfficeTree(){
			// 按明细设置
			if($("#dataScope").val()==9){ 
				$("#officeTreeDiv").show();
			}else{
				$("#officeTreeDiv").hide();
			}
		}
	</script>
	<style type="text/css">
		#roleIdList span, .roles span{
			width:200px;
			float:left;
		}
	</style>
</head>
<body>

	<div>
       

	<#if message??><@tags.message content=message /></#if>
	<div class="portlet light ">
			<ul class="nav nav-tabs mb-25">
	            <li >
	                <a  href="${ctx}/sys/user/list">
	                                          <@spring.message code="core.user.management"></@spring.message>
	                </a>
	            </li>
	            <li class="active">
	                <a  href="javascript:;">
	                 <@shiro.hasPermission name="sys:user:edit">
                    <#if user.uid??>
                                                     <@spring.message code="core.modify"></@spring.message><#else>
                                                     <@spring.message code="core.add"></@spring.message></#if>
                    </@shiro.hasPermission>
                    <@shiro.lacksPermission name="sys:user:edit">
                                                     <@spring.message code="core.see"></@spring.message>
                    </@shiro.lacksPermission>
	            	 </a>
	            </li>
        	</ul>
            <div class="portlet-body form">
                <!-- BEGIN FORM-->
	<@form.form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<@form.hidden path="uid"/>
		<div class="form-body">
		  
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.ownershipCompany"></@spring.message>:</label>
			<div class="col-xs-4">
                <@tags.treeselect id="company" name="companyId" value=(user.company.id)! labelName="companyName" labelValue=(user.company.name)!
					title='<@spring.message code="core.user.ownershipCompany"></@spring.message>' url="/sys/office/treeData?type=1" cssClass="form-control required" allowClear=false />
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.belongingDepartment"></@spring.message>:</label>
			<div class="col-xs-4">
                <@tags.treeselect id="office" name="officeId" value=(user.office.id)! labelName="officeName" labelValue=(user.office.name)!
					title='<@spring.message code="core.user.belongingDepartment"></@spring.message>' url="/sys/office/treeData?type=2" cssClass="form-control required" allowClear=false />
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.loginName"></@spring.message>:</label>
			<div class="col-xs-4">
				<input id="loginName" name="loginName" minlength="6" maxlength="50" type="text" value="${(user.userAccount.loginName)!}" class="form-control required" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.name"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="name" htmlEscape=false maxlength="50" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.workNumber"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="no" htmlEscape=false maxlength="50" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.password"></@spring.message>:</label>
			<div class="col-xs-4">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="form-control ${user.uid!'required'}"/>
				<#if user.uid??><span class="help-inline"><@spring.message code="core.user.ifYouDoNotModifyThePasswordPleaseLeaveTheBlank"></@spring.message>。</span></#if>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.confirmThePassword"></@spring.message>:</label>
			<div class="col-xs-4">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.idCard"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="idCard" htmlEscape=false maxlength="18" class="required" class="form-control card"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.email"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="email" htmlEscape=false maxlength="100" class="form-control email"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.phone"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="phone" htmlEscape=false maxlength="100" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.mobile"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="mobile" htmlEscape=false maxlength="100" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.remarks"></@spring.message>:</label>
			<div class="col-md-6 col-xs-8">
				<@form.textarea path="remarks" htmlEscape=false rows="3" maxlength="200" class="form-control input-xlarge"/>
			</div>
		</div>
		<div class="form-group">
			<label class=" col-xs-3 control-label"><@spring.message code="core.user.role"></@spring.message>:</label>
			<div class="col-md-4 col-xs-6">
				<p class="form-control-static user-role-list"><@form.checkboxes path="roleIdList" items=allRoles itemLabel="name" itemValue="id" htmlEscape=false class="required"/></p>
			</div>
		</div>
		<div class="form-group" id="officeTreeDiv">
			<label class=" col-xs-3 control-label"></label>
			<div class="col-md-4 col-xs-6">
				<div id="officeTree" class="form-control ztree" style="margin-top:3px;float:left;"></div>
				<@form.hidden path="officeIds"/>
			</div>
		</div>
		<#if user.uid??>
			<div class="form-group">
				<label class="col-xs-3 control-label"><@spring.message code="core.creationTime"></@spring.message>:</label>
				<div class="col-xs-4">
					<label class="lbl"><#if user.createTime??>${user.createTime?string("yyyy-MM-dd HH:mm:ss")}</#if></label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-3 control-label"><@spring.message code="core.user.finallyLanding"></@spring.message>:</label>
				<div class="col-xs-4">
					<label class="lbl">IP: ${(user.userAccount.lastLoginIp)!}&nbsp;&nbsp;&nbsp;&nbsp;<@spring.message code="core.time"></@spring.message>：<#if (user.userAccount.lastLoginTime)??>${user.userAccount.lastLoginTime?string("yyyy-MM-dd HH:mm:ss")}</#if></label>
				</div>
			</div>
		</#if>
		<div class="form-actions">
			<div class="row">
                <div class="col-md-offset-3 col-md-4">
				<@shiro.hasPermission name="sys:user:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="<@spring.message code="core.save"></@spring.message>"/>&nbsp;
				</@shiro.hasPermission>
				</div>
            </div>
		</div>
	</@form.form>
	</div>
   </div>



	</div>
</body>
</html>