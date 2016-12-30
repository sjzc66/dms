package com.sjzc.dms.dao;
import com.jzfq.fms.common.common.PageVo;
import com.jzfq.fms.common.common.Pageable;
import com.jzfq.fms.domain.SysRole;
import com.jzfq.fms.interceptor.PageList;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SysRoleMapper {
	
	/**
	 * 根据角色id删除角色
	 * @param id
	 * @return	删除的数量
	 */
    int deleteByPrimaryKey(Integer id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    /**
     * 根据角色id查询角色
     * @param id
     * @return	角色
     */
    SysRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);
 
	
	/**
	 * 根据角色名称查询角色
	 * @param name
	 * @return	角色list
	 */
	List<SysRole> listByRoleName(String name);

	List<SysRole> queryAllRoleList();

 

	/**
	 * 查询所有的角色
	 * @return
	 */
	PageList<SysRole> queryRoleList(@Param("vo") PageVo vo, Pageable pageable);

	/**
	 * 删除角色权限中间表
	 * @param roleId
	 */
	void delRoleAndAuthByRoleId(int roleId);

    int insertRoleAuth(Map<String, Object> params);


}