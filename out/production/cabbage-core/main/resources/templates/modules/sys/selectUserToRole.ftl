<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.role.distributionRole"></@spring.message></title>
	<#include "/include/treeview.ftl" >
	<script type="text/javascript">
	
		var officeTree;
		var selectedTree;//zTree已选择对象
		
		// 初始化
		$(document).ready(function(){
			officeTree = $.fn.zTree.init($("#officeTree"), setting, officeNodes);
			selectedTree = $.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
		});

		var setting = {view: {selectedMulti:false,nameIsHTML:true,showTitle:false},
				data: {simpleData: {enable: true}},
				callback: {onClick: treeOnClick}};
		
		var officeNodes=[
	            <#list officeList as office>
	            {id:"${office.id}",
	             pId:"${(office.parentId??)?string(office.parentId,'0')}", 
	             name:"${office.name}"},
	            </#list>];
	
		var pre_selectedNodes =[
   		        <#list role.userList as user>
   		        {id:"${user.id}",
   		         pId:"0",
   		         name:"<font color='red' style='font-weight:bold;'>${user.loginName}</font>"},
   		        </#list>];
		
		var selectedNodes =[
		        <#list role.userList as user>
		        {id:"${user.id}",
		         pId:"0",
		         name:"<font color='red' style='font-weight:bold;'>${user.loginName}</font>"},
		        </#list>];
		
		var pre_ids = "${selectIds!}".split(",");
		var ids = "${selectIds!}".split(",");
		
		//点击选择项回调
		function treeOnClick(event, treeId, treeNode, clickFlag){
			if("officeTree"==treeId){
				$.get("${ctx}/sys/role/users?officeId=" + treeNode.id, function(userNodes){
					$.fn.zTree.init($("#userTree"), setting, userNodes);
				});
			}
			if("userTree"==treeId){
				//alert(treeNode.id + " | " + ids);
				//alert(typeof ids[0] + " | " +  typeof treeNode.id);
				if($.inArray(String(treeNode.id), ids)<0){
					selectedTree.addNodes(null, treeNode);
					ids.push(String(treeNode.id));
				}
			}
            if("selectedTree"==treeId){
                if($.inArray(String(treeNode.id), pre_ids)<0){
                    selectedTree.removeNode(treeNode);
                    ids.splice($.inArray(String(treeNode.id), ids), 1);
                }else{
                    top.$.jBox.tip("<@spring.message code="core.select.onlyDeleteNewAdditions"></@spring.message>！", 'info');
                }
            }
		}
				
		function clearAssign(){
			var submit = function (v, h, f) {
			    if (v == 'ok'){
					var tips="";
					if(pre_ids.sort().toString() == ids.sort().toString()){
						tips = "<@spring.message code="core.role.notGiven"></@spring.message>【${role.name!}】<@spring.message code="core.role.newMembers"></@spring.message>！";
					}else{
						tips = "<@spring.message code="core.select.selectedPersonnelClearedUp"></@spring.message>！";
					}
					ids=pre_ids.slice(0);
					selectedNodes=pre_selectedNodes;
					$.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
			    	top.$.jBox.tip(tips, 'info');
			    } else if (v == 'cancel'){
			    	// 取消
			    	top.$.jBox.tip("<@spring.message code="core.select.cancellingTheCleanupOperation"></@spring.message>！", 'info');
			    }
			    return true;
			};
			tips="<@spring.message code="core.select.determineTheScavengingRole"></@spring.message>【${role.name!}】<@spring.message code="core.select.selectedStaff"></@spring.message>？";
			top.$.jBox.confirm(tips, "<@spring.message code="core.select.clearanceConfirmation"></@spring.message>", submit);
		};
	</script>
</head>
<body>
	<div id="assignRole" class="row-fluid span12">
		<div class="span4" style="border-right: 1px solid #A8A8A8;">
			<p><@spring.message code="core.login.department"></@spring.message>：</p>
			<div id="officeTree" class="ztree"></div>
		</div>
		<div class="span4">
			<p><@spring.message code="core.select.candidatesToBeSelected"></@spring.message>：</p>
			<div id="userTree" class="ztree"></div>
		</div>
		<div class="span4" style="padding-left:16px;border-left: 1px solid #A8A8A8;">
			<p><@spring.message code="core.select.selectedPersonnel"></@spring.message>：</p>
			<div id="selectedTree" class="ztree"></div>
		</div>
	</div>
</body>
</html>
