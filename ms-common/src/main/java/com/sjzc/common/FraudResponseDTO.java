package com.sjzc.common;


public class FraudResponseDTO extends ResponseDTO {
	private static final long serialVersionUID = -2150419825682508003L;
	
	private int status;

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public FraudResponseDTO(ReturnCode returnCode) {
		super(returnCode);
	}
	
}
