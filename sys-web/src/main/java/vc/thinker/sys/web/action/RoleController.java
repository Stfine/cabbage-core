/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package vc.thinker.sys.web.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import vc.thinker.core.security.SecurityMapping;
import vc.thinker.core.web.BaseController;
import vc.thinker.core.web.security.SessionAuthorizingRealm;
import vc.thinker.sys.bo.PermissionBO;
import vc.thinker.sys.bo.RoleBO;
import vc.thinker.sys.bo.UserAccountBO;
import vc.thinker.sys.bo.UserBO;
import vc.thinker.sys.contants.SysUserContant;
import vc.thinker.sys.model.Role;
import vc.thinker.sys.model.User;
import vc.thinker.sys.service.OfficeService;
import vc.thinker.sys.service.SystemService;
import vc.thinker.sys.service.UserAccountService;
import vc.thinker.sys.utils.AdminUtils;
import vc.thinker.utils.CommUtil;
import vc.thinker.web.utils.UserUtils;

/**
 * 角色Controller
 *
 * @author ThinkGem
 * @version 2013-5-15 update 2013-06-08
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/role")
public class RoleController extends BaseController {

    @Autowired
    private SystemService systemService;

    @Autowired
    private UserAccountService accountService;

    @Autowired
    private SessionAuthorizingRealm systemRealm;

    @Autowired
    private OfficeService officeService;

    @Value("${adminPath}")
    private String adminPath;


    @ModelAttribute("role")
    public RoleBO get(@RequestParam(required = false) Long id) {
        if (id != null) {
            return systemService.getRole(id);
        } else {
            return new RoleBO();
        }
    }

    @SecurityMapping(name = "sys.role.view", permGroup = "sys.role", userType = SysUserContant.USER_TYPE_1)
    @RequiresPermissions("sys:role:view")
    @RequestMapping(value = {"list", ""})
    public String list(Role role, Model model) {
        List<RoleBO> list = systemService.findRoleList(UserUtils.getUserId());
        model.addAttribute("list", list);
        return "modules/sys/roleList";
    }

    @RequiresPermissions("sys:role:view")
    @RequestMapping(value = "form")
    public String form(@ModelAttribute("role") RoleBO role, Model model) {
        User currentUser = UserUtils.getUser();
        if (role.getId() != null) {
            role = systemService.getRole(role.getId());
            role.setPermissions(systemService.findPermByRid(role.getId()));
            role.setPermissionIds(StringUtils.join(RoleBO.getPermissionIdList(role.getPermissions()), ","));
            role.setOffice(officeService.get(CommUtil.null2Long(role.getOfficeId())));
        }

        model.addAttribute("role", role);
        List<PermissionBO> perms = systemService.findPermByUid(UserUtils.getUser(), SysUserContant.USER_TYPE_1);
        model.addAttribute("permissionList", perms);

        model.addAttribute("permissionGroupNameList", systemService.getPermissionGroupNameList(perms));

        model.addAttribute("officeList", officeService.findAll(currentUser));
        return "modules/sys/roleForm";
    }

    @SecurityMapping(name = "core.role.authorityModify", permGroup = "core.role.authorityManagement", userType = SysUserContant.USER_TYPE_1)
    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "save")
    public String save(RoleBO role, Model model, String oldName, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, role)) {
            return form(role, model);
        }
        if (!"true".equals(checkName(role.getName(), role.getId()))) {
            addMessageCode(redirectAttributes, request, "core.role.saveTheRoleFailedTheRoleNameHasAlreadyExisted", role.getName());
            return form(role, model);
        }
        Date time = new Date();
        if (role.getId() == null) {
            role.setCreateTime(time);
        }
        role.setUpdateTime(time);
        role.setUserType(SysUserContant.USER_TYPE_1);
        systemService.saveRole(role, RoleBO.getPermissionIdList(role.getPermissionIds()), UserUtils.getUser());
        systemRealm.clearAllCachedAuthorizationInfo();
        addMessageCode(redirectAttributes, request, "core.role.saveTheRoleSuccess", role.getName());
        return "redirect:" + adminPath + "/sys/role/?repage";
    }

    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "delete")
    public String delete(@RequestParam Long id, RedirectAttributes redirectAttributes, HttpServletRequest request) {

        User user = UserUtils.getUser();
        if (!AdminUtils.isAdmin(user.getId()) && systemService.isUserHaveRole(user.getId(), id)) {
            addMessageCode(redirectAttributes, request, "core.role.deletionOfRoleFailedToDeleteTheCurrentUsersRole");
        } else {
            systemService.deleteRole(id);
            systemRealm.clearAllCachedAuthorizationInfo();
            addMessageCode(redirectAttributes, request, "core.role.deleteRoleSuccess");
        }
        return "redirect:" + adminPath + "/sys/role/?repage";
    }

    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "assign")
    public String assign(Role role, Model model) {
        List<UserBO> users = systemService.findUserByRole(role.getId(), SysUserContant.ACCOUNT_TYPE_1);
        model.addAttribute("users", users);
        return "modules/sys/roleAssign";
    }

    @RequiresPermissions("sys:role:view")
    @RequestMapping(value = "usertorole")
    public String selectUserToRole(RoleBO role, Model model) {
        role.setUserList(systemService.findUserByRole(role.getId(), SysUserContant.ACCOUNT_TYPE_1));
        model.addAttribute("role", role);
        model.addAttribute("selectIds", role.getUserIds());
        model.addAttribute("officeList", officeService.findByScopeFilter(UserUtils.getUser().getId()));
        return "modules/sys/selectUserToRole";
    }

    @RequiresPermissions("sys:role:view")
    @ResponseBody
    @RequestMapping(value = "users")
    public List<Map<String, Object>> users(Long officeId, HttpServletResponse response) {
        response.setContentType("application/json; charset=UTF-8");
        List<Map<String, Object>> mapList = Lists.newArrayList();
        List<UserBO> userList = systemService.findByOffice(officeId, SysUserContant.ACCOUNT_TYPE_1);
        for (UserBO user : userList) {
            Map<String, Object> map = Maps.newHashMap();
            map.put("id", user.getId());
            map.put("pId", 0);
            map.put("name", user.getLoginName());
            mapList.add(map);
        }
        return mapList;
    }

    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "outrole")
    public String outrole(Long userId, Long roleId, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        Role role = systemService.getRole(roleId);
        User user = systemService.getUser(userId);
        UserAccountBO account = accountService.findByUid(user.getId(), SysUserContant.ACCOUNT_TYPE_1);
        if (user.equals(UserUtils.getUser())) {
            addMessageCode(redirectAttributes, request, "core.role.unableToRemoveUserFromTheRole", role.getName(), account.getLoginName());
        } else {
            Boolean flag = systemService.outUserInRole(roleId, userId);
            if (!flag) {
                addMessageCode(redirectAttributes, request, "core.role.theUserFromTheRoleOfRemoveFailure", account.getLoginName(), role.getName());
            } else {
                addMessageCode(redirectAttributes, request, "core.role.theUserHasBeenRemovedFromTheRole", account.getLoginName(), role.getName());
            }
        }
        return "redirect:" + adminPath + "/sys/role/assign?id=" + role.getId();
    }

    @RequiresPermissions("sys:role:edit")
    @RequestMapping(value = "assignrole")
    public String assignRole(Role role, String[] idsArr, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        StringBuilder msg = new StringBuilder();
        int newNum = 0;
        for (int i = 0; i < idsArr.length; i++) {
            Long uid = Long.parseLong(idsArr[i]);
            if (systemService.assignUserToRole(role.getId(), uid)) {
                UserAccountBO account = accountService.findByUid(uid, SysUserContant.ACCOUNT_TYPE_1);
                addMessageCode(redirectAttributes, request, "core.role.newUsersToTheRole", account.getLoginName(), role.getName());
                newNum++;
            }
        }
        addMessageCode(redirectAttributes, request, "core.role.usersHaveBeenSuccessfullyAssigned", String.valueOf(newNum), msg.toString());
        return "redirect:" + adminPath + "/sys/role/assign?id=" + role.getId();
    }

    @RequiresUser
    @ResponseBody
    @RequestMapping(value = "checkName")
    public String checkName(String name, Long id) {
        if (name != null && !systemService.isRoleNameExist(name, id)) {
            return "true";
        }
        return "false";
    }

}
