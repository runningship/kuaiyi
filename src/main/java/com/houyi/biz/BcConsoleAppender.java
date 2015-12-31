package com.houyi.biz;

import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Layout;
import org.apache.log4j.spi.LoggingEvent;

public class BcConsoleAppender extends ConsoleAppender{

	@Override
	protected void subAppend(LoggingEvent event) {
		String msg = this.layout.format(event);
		if("org.hibernate.hql.internal.ast.HqlSqlWalker".equals(event.getLoggerName()) && msg.contains("DEPRECATION")){
			return;
		}
		this.qw.write(msg);
	    if(layout.ignoresThrowable()) {
	      String[] s = event.getThrowableStrRep();
	      if (s != null) {
		int len = s.length;
		for(int i = 0; i < len; i++) {
		  this.qw.write(s[i]);
		  this.qw.write(Layout.LINE_SEP);
		}
	      }
	    }

	    if(shouldFlush(event)) {
	      this.qw.flush();
	    }
	}

}
