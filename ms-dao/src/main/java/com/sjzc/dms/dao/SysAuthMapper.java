package com.sjzc.dms.dao;

import com.jzfq.fms.common.common.PageVo;
import com.jzfq.fms.common.common.Pageable;
import com.jzfq.fms.domain.SysAuth;
import com.jzfq.fms.interceptor.PageList;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SysAuthMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysAuth record);

    int insertSelective(SysAuth record);

    SysAuth selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysAuth record);

    int updateByPrimaryKey(SysAuth record);

    /**
     * 通过roleId查询出当前用户角色菜单
     * @param parmMap
     * @return
     */
    List<SysAuth> selectAuthListByRoleId(Map<String, Object> parmMap);

    /**
     * 获取所有主菜单页面
     */
    List<SysAuth> getRootMenu();

    /**
     * 获取子菜单集合
     */
    List<SysAuth> getChildMenu();
 

	/**
	 * 查询所有权限
	 * @return
	 */
	PageList<SysAuth> findAuthList(@Param("vo") PageVo vo, Pageable pageable);

    /**
     * 删除roleId对应的authId
     * @param roleId
     */
    void deleteRoleAuthByRoleId(@Param("roleId") int roleId);

    List<SysAuth> selectChildAuthListByParentId(Integer id);
}