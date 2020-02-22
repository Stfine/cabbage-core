<#include "/include/taglib.ftl" >
<#include "/include/dialog.ftl" >
<html>
<head>
	<title><@spring.message code="core.user.management"></@spring.message></title>
	<style type="text/css">.sort{color:#0663A2;cursor:pointer;}</style>
	<script type="text/javascript">
		$(document).ready(function() {
			// 表格排序
			//tableSort({callBack : page});
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/").submit();
	    	return false;
	    }
	    function deleteUser(uid){
	    	 top.jBox.confirm('<@spring.message code="core.user.doYouWantToMakeSureThatYouWantToDeleteTheUser"></@spring.message>？', '<@spring.message code="core.prompt"></@spring.message>', function (v, h, f) {
	            if (v === 'ok') {
	                  window.location.href="${ctx}/sys/user/delete?id="+uid;
	            }
	            return true;
 			 });
	    }
	</script>
</head>
<body>

        <div class=" ">

        <ul class="nav nav-tabs mb-25">
            <li class="active">
              <a data-toggle="tab" href="javascript:;">
         	        <@spring.message code="core.user.management"></@spring.message>
              </a>
            </li>
            <li class="">
              <a  href="${ctx}/sys/user/form">
                                         <@spring.message code="core.add"></@spring.message>
			  </a>
            </li>
        </ul>





        <@form.form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/" method="post" class="form-search">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo!}"/>
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize!}"/>
            <input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy!}"/>
            <div>


                <label class="ml-15"><@spring.message code="core.user.ownershipCompany"></@spring.message>：</label>
                 <div style="display: inline-block; vertical-align: bottom;max-width: 28%;">
                <@tags.treeselect id="company" name="companyId" value=user.companyId! labelName="companyName" labelValue=user.companyName!
                    title='<@spring.message code="core.user.ownershipCompany"></@spring.message>' url="/sys/office/treeData?type=1" cssClass="form-control" allowClear=true/>
				 </div>
				 
                <label class="ml-15"><@spring.message code="core.user.belongingDepartment"></@spring.message>：</label>
                <div style="display: inline-block; vertical-align: bottom;max-width: 28%;">
                <@tags.treeselect id="office" name="officeId" value=user.officeId! labelName="officeName" labelValue=user.officeName!
                    title='<@spring.message code="core.user.belongingDepartment"></@spring.message>' url="/sys/office/treeData?type=2" cssClass="form-control" allowClear=true/>
				 </div>
				<br/><br/>
                <label class="ml-15"><@spring.message code="core.user.loginName"></@spring.message>：</label><@form.input path="loginName" htmlEscape=false maxlength="50" class="form-control input-small input-inline"/>
                <label class="ml-15"><@spring.message code="core.user.name"></@spring.message>：</label><@form.input path="name" htmlEscape=false maxlength="50" class="form-control input-small input-inline"/>
                &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<@spring.message code="core.query"></@spring.message>" onclick="return page(1);"/>
            </div>
        </@form.form>
        <div class="portlet-body">
            <div id="sample_4_wrapper" class="dataTables_wrapper">
				<@tags.message content=message! />
                <div class="table-scrollable">

                    <table id="contentTable" class="table table-striped table-bordered table-hover table-checkable order-column dataTable" role="grid">
                        <thead><tr><th><@spring.message code="core.user.ownershipCompany"></@spring.message></th><th><@spring.message code="core.user.belongingDepartment"></@spring.message></th><th class="sort loginName"><@spring.message code="core.user.loginName"></@spring.message></th><th class="sort name"><@spring.message code="core.user.name"></@spring.message></th><th><@spring.message code="core.user.phone"></@spring.message></th><th><@spring.message code="core.user.mobile"></@spring.message></th><th><@spring.message code="core.user.role"></@spring.message></th><@shiro.hasPermission name="sys:user:edit"><th><@spring.message code="core.operation"></@spring.message></th></@shiro.hasPermission></tr></thead>
                        <tbody>
                        <#list page.list as user >
                            <tr>
                                <td>${(user.company.name)!}</td>
                                <td>${(user.office.name)!}</td>
                                <td><a href="${ctx}/sys/user/form?id=${user.uid!}">${user.loginName!}</a></td>
                                <td>${user.name!}</td>
                                <td>${user.phone!}</td>
                                <td>${user.mobile!}</td>
                                <td>${user.roleNames!}</td>
                                <@shiro.hasPermission name="sys:user:edit"><td>
                                    <a href="${ctx}/sys/user/form?id=${user.uid!}"><@spring.message code="core.modify"></@spring.message></a>
                                    <a   onclick="deleteUser(${user.uid!})"><@spring.message code="core.delete"></@spring.message></a>
                                </td></@shiro.hasPermission>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
                <div class="text-center"><div class="pagination">${page}</div><div>
            </div>
        </div>
    </div>
</body>
</html>