<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.temp.management"></@spring.message></title>
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
                    <span><@spring.message code="core.temp.management"></@spring.message></span>
                </li>
            </ul>
        </div>
        
        <div class="portlet light portlet-fit portlet-datatable ">
	       <ul class="nav nav-tabs mb-25">
	            <li class="active">
	                <a data-toggle="tab" href="javascript:;"><@spring.message code="core.temp.list"></@spring.message> </a>
	            </li>
	            <li class="">
					<a href="${ctx}/sys/template/form"><@spring.message code="core.add"></@spring.message></a>
	            </li>
	        </ul>
            
	        <div class="portlet-body">
	            <div id="sample_4_wrapper" class="dataTables_wrapper">
				<@tags.message content=message! />
                <div class="table-scrollable">
				<table id="contentTable" class="table table-striped table-bordered table-hover table-checkable order-column dataTable">
					<thead><tr><th><@spring.message code="core.temp.templateDescription"></@spring.message></th><th><@spring.message code="core.temp.templateIdentification"></@spring.message></th><th><@spring.message code="core.temp.templateType"></@spring.message></th><th><@spring.message code="core.temp.limitTimes"></@spring.message></th><th><@spring.message code="core.temp.isItOpen"></@spring.message></th><th><@spring.message code="core.operation"></@spring.message></th></tr></thead>
					<tbody>
					<#list page.list as template >
						<tr>
							<td>${template.info!}</td>
							<td>${template.mark!}</td>
							<#if (template.type)??><#assign x=template.type><#else><#assign x='sms'></#if>
							<td>
							<#if x == 'sms'><@spring.message code="core.temp.SMSTemplate"></@spring.message></#if>
							<#if x == 'email'><@spring.message code="core.temp.mailTemplate"></@spring.message></#if>
							</td>
							<td>${template.times!}</td>
							<td><#if template.open!><@spring.message code="core.yes"></@spring.message><#else><@spring.message code="core.no"></@spring.message></#if></td>
							<td>
			    				<a href="${ctx}/sys/template/form?id=${template.id!}"><@spring.message code="core.modify"></@spring.message></a>
							</td>
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