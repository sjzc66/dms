package tester;

import com.jzfq.AbstractTest;
import com.jzfq.fms.domain.PresentOrder;
import com.jzfq.fms.domain.QuotaApproval;
import com.jzfq.fms.service.IDGeneratorService;
import com.jzfq.fms.service.IJdPayService;
import com.jzfq.fms.service.IPresentOrderService;
import com.jzfq.fms.service.IQuotaApprovalService;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Date;

/**
 * Created by huyinglin on 2016/11/25.
 */

public class InterfaceServiceTest extends AbstractTest {

    private Logger logger= LoggerFactory.getLogger(InterfaceServiceTest.class);

    @Autowired
    private IQuotaApprovalService quotaApprovalService;

    @Autowired
    private IPresentOrderService presentOrderService;

    @Autowired
    private IDGeneratorService idGeneratorService;

    @Autowired
    private IJdPayService IJdPayService;

    /**
     * 额度审批单和用户信息录入测试
     */
    @Test
    public void insertQuotaApprovalAndCustomerTest(){
        QuotaApproval quotaApproval=new QuotaApproval();
        quotaApproval.setApplicationTime(new Date(System.currentTimeMillis()));
        quotaApproval.setAuditStatus("0");
        quotaApproval.setCustomerId(123456);
        quotaApproval.setCustomerType("1");
        quotaApproval.setIdCard("42332319990123212");
        quotaApproval.setIncomingProduct("进件产品测试");
        quotaApproval.setOrderId("123456");
        quotaApproval.setPhone("15210535671");
        quotaApproval.setProposer("胡应林");
        quotaApproval.setRecommendationCode("HU888800");
        quotaApproval.setRepayDate(new Date(System.currentTimeMillis()));
        quotaApproval.setUsername("胡应林");
        quotaApproval.setWhiteLine(new BigDecimal("90000"));
        boolean status=quotaApprovalService.insertQuotaApprovalAndCustomer(quotaApproval);
        logger.info("录入额度审批和用户信息返回："+status);
    }

    /**
     * 根据订单号修改额度审批状态
     */
    @Test
    public void updateQuotaApprovalAuditStatusByOrderIdTest(){
        String orderId="123456";
        String auditStauts="3";
        boolean status=quotaApprovalService.updateQuotaApprovalAuditStatusByOrderId(orderId,auditStauts);
        logger.info("修改审核状态返回值："+status);
    }

    /**
     * 提现订单录入
     */
    @Test
    public void insertPresentOrderTest(){
        PresentOrder presentOrder=new PresentOrder();
        presentOrder.setBankAddress("北京市上地分行");
        presentOrder.setBankCode("10000");
        presentOrder.setBankName("中国工商银行");
        presentOrder.setInterest(new BigDecimal("89.653"));
        presentOrder.setLoanLimit(new BigDecimal("20030000.897"));
        presentOrder.setMonthly(new BigDecimal("3400.765"));
        presentOrder.setOrderId("123456");
        presentOrder.setOrderStatus((byte)2);
        presentOrder.setOrderTime(new Date(System.currentTimeMillis()));
        presentOrder.setPeriods(12);
        presentOrder.setPhone("15210535710");
        presentOrder.setProductCode("2");
        presentOrder.setRecommendCode("HU78GH");
        presentOrder.setRepayDate(new Date(System.currentTimeMillis()));
        presentOrder.setSource((byte)2);
        presentOrder.setUsername("胡应林");
        boolean status=presentOrderService.insertPresentOrder(presentOrder);
        logger.info("提现订单录入返回："+status);
    }

    @Test
    public void idGeneratorServiceTest(){
        //888 161207 1415140000
        logger.info("交易流水号生成测试："+idGeneratorService.generate());
    }

}
