package com.jzfq.fms.service.impl;

import com.jzfq.fms.service.ISysRoleService;
import com.sjzc.common.PageVo;
import com.sjzc.dms.dao.SysAuthMapper;
import com.sjzc.dms.dao.SysRoleMapper;
import com.sjzc.dms.domain.SysRole;
import com.sjzc.dms.interceptor.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created by klaus on 9/27/16.
 */

@Service
public class SysRoleServiceImpl  implements ISysRoleService {

	@Autowired
	private SysRoleMapper sysRoleMapper;
	@Autowired
	private SysAuthMapper sysAuthMapper;

	@Transactional
	@Override
	public boolean addRole(SysRole role) {
		role.setCreateTime(new Date());
		role.setDelFlag((byte)0);
		sysRoleMapper.insert(role);
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("roleId", role.getId());
		params.put("authIds", role.getIdList());
		int i = sysRoleMapper.insertRoleAuth(params);
		return i==0 ? false : true;
	}

	@Override
	public boolean delRole(int roleId) {
		SysRole role= sysRoleMapper.selectByPrimaryKey(roleId);
		role.setDelFlag((byte)1);
		return sysRoleMapper.updateByPrimaryKeySelective(role) > 0 ? true
				: false;
	}

	@Transactional
	@Override
	public boolean updateRole(SysRole role) {
		if (null == role)
			return false;
		int result = 0;
		try {
			//Integer[] authIds = (Integer[])role.getIsList().toArray();

			/*if(StringUtils.isNotBlank(role.getAuthIds())){
				authIds = role.getAuthIds().split(";");
			}*/

			result = sysRoleMapper.updateByPrimaryKeySelective(role);
			//删除中间表中的对应关系
			sysRoleMapper.delRoleAndAuthByRoleId(role.getId());

			//添加中间表中的对应关系
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("roleId", role.getId());
			params.put("authIds", role.getIdList());
			sysRoleMapper.insertRoleAuth(params);

		} catch (Exception e) {
			e.printStackTrace();
			result = 0;
			throw e;
		}
		return result > 0 ? true : false;
	}

	@Override
	public SysRole getRoleById(int roleId) {
		return sysRoleMapper.selectByPrimaryKey(roleId);
	}
	
	@Override
	public List<SysRole> listRoleByName(String name) {
		return sysRoleMapper.listByRoleName(name);
	}
 

	@Override
	public boolean checkRoleNameIsExist(String name) {
		return sysRoleMapper.listByRoleName(name).size() > 0 ? true : false;
	}

	/**
	 * 获取用户权限菜单
	 * @param userId
	 * @return
	 */
	@Override
	public List<String> getSysAuthList(Integer userId) {
	 
		List<String> authUrlList = new ArrayList<>() ;
		 
		return authUrlList;
	}

	/**
	 * 获取用户角色对应的
	 */
	@Override
	public List<Map<String, Object>> getAllRoleListToAuth() {
		List<Map<String,Object>> roleIdList = new ArrayList<>();
		return  roleIdList;
	}
	
	@Override
	public PageList<SysRole> queryRoleList(PageVo vo) {
		return sysRoleMapper.queryRoleList(vo, vo.getPageable());
	}

	@Override
	public List<SysRole> queryAllRoleList() {
		return sysRoleMapper.queryAllRoleList();
	}
}
