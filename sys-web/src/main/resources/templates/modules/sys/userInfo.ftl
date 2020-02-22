<#include "/include/taglib.ftl" >
<html>
<head>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("<@spring.message code="core.inputIsIncorrectPleaseCorrect"></@spring.message>");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
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
                    <span><@spring.message code="core.user.personalInfo"></@spring.message></span>
                </li>
            </ul>
        </div>
        <#if message??><@tags.message content=message /></#if>
        <div class="portlet light ">
            <div class="portlet-title">
                <div class="caption">
                    <span class="caption-subject font-green bold uppercase"><@spring.message code="core.user.personalInfo"></@spring.message></span>
                </div>
            </div>
            <div class="portlet-body form">
                <!-- BEGIN FORM-->
                <@form.form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/saveInfo" method="post" class="form-horizontal">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label"><@spring.message code="core.user.ownershipCompany"></@spring.message>: </label>
                            <div class="col-md-4">
                                <p class="form-control-static"> ${(user.company.name)!}</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><span class="c-red">*</span><@spring.message code="core.user.name"></@spring.message>: </label>
                            <div class="col-md-4">
                                <@form.input path="name" htmlEscape=false maxlength="50" class="form-control required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><span class="c-red">*</span><@spring.message code="core.user.email"></@spring.message>: </label>
                            <div class="col-md-4">
                                <@form.input path="email" htmlEscape=false maxlength="50" class="form-control email"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><@spring.message code="core.user.phone"></@spring.message>:</label>
                            <div class="col-md-4">
                                <@form.input path="phone" htmlEscape=false maxlength="50" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><@spring.message code="core.user.mobile"></@spring.message>:</label>
                            <div class="col-md-4">
                                <@form.input path="mobile" htmlEscape=false maxlength="50" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><@spring.message code="core.user.remarks"></@spring.message>:</label>
                            <div class="col-md-4">
                                <@form.textarea path="remarks" htmlEscape=false rows="3" maxlength="200" class="form-control input-xlarge"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><@spring.message code="core.user.role"></@spring.message>:</label>
                            <div class="col-md-4">
                                <p class="form-control-static">${user.roleNames!}</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><@spring.message code="core.user.finallyLanding"></@spring.message>:</label>
                            <div class="col-md-6">
                                <p class="form-control-static">IP: ${user.userAccount.lastLoginIp!}&nbsp;&nbsp;&nbsp;&nbsp;<@spring.message code="core.user.finallyLandingTime"></@spring.message>：<#if user.userAccount.lastLoginTime??>${user.userAccount.lastLoginTime?string("yyyy-MM-dd HH:mm:ss")}</#if></p>
                            </div>
                        </div>

                    </div>

                    <div class="form-actions">
                        <div class="row">
                            <div class="col-md-offset-3 col-md-4">
                                <input id="btnSubmit" class="btn btn-primary" type="submit" value="<@spring.message code="core.save"></@spring.message>"/>
                            </div>
                        </div>
                    </div>
                    </@form.form>
            </div>
        </div>
	</div>
</body>
</html>