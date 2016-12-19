package com.sjzc.common;

import org.apache.commons.lang.StringUtils;

/**
 * 流程状态 
 *
 */
public enum FlowStatusEnum {
	
	STAY_MANAGER_ALLOCATION("待经理分配"),
	
	STAY_DIRECTOR_ALLOCATION("待主管分配"),
	
	STAY_COMMISSIONER_ALLOCATION("专员催收");
	
	
	String flowStatusName;
	
	FlowStatusEnum(String flowStatusName) {
		this.flowStatusName = flowStatusName;	
	}
	

	public static FlowStatusEnum getByOrdinal(int i) {
		FlowStatusEnum[] values = FlowStatusEnum.values();
		for (FlowStatusEnum flowStatus : values) {
			if (i == flowStatus.ordinal()) {
				return flowStatus;
			}
		}
		return null;
	}

	public static FlowStatusEnum getByName(String name) {
		FlowStatusEnum[] values = FlowStatusEnum.values();
		for (FlowStatusEnum flowStatus : values) {
			if (StringUtils.equalsIgnoreCase(name, flowStatus.name())) {
				return flowStatus;
			}
		}
		return null;
	}
}

