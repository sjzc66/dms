package com.sjzc.dms.dao;

import com.sjzc.dms.domain.SysRoleAuthKey;

public interface SysRoleAuthMapper {
    int deleteByPrimaryKey(SysRoleAuthKey key);

    int insert(SysRoleAuthKey record);

    int insertSelective(SysRoleAuthKey record);
}