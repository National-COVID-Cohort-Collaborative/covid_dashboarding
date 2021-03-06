<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
	
{		
			<sql:query var="dta" dataSource="jdbc/covid">
            	select count(*) from n3c_admin.site_master where dtasent is not null;
            </sql:query>
			<c:forEach items="${dta.rows}" var="row" varStatus="rowCounter">
				"DTAs Sent": ${row.count},
			</c:forEach>

			<sql:query var="dta" dataSource="jdbc/covid">
            	select count(*) from n3c_admin.site_master where dtaexecuted is not null;
            </sql:query>
			<c:forEach items="${dta.rows}" var="row" varStatus="rowCounter">
				"DTAs Executed": ${row.count},
			</c:forEach>

			<sql:query var="dta" dataSource="jdbc/covid">
            	select count(*) from n3c_admin.site_master where irbapprovaltype ~'APPROVED';
            </sql:query>
			<c:forEach items="${dta.rows}" var="row" varStatus="rowCounter">
				"IRB Protocols Approved": ${row.count},
			</c:forEach>

			<sql:query var="dta" dataSource="jdbc/covid">
            	select count(*) from n3c_admin.site_master where dtaandirbok ~'APPROVED';
            </sql:query>
			<c:forEach items="${dta.rows}" var="row" varStatus="rowCounter">
				"All Regulatory Requirements Completed": ${row.count},
			</c:forEach>

			<sql:query var="dta" dataSource="jdbc/covid">
            	select count(*) from n3c_admin.site_master where firstcontact is not null and firstcontact!='FALSE';
            </sql:query>
			<c:forEach items="${dta.rows}" var="row" varStatus="rowCounter">
				"Sites met with Data Acquisition Group": ${row.count},
			</c:forEach>

			<sql:query var="dta" dataSource="jdbc/covid">
            	select count(*) from n3c_admin.site_master where passingdata::boolean;
            </sql:query>
			<c:forEach items="${dta.rows}" var="row" varStatus="rowCounter">
				"Passing data": ${row.count}
			</c:forEach>
}