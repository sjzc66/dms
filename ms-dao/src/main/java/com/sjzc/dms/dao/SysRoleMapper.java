package com.sjzc.dms.dao;

import com.sjzc.common.PageVo;
import com.sjzc.common.Pageable;
import com.sjzc.dms.domain.SysRole;
import com.sjzc.dms.interceptor.PageList;

import java.util.List;
import java.util.Map;

public interface SysRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    SysRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);

    List<SysRole> queryAllRoleList();

    PageList<SysRole> queryRoleList(PageVo vo, Pageable pageable);

    int insertRoleAuth(Map<String, Object> params);

    void delRoleAndAuthByRoleId(Integer id);

    List<SysRole> listByRoleName(String name);
}