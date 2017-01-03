package com.jzfq.fms.service.impl;

import com.jzfq.fms.service.ISysUserService;
import com.sjzc.common.PageVo;
import com.sjzc.dms.dao.SysAuthMapper;
import com.sjzc.dms.dao.SysRoleMapper;
import com.sjzc.dms.dao.SysUserMapper;
import com.sjzc.dms.domain.SysAuth;
import com.sjzc.dms.domain.SysRole;
import com.sjzc.dms.domain.SysUser;
import com.sjzc.dms.interceptor.PageList;
import com.sjzc.util.MD5Coding;
import com.sjzc.util.ServiceValidate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;

import static com.sjzc.util.JdbcUtil.isSuccess;

/**
 * Created by zhishuo on 9/27/16.
 */
@Service
public class SysUserServiceImpl implements ISysUserService {
    private static final Logger log = LoggerFactory.getLogger(SysUserServiceImpl.class);

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Autowired
    private SysAuthMapper sysAuthMapper;


    public PageList<SysUser> findUserList(PageVo vo) {
        return sysUserMapper.findUserList(vo, vo.getPageable());
    }

    @Override
    public Set<String> getRoleNameSetByUsername(String username) {
        SysUser user = sysUserMapper.getUserByUserName(username);
        Set<String> roles = new HashSet<>();
        String[] roleIds = user.getRoleIds().split(",");
        for(String roleId:roleIds){
            SysRole sysRole = sysRoleMapper.selectByPrimaryKey(Integer.parseInt(roleId));
            roles.add(sysRole.getName());
        }
        return roles;
    }

    @Override
    public Set<String> getAuthSetByUsername(String username) {
        SysUser user = sysUserMapper.getUserByUserName(username);
        Set<String> auths = new HashSet<>();
        Map<String,Object> map = new HashMap();
        List list = new ArrayList();
        String[] roleIds = user.getRoleIds().split(",");
        for(String roleId:roleIds){
            SysRole sysRole = sysRoleMapper.selectByPrimaryKey(Integer.parseInt(roleId));
            list.add(sysRole.getId());
        }
        map.put("roleList",list);
        List<SysAuth> ls = sysAuthMapper.selectAuthListByRoleId(map);
        for(SysAuth s:ls){
            auths.add(s.getText());
        }
        return auths;
    }

    @Override
    public SysUser addUser(SysUser user) {
        ServiceValidate.isTrue(!StringUtils.isEmpty(user), "用户不能为空");
        user.setCreateTime(new Date(System.currentTimeMillis()));
        StringBuilder sb = new StringBuilder();
        for(Integer roleId:user.getRoleIdList()){
            sb.append(roleId+",");
        }
        String idStr = sb.substring(0,sb.length()-1);
        user.setRoleIds(idStr);
        sysUserMapper.insertSelective(user);
        return user;
    }

    @Override
    public boolean delUser(int userId) {
        int result = sysUserMapper.deleteByPrimaryKey(userId);
        return result == 1;
    }

    @Override
    public boolean updateUser(SysUser user) {
        //如果id为空 或者对象为空
        if (StringUtils.isEmpty(user) || StringUtils.isEmpty(user.getId())) {
            ServiceValidate.isTrue(Boolean.FALSE, "用户不能为空");
        }
        user.setUpdateTime(new Date(System.currentTimeMillis()));

        StringBuilder sb = new StringBuilder();
        for(Integer roleId:user.getRoleIdList()){
            sb.append(roleId+",");
        }
        String idStr = sb.substring(0,sb.length()-1);
        user.setRoleIds(idStr);
        int result = sysUserMapper.updateByPrimaryKeySelective(user);
        boolean state = isSuccess(result);
        ServiceValidate.isTrue(state, "更新失败");
        return state;
    }

    @Override
    public SysUser getUserById(int userId) {
        return sysUserMapper.selectByPrimaryKey(userId);
    }


    @Override
    public SysUser getUserByUserName(String userName) {
        if (StringUtils.isEmpty(userName)) {
            ServiceValidate.isTrue(Boolean.FALSE, "用户名不能为空");
        }
        return sysUserMapper.getUserByUserName(userName);
    }

    @Override
    public SysUser getUserByUserNameAndPwd(String userName, String pwd) {
        if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(pwd)) {
            ServiceValidate.isTrue(Boolean.FALSE, "用户名或密码不能为空");
        }
       /* MD5Coding.encode()*/
        return sysUserMapper.getUserByUserNameAndPwd(userName, MD5Coding.encode2HexStr(pwd.getBytes()));
    }

    @Override
    public boolean modifyPassword(SysUser user, SysUser u) {
        user.setPassword(u.getPassword());
        user.setUpdateTime(new Date());
        user.setSalt(u.getSalt());
        user.setCredentialsSalt(u.getCredentialsSalt());
        //如果id为空 或者对象为空
        if (StringUtils.isEmpty(user) || StringUtils.isEmpty(user.getId())) {
            ServiceValidate.isTrue(Boolean.FALSE, "用户不能为空");
        }
        user.setUpdateTime(new Date(System.currentTimeMillis()));
        int result = sysUserMapper.updateByPrimaryKeySelective(user);
        boolean state = isSuccess(result);
        ServiceValidate.isTrue(state, "更新失败");
        return state;
    }



}
