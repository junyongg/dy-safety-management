package com.tx.common.logger;


import org.apache.commons.lang3.StringUtils;

import net.sf.log4jdbc.ResultSetCollector;
import net.sf.log4jdbc.Slf4jSpyLogDelegator;
import net.sf.log4jdbc.Spy;
import net.sf.log4jdbc.tools.LoggingType;

/**
 * logOff : false -> 모든 로그 출력
 * logOff : true - > sql 쿼리가  -- LOG OFF 로 시작하면 로그 출력 X
 * @author admin
 *
 */
public class Log4JdbcCustomFormatter extends Slf4jSpyLogDelegator {

    private LoggingType loggingType = LoggingType.DISABLED;

    private String margin = "";
    
    private String sqlPrefix = "SQL : ";
    
    private boolean logOff = false;
    
    private String logOffMsg = "-- LOG OFF";
    
    public enum CurrentLogStatus {
        DISABLED, VIEW
    }
    
    private CurrentLogStatus currentLogStatus = CurrentLogStatus.VIEW;
    
    
    public int getMargin() {
        return margin.length();
    }

    public void setMargin(int n) {
        margin = String.format("%1$#" + n + "s", "");
    }


    public Log4JdbcCustomFormatter() {
    }


    
    @Override
    public String sqlOccured(Spy spy, String methodCall, String rawSql) {
    	
        if (loggingType == LoggingType.DISABLED) {
            return "";
        }
        
        if( rawSql == null){
        	return "";
        }
        
        StringBuffer sql = new StringBuffer();
        sql.append(sqlPrefix).append(QueryName.query).append("\n\n");
        QueryName.query = "";
        String lines[] = rawSql.split("\n");
        
        if(logOff && lines[0].trim().equals(logOffMsg)){
        	currentLogStatus = CurrentLogStatus.DISABLED;
        	return "";
        }else{
        	getSqlOnlyLogger().info("\n\n");
        	currentLogStatus = CurrentLogStatus.VIEW;
        }
        
        for(String line : lines){
        	if(StringUtils.isNotBlank(line)){
        		sql.append(line).append("\n");
        	}
        }
        getSqlOnlyLogger().info(sql.toString());
        return rawSql;
    }
    
   

	public void sqlTimingOccured(Spy spy, long execTime, String methodCall, String rawSql)
    {
		
		if (loggingType == LoggingType.DISABLED) {
            return;
        }
		
		if(currentLogStatus == CurrentLogStatus.VIEW){
			StringBuffer sql = new StringBuffer();
			sql.append(" {실행시간 :: ");
			sql.append(execTime/1000.0);
			sql.append("초}");
			getSqlOnlyLogger().info(sql.toString());
		}
    }

	@Override
    public void resultSetCollected(ResultSetCollector resultSetCollector) {
		
		if (loggingType == LoggingType.DISABLED) {
            return;
        }
		
		if(currentLogStatus == CurrentLogStatus.VIEW){
	        String resultTable = new ResultSetCollectorPrinter().printResultSet(resultSetCollector);
	        String sqls[] = resultTable.split("\n");
	        for (int i = 0; i < sqls.length; i++) {
	        	getSqlOnlyLogger().info(sqls[i]);
	        }
		}
    }
	
    @Override
    public String sqlOccured(Spy spy, String methodCall, String[] sqls) {
        String s = "";
        for (int i = 0; i < sqls.length; i++) {
            s += sqlOccured(spy, methodCall, sqls[i]) + String.format("%n");
        }
        return s;
    }
    

    public LoggingType getLoggingType() {
        return loggingType;
    }

    public void setLoggingType(LoggingType loggingType) {
        this.loggingType = loggingType;
    }

    public String getSqlPrefix()
    {
        return sqlPrefix;
    }

    public void setSqlPrefix(String sqlPrefix)
    {
        this.sqlPrefix = sqlPrefix;
    }

	public boolean isLogOff() {
		return logOff;
	}

	public void setLogOff(boolean logOff) {
		this.logOff = logOff;
	}

}
