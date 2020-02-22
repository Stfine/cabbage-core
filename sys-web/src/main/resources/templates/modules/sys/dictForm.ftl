<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.dict.Management"></@spring.message></title>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			$("#inputForm").validate();
		});
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
                    <span><@spring.message code="core.systemSetup"></@spring.message></span><i class="fa fa-angle-right"></i>
                </li>
                <li>
                    <span><@spring.message code="core.dict.Management"></@spring.message></span>
                </li>
            </ul>
        </div>
        <div class="portlet light ">
        	<ul class="nav nav-tabs mb-25">
	            <li >
	                <a  href="${ctx}/sys/dict/">
	             <@spring.message code="core.dict.List"></@spring.message> </a>
	            </li>
	            <li class="active">
	                <a  href="javascript:;">
	                <#if dict.id?? ><@spring.message code="core.modify"></@spring.message><#else><@spring.message code="core.add"></@spring.message></#if>
	            	 </a>
	            </li>
        	</ul>
            <div class="portlet-body form">
			<#if message??><@tags.message content=message /></#if>
			<@form.form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal">
				<@form.hidden path="id"/>
				<div class="form-body">
				<div class="form-group">
					<label class="col-md-3 control-label" for="value"><@spring.message code="core.dict.keyValue"></@spring.message><span class="c-red">*</span>:</label>
					<div class="col-md-4">
						<@form.input path="value" htmlEscape=false maxlength="50" class="form-control required"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label" for="label"><@spring.message code="core.dict.label"></@spring.message><span class="c-red">*</span>:</label>
					<div class="col-md-4">
						<@form.input path="label" htmlEscape=false maxlength="50" class="form-control required"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label" for="label"><@spring.message code="core.dict.label"></@spring.message>(<@spring.message code="core.english"></@spring.message>):</label>
					<div class="col-md-4">
						<@form.input path="labelEn" htmlEscape=false maxlength="50" class="form-control"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label" for="type"><@spring.message code="core.type"></@spring.message><span class="c-red">*</span>:</label>
					<div class="col-md-4">
						<@form.input path="type" htmlEscape=false maxlength="50" class="form-control required abc"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label" for="description"><@spring.message code="core.describe"></@spring.message><span class="c-red">*</span>:</label>
					<div class="col-md-4">
						<@form.input path="description" htmlEscape=false maxlength="50" class="form-control required"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label" for="sort"><@spring.message code="core.sort"></@spring.message><span class="c-red">*</span>:</label>
					<div class="col-md-4">
						<@form.input path="sort" htmlEscape=false maxlength="11" class="form-control required digits"/>
					</div>
				</div>
				<div class="form-actions">
					<@shiro.hasPermission name="sys:dict:edit">
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