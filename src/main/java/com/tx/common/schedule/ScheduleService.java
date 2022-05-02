package com.tx.common.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.common.component.ComponentService;

/**
 * @author admin
 * 스케쥴 관리
 *
 */
@Service("ScheduleService")
public class ScheduleService {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;
 

}