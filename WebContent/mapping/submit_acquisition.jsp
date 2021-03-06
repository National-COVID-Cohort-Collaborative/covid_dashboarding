<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

    <sql:update dataSource="jdbc/covid">
        delete from n3c_admin.mapping_acquisition where n3c = ?
        <sql:param>${param.slot1}</sql:param>
    </sql:update>

    <sql:update dataSource="jdbc/covid">
        insert into n3c_admin.mapping_acquisition select coalesce(substring(site from '(.*) \([^)]+\)$'),site) as site,substring(site from '.* \(([^),]+).*\)$') as city,substring(site from '.* \([^),]+, *(.*)\)$') as state,site as n3c,site_name as acquisition from n3c_admin.n3c,n3c_admin.acquisition where site=? and site_name=?;
        <sql:param>${param.slot1}</sql:param>
        <sql:param>${param.slot2}</sql:param>
    </sql:update>

<c:redirect url="mapper_acquisition.jsp"/>
