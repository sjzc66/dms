package com.sjzc.dms.dao;

import com.sjzc.common.PageVo;
import com.sjzc.common.Pageable;
import com.sjzc.dms.domain.SysUser;
import com.sjzc.dms.interceptor.PageList;

public interface SysUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysUser record);

    int insertSelective(SysUser record);

    SysUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysUser record);

    int updateByPrimaryKey(SysUser record);

    SysUser getUserByUserName(String username);

    PageList<SysUser> findUserList(PageVo vo, Pageable pageable);

    SysUser getUserByUserNameAndPwd(String userName, String s);
}