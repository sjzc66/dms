package tester;

import com.jzfq.AbstractTest;
import com.jzfq.fms.common.common.PageVo;
import com.jzfq.fms.domain.SysUser;
import com.jzfq.fms.service.ISysUserService;

import junit.framework.Assert;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by zhishuo on 9/27/16.
 */

public class SysUserServiceTest extends AbstractTest {

    @Autowired
    private ISysUserService sysUserService;

    @Test
    public void getAllUserTest() throws Exception {
        SysUser user = new SysUser();
        PageVo vo = new PageVo();
        List<SysUser> list = sysUserService.findUserList(vo);
        Assert.assertTrue(!list.equals(null));
    }
}
