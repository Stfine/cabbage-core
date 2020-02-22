<#include "/include/taglib.ftl" >
<html>
<head>
	<title></title>
	<link href="${pubStatic}/wgt/area/selectAddress.css" rel="stylesheet" type="text/css" />
	<script src="${pubStatic}/wgt/area/selectAddress.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate();
			$("input[name='areaId']").areaSelect({
        		dateUrl: "${request.contextPath}/dic/getAreaJsPath"
        	});
		});
	</script>
</head>
<body>


	<div>
	<#-- 
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
                 <span><@spring.message code="core.office.organizationalManagement"></@spring.message></span>
                 <i class="fa fa-angle-right"></i>
                </li>
                <li>
                    <span>
                    <@shiro.hasPermission name="sys:office:edit">
                    ${(office.id??)?string('<@spring.message code="core.modify"></@spring.message>','<@spring.message code="core.add"></@spring.message>')}
                    </@shiro.hasPermission>
                    <@shiro.lacksPermission name="sys:office:edit">
                    	<@spring.message code="core.see"></@spring.message>
                    </@shiro.lacksPermission>
                    </span>
                </li>
            </ul>
        </div>
	 -->
	<div class="portlet light ">
	
			<ul class="nav nav-tabs mb-25">
	            <li >
	                <a  href="${ctx}/sys/office/list">
	              <@spring.message code="core.office.organizationalManagement"></@spring.message></a>
	            </li>
	            <li class="active">
	                <a  href="javascript:;">
	                 <@shiro.hasPermission name="sys:office:edit">
					 	<#if office.id??>
							<@spring.message code="core.modify"></@spring.message>
							<#else >
								<@spring.message code="core.add"></@spring.message>
					 	</#if>
                    </@shiro.hasPermission>
                    <@shiro.lacksPermission name="sys:office:edit">
                   		 <@spring.message code="core.see"></@spring.message>
                    </@shiro.lacksPermission>
	            	 </a>
	            </li>
        	</ul>
            <div class="portlet-body form">	
	<@form.form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal">
		<@form.hidden path="id"/>
		<@tags.message content=message! />
		<div class="form-body">
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.higherAuthority"></@spring.message>:</label>
			<div class="col-xs-4">
                <@tags.treeselect id="office" name="parentId" value=office.parentId! labelName="parent.name" labelValue=(office.parent.name)!
					title='<@spring.message code="core.office.higherAuthority"></@spring.message>' url="/sys/office/treeData" extId=office.id cssClass="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.attributionArea"></@spring.message>:</label>
			<div class="col-xs-4">
				<div id=""></div>
				<@form.hidden path="areaId" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.org.name"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="name" htmlEscape=false maxlength="50" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.org.code"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="code" htmlEscape=false maxlength="50" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.org.type"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.select path="type" cssClass="form-control">
					<@form.options items=fns.getDictList('sys_office_type') itemLabel="label" itemValue="value" htmlEscape=false/>
				</@form.select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.org.level"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.select path="grade" cssClass="form-control">
					<@form.options items=fns.getDictList('sys_office_grade') itemLabel="label" itemValue="value" htmlEscape=false/>
				</@form.select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.contactAddress"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="address" htmlEscape=false maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.postalCode"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="zipCode" htmlEscape=false maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.personInCharge"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="master" htmlEscape=false maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.phone"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="phone" htmlEscape=false maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.fax"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="fax" htmlEscape=false maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.office.mail"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.input path="email" htmlEscape=false maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label"><@spring.message code="core.user.remarks"></@spring.message>:</label>
			<div class="col-xs-4">
				<@form.textarea path="remarks" htmlEscape=false rows="3" maxlength="200" class="form-control input-xlarge"/>
			</div>
		</div>
		
		<div class="form-actions">
			<div class="row">
                <div class="col-xs-offset-3 col-xs-4">
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