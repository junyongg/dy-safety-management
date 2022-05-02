package com.tx.jcia.news.validate;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.tx.common.validate.CommonValidate;
import com.tx.jcia.news.dto.NewsDTO;

public class JciaNewsValidate extends CommonValidate implements Validator{

	@SuppressWarnings("rawtypes")
	@Override
	public boolean supports(Class clazz) {
		// TODO Auto-generated method stub
		return NewsDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		NewsDTO department = (NewsDTO)target;
		
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "EI_NAME", "errors.required");
		
		if(isEmptyOrWhitespace(department.getNL_NAME())){ //이름 프로퍼티 값이 존재하는가? 
			errors.rejectValue("NL_NAME", "errors.required", new Object[]{"이름"}, "필수 입력값입니다.");
		}
		
		if(isEmptyOrWhitespace(department.getNL_POSITION())){ //이름 프로퍼티 값이 존재하는가? 
			errors.rejectValue("NL_POSITION", "errors.required", new Object[]{"직책"}, "필수 입력값입니다.");
		}
		
		if(isEmptyOrWhitespace(department.getNL_BELONG())){ //이름 프로퍼티 값이 존재하는가? 
			errors.rejectValue("NL_BELONG", "errors.required", new Object[]{"소속"}, "필수 입력값입니다.");
		}
 
		if(!checkEmail(department.getNL_EMAIL())){ //이메일
			errors.rejectValue("NL_EMAIL", "errors.email");
		}
		
//		if(department.getDescription()==null || department.getDescription().length()<10){ //부서설명 프로퍼티는 값의 길이가 10 이상인가?
//			errors.rejectValue("description", "lengthsize", new Object[]{10}, "description's length must be larger than 10.");
//		}		
	}
	

}
