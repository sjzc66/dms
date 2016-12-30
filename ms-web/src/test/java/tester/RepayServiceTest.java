package tester;

import com.jzfq.AbstractTest;
import com.jzfq.fms.domain.RepayPlan;
import com.jzfq.fms.service.IRepayService;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by zhishuo on 11/9/16.
 */

public class RepayServiceTest extends AbstractTest {

    @Autowired
    private IRepayService repayService;

    @Test
    public void generateTest() {
        
    }

    @Test
    public void getPlansTest() {
        List<RepayPlan> planList = repayService.getPlanByOrder(1111);
        System.out.println(planList);
    }
}
