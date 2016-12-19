package com.sjzc.common;

import org.apache.commons.lang.StringUtils;

/**
 * 案件状态
 *
 */
public enum CaseStatusEnum {
	
    STAY_COLLECTION("待催收"),
	
	DO_COLLECTION("催收中"),
	
	BACK_CASE("退案"),
	
	DO_RESET("重置"),
	
	OUT_SOURCING("委外"),
    
    ODNE_REPAY("已还款");
	
	String caseStatusName;
	
	CaseStatusEnum(String caseStatusName) {
		this.caseStatusName = caseStatusName;	
	}
	

	public static CaseStatusEnum getByOrdinal(int i) {
		CaseStatusEnum[] values = CaseStatusEnum.values();
		for (CaseStatusEnum caseStatus : values) {
			if (i == caseStatus.ordinal()) {
				return caseStatus;
			}
		}
		return null;
	}

	public static CaseStatusEnum getByName(String name) {
		CaseStatusEnum[] values = CaseStatusEnum.values();
		for (CaseStatusEnum caseStatus : values) {
			if (StringUtils.equalsIgnoreCase(name, caseStatus.name())) {
				return caseStatus;
			}
		}
		return null;
	}
}


