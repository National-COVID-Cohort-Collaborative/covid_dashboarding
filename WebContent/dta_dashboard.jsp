<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="head.jsp" flush="true">
	<jsp:param name="title" value="N3C DTA Analytics" />
</jsp:include>
<style type="text/css" media="all">
@import "resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="header.jsp" flush="true" />
	<div class="container pl-0 pr-0">
		<br /> <br />
		<div class="container-fluid">
			<c:choose>
				<c:when test="${param.view == 'detail' }">
					<h2>Status of Data Transfer Agreements</h2>
					<div id=others style="float: left; width: 45%">
						<sql:query var="dta" dataSource="jdbc/covid">
                    		select count(*) from n3c_admin.ncats where dta_executed is not null;
                		</sql:query>
						<c:forEach items="${dta.rows}" var="row" varStatus="rowCounter">
							<br />
							<h3>DTAs Executed: ${row.count} <i>(date executed)</i></h3>
						</c:forEach>
						<sql:query var="dtas" dataSource="jdbc/covid">
                    		select site,dta_executed from n3c_admin.dashboard where dta_executed is not null order by dta_executed desc,site;
                		</sql:query>
						<ul>
							<c:forEach items="${dtas.rows}" var="row" varStatus="rowCounter">
								<li>${row.site} (${row.dta_executed })
							</c:forEach>
						</ul>

						<br />
						<p>Unmatched NCATS entries:</p>
						<sql:query var="unmatched" dataSource="jdbc/covid">
                    		select site_name,dta_executed from n3c_admin.ncats where dta_executed is not null and site_name not in (select ncats from n3c_admin.mapping_ncats where ncats is not null) order by dta_executed desc;
                		</sql:query>
						<ul>
							<c:forEach items="${unmatched.rows}" var="row"
								varStatus="rowCounter">
								<li>${row.site_name} (${row.dta_executed })
							</c:forEach>
						</ul>
					</div>
					<div id=others style="float: left; width: 45%">
						<sql:query var="dta" dataSource="jdbc/covid">
                    		select count(*) from n3c_admin.ncats where dta_executed is null;
                		</sql:query>
						<c:forEach items="${dta.rows}" var="row" varStatus="rowCounter">
							<br />
							<h3>DTAs Pending: ${row.count} <i>(date sent)</i></h3>
						</c:forEach>
						<sql:query var="dtas" dataSource="jdbc/covid">
                    		select site,dta_sent from n3c_admin.dashboard where dta_executed is  null order by dta_sent desc,site;
                		</sql:query>
						<ul>
							<c:forEach items="${dtas.rows}" var="row" varStatus="rowCounter">
								<li>${row.site} (${row.dta_sent })
							</c:forEach>
						</ul>

						<br />
						<p>Unmatched NCATS entries:</p>
						<sql:query var="unmatched" dataSource="jdbc/covid">
                    		select site_name,dta_sent from n3c_admin.ncats where dta_executed is null and site_name not in (select ncats from n3c_admin.mapping_ncats where ncats is not null) order by dta_sent desc;
                		</sql:query>
						<ul>
							<c:forEach items="${unmatched.rows}" var="row"
								varStatus="rowCounter">
								<li>${row.site_name} (${row.dta_sent })
							</c:forEach>
						</ul>
					</div>
					<div id=others style="float: left; width: 100%">

						<div id=others style="float: left; width: 45%">
							<sql:query var="dua" dataSource="jdbc/covid">
                    			select count(*) from n3c_admin.ncats where dua_executed is not null;
                			</sql:query>
							<c:forEach items="${dua.rows}" var="row" varStatus="rowCounter">
								<h3>DUAs Executed: ${row.count}</h3>
							</c:forEach>
							<sql:query var="duas" dataSource="jdbc/covid">
                    			select site,dua_executed from n3c_admin.dashboard where dua_executed is not null order by dua_executed desc;
                			</sql:query>
							<ul>
								<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
									<li>${row.site} (${row.dta_executed })
								</c:forEach>
							</ul>
						</div>
					</div>
				</c:when>
				<c:when test="${param.view == 'executed' }">
					<h2>Executed Data Transfer Agreements</h2>
					<div id=others style="float: left; width: 100%">
						<br />
						<div id="graph_block" style="float: left; width: 45%">
							<h3>Count by State</h3>
							<div id="dta_by_state" align="left"></div>
						</div>
						<div id="graph_block" style="float: left; width: 45%">
							<jsp:include page="graphs/verticalBarChart.jsp">
								<jsp:param name="data_page"
									value="adminData.jsp?mode=dta_by_state" />
								<jsp:param name="dom_element" value="#dta_by_state" />
							</jsp:include>
							<div id="graph_block" style="float: left; width: 45%">
								<h3>Count by CTSA/Community</h3>
								<div id="dta_by_network" align="left"></div>
							</div>
							<jsp:include page="graphs/verticalBarChart.jsp">
								<jsp:param name="data_page"
									value="adminData.jsp?mode=dta_by_network" />
								<jsp:param name="dom_element" value="#dta_by_network" />
							</jsp:include>
						</div>
					</div>
					<div id=others style="float: left; width: 100%">
						<br />
						<div id="graph_block" style="float: left; width: 45%">
							<h3>Count by Group/Consortium</h3>
							<div id="dta_by_reason" align="left"></div>
						</div>
						<div id="graph_block" style="float: left; width: 45%">
							<jsp:include page="graphs/verticalBarChart.jsp">
								<jsp:param name="data_page"
									value="adminData.jsp?mode=dta_by_group" />
								<jsp:param name="dom_element" value="#dta_by_reason" />
							</jsp:include>
						</div>
					</div>
				</c:when>
				<c:when test="${param.view == 'pending' }">
					<h2>Pending Data Transfer Agreements</h2>
					<div id=others style="float: left; width: 100%">
						<br />
						<div id="graph_block" style="float: left; width: 45%">
							<h3>Count by State</h3>
							<div id="dta_pending_by_state" align="left"></div>
						</div>
						<jsp:include page="graphs/verticalBarChart.jsp">
							<jsp:param name="data_page"
								value="adminData.jsp?mode=dta_pending_by_state" />
							<jsp:param name="dom_element" value="#dta_pending_by_state" />
						</jsp:include>
						<div id="graph_block" style="float: left; width: 45%">
							<h3>Count by Date Sent</h3>
							<div id="dta_pending" align="left"></div>
							<br />
						</div>
						<jsp:include page="graphs/verticalBarChart.jsp">
							<jsp:param name="data_page"
								value="adminData.jsp?mode=dta_pending" />
							<jsp:param name="dom_element" value="#dta_pending" />
						</jsp:include>
						<div id="graph_block" style="float: left; width: 45%">
							<h3>Count by CTSA/Community</h3>
							<div id="dta_pending_by_network" align="left"></div>
						</div>
						<jsp:include page="graphs/verticalBarChart.jsp">
							<jsp:param name="data_page"
								value="adminData.jsp?mode=dta_pending_by_network" />
							<jsp:param name="dom_element" value="#dta_pending_by_network" />
						</jsp:include>
					</div>
					<div id=others style="float: left; width: 100%">
						<br />
						<div id="graph_block" style="float: left; width: 45%">
							<h3>Count by Group/Consortium</h3>
							<div id="dta_pending_by_reason" align="left"></div>
						</div>
						<div id="graph_block" style="float: left; width: 45%">
							<jsp:include page="graphs/verticalBarChart.jsp">
								<jsp:param name="data_page"
									value="adminData.jsp?mode=dta_pending_by_group" />
								<jsp:param name="dom_element" value="#dta_pending_by_reason" />
							</jsp:include>
						</div>
					</div>
				</c:when>
			</c:choose>
		</div>
	</div>
	<div id=others style="float: left; width: 100%">
		<jsp:include page="/footer.jsp" flush="true" />
	</div>
</body>
</html>
