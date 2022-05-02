package com.tx.jcia.expert.validate;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.tx.jcia.expert.dto.ExpertDTO;
import com.tx.common.validate.CommonValidate;

public class ExpertValidate extends CommonValidate implements Validator{

	@SuppressWarnings("rawtypes")
	@Override
	public boolean supports(Class clazz) {
		// TODO Auto-generated method stub
		return ExpertDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		ExpertDTO department = (ExpertDTO)target;
		
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "EI_NAME", "errors.required");
		
		if(isEmptyOrWhitespace(department.getEI_NAME())){ //이름 프로퍼티 값이 존재하는가? 
			errors.rejectValue("EI_NAME", "errors.required", new Object[]{"이름"}, "필수 입력값입니다.");
		}
		if(isEmptyOrWhitespace(department.getEI_BIRTH())){ //생일 프로퍼티 값이 존재하는가? 
			errors.rejectValue("EI_BIRTH", "errors.required", new Object[]{"생일"}, "필수 입력값입니다.");
		}
 
		if(!checkEmail(department.getEI_EMAIL())){ //이메일
			errors.rejectValue("EI_EMAIL", "errors.email", new Object[]{"이메일"}, "유효하지 않은 이메일 주소입니다.");
		}
		
		if(isEmptyOrWhitespace(department.getEI_ADDRESS1())){ 
			errors.rejectValue("EI_ADDRESS1", "errors.required", new Object[]{"주소"}, "필수 입력값입니다.");
		}
		
		if(isEmptyOrWhitespace(department.getEI_BELONG())){ 
			errors.rejectValue("EI_BELONG", "errors.required", new Object[]{"소속"}, "필수 입력값입니다.");
		}
		
		if(isEmptyOrWhitespace(department.getEI_POSITION())){ 
			errors.rejectValue("EI_POSITION", "errors.required", new Object[]{"직책"}, "필수 입력값입니다.");
		}
		
//		if(department.getDescription()==null || department.getDescription().length()<10){ //부서설명 프로퍼티는 값의 길이가 10 이상인가?
//			errors.rejectValue("description", "lengthsize", new Object[]{10}, "description's length must be larger than 10.");
//		}		
	}
	
	
	
}
