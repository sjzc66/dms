package com.jzfq.dms.shiro;

import com.sjzc.dms.domain.SysUser;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

/**
 * Created by zhishuo on 10/30/16.
 * 密码生成器
 */
public class PasswordHelper {
    private static RandomNumberGenerator randomNumberGenerator =
            new SecureRandomNumberGenerator();
    private static String algorithmName = "md5";
    private static final int HASHITERATIONS = 2;

    /**
     * 生成用户密码 盐使用了随机数 生成时使用了用户名+盐 生成密码 并且经过2次md5
     *
     * @param user
     */
    public static SysUser encryptPassword(SysUser user) {
        user.setSalt(randomNumberGenerator.nextBytes().toHex());
        user.setCredentialsSalt(user.getUsername() + user.getSalt());
        String newPassword = new SimpleHash(
                algorithmName,
                user.getPassword(),
                ByteSource.Util.bytes(user.getCredentialsSalt()),
                HASHITERATIONS).toHex();
        user.setPassword(newPassword);
        return user;
    }

    @SuppressWarnings("static-access")
	public static void main(String[] args) {
        SysUser u = new SysUser();
        u.setUsername("zhishuo");
        u.setPassword("zhishuo");
        new PasswordHelper().encryptPassword(u);
        System.out.println(u.getPassword() + "-" + u.getSalt());
    }
}   
