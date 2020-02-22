package vc.thinker.sys.service;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.NoSuchMessageException;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;

import vc.thinker.core.security.SecurityMapping;
import vc.thinker.core.security.SecurityMappingModel;
import vc.thinker.utils.ClassUtils;

/**
 * 用于权限初始化处理
 * @author james
 *
 */
public class SecurityInitHandle {
	private final static Logger log=LoggerFactory.getLogger(SecurityInitHandle.class);
	/**
	 * 扫描包
	 */
	private String pack;
	/**
	 * 是否启动初始化
	 */
	private boolean runInit=false;
	/**
	 * 用户类型
	 */
	private Integer userType;
	
	/**
	 * 启动
	 */
	private boolean enableMessageSource=false;
	
	/**
	 * 地区
	 */
	private Locale locale;
	
	private MessageSource messageSource;
	
	private SystemService systemService;
	
	private void init(){
		if(isEnableMessageSource()){
			if(locale == null || messageSource == null){
				throw new RuntimeException("locale or messageSource is null");
			}
		}
		if(this.isRunInit()){
			handle();
		}
	}
	
	/**
	 * 执行
	 */
	public void handle(){
		Assert.hasText(pack,"pack is null");
		Assert.notNull(userType,"userType is null");
		
		List<SecurityMappingModel> list= this.findSecurity();
		
		systemService.initSysPermissions(list, userType);
		
		log.info("init Security Complete");
	}
	
	/**
	 * 查找所有权限
	 * @return
	 */
	public  List<SecurityMappingModel> findSecurity(){
		//统一加载所有 action class
		Set<Class<?>> clzs = ClassUtils.getClasses(pack,Controller.class);
		
		log.info("扫描到的 Controller class:{}",clzs);
		List<SecurityMappingModel> mappings = new ArrayList<SecurityMappingModel>();
		for (Class clz : clzs) {
			Method[] ms = clz.getMethods();
			for (Method m : ms) {
				Annotation[] annotation = m.getAnnotations();
				SecurityMapping sm=null;
				RequiresPermissions rp=null;
				for (Annotation tag : annotation) {
					if (SecurityMapping.class.isAssignableFrom(tag.annotationType())) {
						sm=(SecurityMapping)tag;
					}
					if(RequiresPermissions.class.isAssignableFrom(tag.annotationType())){
						rp=(RequiresPermissions)tag;
					}
				}
				if(sm!=null && rp!=null){
					SecurityMappingModel smm=new SecurityMappingModel();
					String smName=sm.name();
					String smGroup=sm.permGroup();
					if(isEnableMessageSource()){
						try {
							smName=messageSource.getMessage(sm.name(), null, locale);
						} catch (NoSuchMessageException e) {
							log.error("权限名称 {} 没有找到 {} 对应的消息资源",sm.name(),locale);
						}
						try {
							smGroup=messageSource.getMessage(sm.permGroup(), null, locale);
						} catch (NoSuchMessageException e) {
							log.error("权限分组 {} 没有找到 {} 对应的消息资源",sm.permGroup(),locale);
						}
					}
					smm.setName(smName);
					smm.setPermGroup(smGroup);
					
					smm.setValue(rp.value()[0]);
					smm.setSequence(sm.sequence());
					smm.setUserType(sm.userType());
					mappings.add(smm);
				}
			}
		}
		return mappings;
	}
	
	public String getPack() {
		return pack;
	}
	public void setPack(String pack) {
		this.pack = pack;
	}
	
	public boolean isRunInit() {
		return runInit;
	}

	public void setRunInit(boolean runInit) {
		this.runInit = runInit;
	}

	public Integer getUserType() {
		return userType;
	}
	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public SystemService getSystemService() {
		return systemService;
	}

	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	public boolean isEnableMessageSource() {
		return enableMessageSource;
	}

	public void setEnableMessageSource(boolean enableMessageSource) {
		this.enableMessageSource = enableMessageSource;
	}

	public Locale getLocale() {
		return locale;
	}

	public void setLocale(Locale locale) {
		this.locale = locale;
	}

	public MessageSource getMessageSource() {
		return messageSource;
	}

	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}
}
