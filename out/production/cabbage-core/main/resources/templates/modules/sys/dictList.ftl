<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.dict.Management"></@spring.message></title>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	    function deleteThis(uuid){
	    	 top.jBox.confirm('<@spring.message code="core.dict.doYouWantToMakeSureYouWantToDeleteTheDictionary"></@spring.message>？', '<@spring.message code="core.prompt"></@spring.message>', function (v, h, f) {
	            if (v === 'ok') {
	                  window.location.href="${ctx}/sys/dict/delete?id="+uuid;
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
                    <span><@spring.message code="core.systemSetup"></@spring.message></span>
                    <i class="fa fa-angle-right"></i>
                </li>
                <li>
                    <span><@spring.message code="core.dict.Management"></@spring.message></span>
                </li>
            </ul>
        </div>
        
        <div class="portlet light portlet-fit portlet-datatable ">
	       <ul class="nav nav-tabs mb-25">
	            <li class="active">
	                <a data-toggle="tab" href="javascript:;"><@spring.message code="core.dict.List"></@spring.message></a>
	            </li>
                <@shiro.hasPermission name="sys:role:edit">
	            <li class="">
					<a href="${ctx}/sys/dict/form"><@spring.message code="core.add"></@spring.message></a>
	            </li>
                </@shiro.hasPermission>
	        </ul>
				
				<@form.form id="searchForm" modelAttribute="dict" action="${ctx}/sys/dict/" method="post" class="breadcrumb form-search">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<div>
						<label><@spring.message code="core.type"></@spring.message>：</label><@form.select id="type" path="type" class="select2 form-control input-small"><@form.option value="" label="--<@spring.message code="core.pleaseChoose"></@spring.message>--" /><@form.options items=typeList htmlEscape=false /></@form.select>
						&nbsp;&nbsp;<label><@spring.message code="core.describe"></@spring.message>：</label><@form.input path="description" htmlEscape=false maxlength="50" class="form-control input-small input-inline"/>
						&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<@spring.message code="core.query"></@spring.message>" onclick="return page(1)"/>
					</div>
				</@form.form>
				<#if message??><@tags.message content=message /></#if>
	        	<div class="portlet-body">
	            <div id="sample_4_wrapper" class="dataTables_wrapper">
                <div class="table-scrollable">
				<table id="contentTable" class="table table-striped table-bordered table-hover table-checkable order-column dataTable" >
					<thead><tr><th><@spring.message code="core.dict.keyValue"></@spring.message></th><th><@spring.message code="core.dict.label"></@spring.message></th><th><@spring.message code="core.dict.label"></@spring.message>(<@spring.message code="core.english"></@spring.message>)</th><th><@spring.message code="core.type"></@spring.message></th><th><@spring.message code="core.describe"></@spring.message></th><th><@spring.message code="core.sort"></@spring.message></th><@shiro.hasPermission name="sys:dict:edit"><th><@spring.message code="core.operation"></@spring.message></th></@shiro.hasPermission></tr></thead>
					<tbody>
					<#list page.list as dict >
						<tr>
							<td>${dict.value!}</td>
							<td><a href="${ctx}/sys/dict/form?id=${dict.id!}">${dict.label!}</a></td>
							<td>${dict.labelEn!}</td>
							<td><a href="javascript:" onclick="$('#type').val('${dict.type!}');$('#searchForm').submit();return false;">${dict.type!}</a></td>
							<td>${dict.description!}</td>
							<td>${dict.sort!}</td>
							<@shiro.hasPermission name="sys:dict:edit"><td>
			    				<a href="${ctx}/sys/dict/form?id=${dict.id!}"><@spring.message code="core.modify"></@spring.message></a>
			    				<a onclick="deleteThis(${dict.id!})"><@spring.message code="core.delete"></@spring.message></a>
			    				<a href="${ctx}/sys/dict/form?type=${dict.type!}&sort=${dict.sort!0+10}&description=${dict.description!}"><@spring.message code="core.dict.addKeyValue"></@spring.message></a>
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
    </div>
</body>
</html>