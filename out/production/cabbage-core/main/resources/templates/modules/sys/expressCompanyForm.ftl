<#include "/include/taglib.ftl" >
<html>
<head>
	<title><@spring.message code="core.express.management"></@spring.message></title>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#info").focus();
			$("#inputForm").validate({
				rules:{
				  companySequence:{digits:true},
				  companyPrice:{number:true},
				  companyMark:{
					   remote: "${ctx}/sys/express/expressCompanyMark?id="+$('#id').val()+"&companyMark=" + $('#companyMark').val()
				  }
				 },
				messages:{
					companySequence:{digits:"<@spring.message code="core.express.theNumberOfTheOrdinalNumbersCanOnlyBeNumeral"></@spring.message>"},
					 companyPrice:{number:"<@spring.message code="core.express.mustBeANumber"></@spring.message>"},
					companyMark:{remote:"<@spring.message code="core.express.expressCodeAlreadyExists"></@spring.message>"}
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
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/express/"><@spring.message code="core.express.list"></@spring.message></a></li>
		<li class="active"><a href="${ctx}/sys/express/form?id=${express.id!}"><@spring.message code="core.express.template"></@spring.message><@shiro.hasPermission name="sys:express:edit"><#if express.id??><@spring.message code="core.modify"></@spring.message><#else><@spring.message code="core.add"></@spring.message></#if></@shiro.hasPermission><@shiro.lacksPermission name="sys:express:view"><@spring.message code="core.see"></@spring.message></@shiro.lacksPermission></a></li>
	</ul><br/>
	<#if message??><@tags.message content=message /></#if>
	<@form.form id="inputForm" modelAttribute="express" action="${ctx}/sys/express/save" method="post" class="form-horizontal">
		<@form.hidden path="id"/>
		<div class="control-group">
			<label class="control-label" for="companyName"><@spring.message code="core.express.name"></@spring.message>:</label>
			<div class="controls">
				<@form.input path="companyName" minlength="4" maxlength="80" class="required" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="companyMark"><@spring.message code="core.express.code"></@spring.message>:</label>
			<div class="controls">
				<@form.input path="companyMark" htmlEscape=false minlength="4" maxlength="50" class="required"/>
			</div>
		</div>
		<#--<div class="control-group">
			<label class="control-label" for="mark">快递类型:</label>
			<div class="controls">
				<@form.input path="mark" minlength="6" maxlength="50" class="required"/>
			</div>
		</div>-->
		<div class="control-group">
			<label class="control-label" for="companySequence"><@spring.message code="core.express.sequenceNumber"></@spring.message>:</label>
			<div class="controls">
				<@form.input path="companySequence" maxlength="2" minlength="1" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="companyPrice"><@spring.message code="core.express.expressPrice"></@spring.message>:</label>
			<div class="controls">
				<@form.input path="companyPrice" htmlEscape=false class="required"/>
			</div>
		</div>
		<#if express.companyStatus??><#assign x="${express.companyStatus!'0'}"><#else><#assign x="0"></#if> 
		<div class="control-group">
			<label class="control-label" for="email"><@spring.message code="core.express.doesItShow"></@spring.message>:</label>
			<div class="controls">
				<select id="companyStatus" name="companyStatus" class="input-small">
					<option value='0' <#if x=='0'>selected='selected'</#if>><@spring.message code="core.yes"></@spring.message></option>
					<option value='-1' <#if x=='-1'>selected='selected'</#if>><@spring.message code="core.no"></@spring.message></option>
				<select>
			</div>
		</div>
		<div class="form-actions">
			<@shiro.hasPermission name="sys:express:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<@spring.message code="core.save"></@spring.message>"/>&nbsp;</@shiro.hasPermission>
			<input id="btnCancel" class="btn" type="button" value="<@spring.message code="core.goBack"></@spring.message>" onclick="history.go(-1)"/>
		</div>
	</@form.form>
</body>
</html>