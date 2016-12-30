package com.sjzc.dms.dao;

import com.sjzc.dms.domain.SysUserSignRecord;

public interface SysUserSignRecordMapper {
    int deleteByPrimaryKey(Long id);

    int insert(SysUserSignRecord record);

    int insertSelective(SysUserSignRecord record);

    SysUserSignRecord selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SysUserSignRecord record);

    int updateByPrimaryKey(SysUserSignRecord record);
}