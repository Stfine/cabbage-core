<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.temp.management"></@spring.message></title>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#info").focus();
			$("#inputForm").validate({
				rules: {
					mark: {
						remote: "${ctx}/sys/template/checkMark?id="+$('#id').val()+"&mark=" + $('#mark').val()
					},
					times:{digits:true}
				},
				messages: {
					mark: {
						remote: "<@spring.message code="core.temp.templateIdentityAlreadyExists"></@spring.message>"
					},
					times:{digits:"<@spring.message code="core.express.mustBeANumber"></@spring.message>"}
				},
				submitHandler: function(form){
					loading('<@spring.message code="core.itIsBeingSubmittedPleaseWaitAMoment"></@spring.message>...');
					form.submit();
				}
			});
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
				    <span><@spring.message code="core.systemSetup"></@spring.message><i class="fa fa-angle-right"></i></span>
				</li>
                <li>
                 <span><@spring.message code="core.temp.management"></@spring.message></span>
                 <i class="fa fa-angle-right"></i>
                </li>
                <li>
                    <span>
                    <@shiro.hasPermission name="sys:template:edit">
                    <#if template.id??>
                                                     <@spring.message code="core.modify"></@spring.message><#else>
                                                     <@spring.message code="core.add"></@spring.message></#if>
                    </@shiro.hasPermission>
                    <@shiro.lacksPermission name="sys:template:edit">
                                                     <@spring.message code="core.see"></@spring.message>
                    </@shiro.lacksPermission>
                    </span>
                </li>
            </ul>
        </div>

	<#if message??><@tags.message content=message /></#if>
	<div class="portlet light ">
			<ul class="nav nav-tabs mb-25">
	            <li >
	                <a  href="${ctx}/sys/template/">
	                                          <@spring.message code="core.temp.list"></@spring.message>
	                </a>
	            </li>
	            <li class="active">
	                <a  href="javascript:;">
	                 <@shiro.hasPermission name="sys:template:edit">
                    <#if template.id??>
                                                     <@spring.message code="core.modify"></@spring.message><#else>
                                                     <@spring.message code="core.add"></@spring.message></#if>
                    </@shiro.hasPermission>
                    <@shiro.lacksPermission name="sys:template:edit">
                                                     <@spring.message code="core.see"></@spring.message>
                    </@shiro.lacksPermission>
	            	 </a>
	            </li>
        	</ul>
    <div class="portlet-body form">
                <!-- BEGIN FORM-->
	<@form.form id="inputForm" modelAttribute="template" action="${ctx}/sys/template/save" method="post" class="form-horizontal">
		<@form.hidden path="id"/>
		<div class="form-body">
			<div class="form-group">
				<label class="col-md-3 control-label"><@spring.message code="core.temp.templateDescription"></@spring.message>:</label>
				<div class="col-md-4">
					<@form.input path="info" minlength="6" maxlength="80" class="form-control required" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-3 control-label"><@spring.message code="core.temp.templateTitle"></@spring.message>:</label>
				<div class="col-md-4">
					<@form.input path="title" htmlEscape=false minlength="6" maxlength="50" class="form-control required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-3 control-label"><@spring.message code="core.temp.templateIdentification"></@spring.message>:</label>
				<div class="col-md-4">
					<@form.input path="mark" minlength="6" maxlength="50" class="form-control required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-3 control-label"><@spring.message code="core.temp.templateType"></@spring.message>:</label>
				<div class="col-md-4">
					<#if (template.type)??><#assign x=template.type><#else><#assign x='sms'></#if>
					<select id="type" name="type" class="form-control">
						<option value="sms" <#if x == 'sms'>selected</#if>>--<@spring.message code="core.temp.SMSTemplate"></@spring.message>--</option>
						<option value="email" <#if x == 'email'>selected</#if>>--<@spring.message code="core.temp.mailTemplate"></@spring.message>--</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-3 control-label"><@spring.message code="core.temp.limitTimes"></@spring.message>:</label>
				<div class="col-md-4">
					<@form.input path="times" maxlength="2" minlength="1" class="form-control required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-3 control-label"><@spring.message code="core.content"></@spring.message>:</label>
				<div class="col-md-4">
					<@form.textarea path="content" htmlEscape=false maxlength="100" class="form-control required"/>
				</div>
			</div>
			<#if template.open??><#assign x="${template.open?c}"><#else><#assign x="true"></#if> 
			<div class="form-group">
				<label class="col-md-3 control-label"><@spring.message code="core.temp.isItOpen"></@spring.message>:</label>
				<div class="col-md-4">
					<select id="open" name="open" class="input-small form-control">
						<option value='1' <#if x=='true'>selected='selected'</#if>><@spring.message code="core.yes"></@spring.message></option>
						<option value='0' <#if x=='false'>selected='selected'</#if>><@spring.message code="core.no"></@spring.message></option>
					<select>
				</div>
			</div>
			<div class="form-actions">
				<@shiro.hasPermission name="sys:template:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<@spring.message code="core.save"></@spring.message>"/>&nbsp;</@shiro.hasPermission>
				<input id="btnCancel" class="btn" type="button" value="<@spring.message code="core.goBack"></@spring.message>" onclick="history.go(-1)"/>
			</div>
		</div>
	</@form.form>
	</div>
   </div>



	</div>
</body>
</html>