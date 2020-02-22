<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.express.management"></@spring.message></title>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/template/"><@spring.message code="core.express.list"></@spring.message></a></li>
		<@shiro.hasPermission name="sys:express:edit"><li><a href="${ctx}/sys/express/form">快递添加</a></li></@shiro.hasPermission>
	</ul>
	<@form.form id="searchForm" action="${ctx}/sys/express/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo!}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize!}"/>
	</@form.form>
	<#if message??><@tags.message content=message /></#if>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th><@spring.message code="core.express.name"></@spring.message></th><th><@spring.message code="core.express.code"></@spring.message></th><th><@spring.message code="core.express.sequenceNumber"></@spring.message></th><th>快递类型</th><th><@spring.message code="core.express.expressPrice"></@spring.message></th><th><@spring.message code="core.temp.isItOpen"></@spring.message></th><th><@spring.message code="core.operation"></@spring.message></th></tr></thead>
		<tbody>
		<#list page.list as express >
			<tr>
				<td>${express.companyName!}</td>
				<td>${express.companyMark!}</td>
				<td>${express.companySequence!}</td>
				<td>${express.companyType!}</td>
				<td>${express.companyPrice!}</td>
				<#assign x="${express.companyStatus!'0'}">
				<td><#if x=='0'><@spring.message code="core.yes"></@spring.message><#else><@spring.message code="core.no"></@spring.message></#if></td>
				<@shiro.hasPermission name="sys:express:edit"><td>
    				<a href="${ctx}/sys/express/form?id=${express.id!}"><@spring.message code="core.modify"></@spring.message></a>
				</td></@shiro.hasPermission>
			</tr>
		</#list>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>