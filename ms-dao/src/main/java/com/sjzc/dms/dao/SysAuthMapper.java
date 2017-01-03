package com.sjzc.dms.dao;

import com.sjzc.common.PageVo;
import com.sjzc.common.Pageable;
import com.sjzc.dms.domain.SysAuth;
import com.sjzc.dms.interceptor.PageList;

import java.util.List;
import java.util.Map;

public interface SysAuthMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysAuth record);

    int insertSelective(SysAuth record);

    SysAuth selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysAuth record);

    int updateByPrimaryKey(SysAuth record);

    List<SysAuth> getRootMenu();

    List<SysAuth> getChildMenu();

    PageList<SysAuth> findAuthList(PageVo vo, Pageable pageable);

    void deleteRoleAuthByRoleId(int roleId);

    List<SysAuth> selectChildAuthListByParentId(Integer id);

    List<SysAuth> selectAuthListByRoleId(Map<String, Object> map);
}