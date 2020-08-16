/*
 * package com.virtusa.sai.dao;
 * 
 * import java.util.Map;
 * 
 * import javax.sql.DataSource;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.jdbc.core.JdbcTemplate; import
 * org.springframework.jdbc.core.namedparam.MapSqlParameterSource; import
 * org.springframework.jdbc.core.namedparam.SqlParameterSource; import
 * org.springframework.jdbc.core.simple.SimpleJdbcCall;
 * 
 * import com.virtusa.sai.jdbc.UserLoginJDBC;
 * 
 * public class UserRegistrationStored {
 * 
 * @Autowired private DataSource datasource;
 * 
 * @Autowired JdbcTemplate jdbctemplate; private SimpleJdbcCall simpleJdbcCall;
 * 
 * public void setDataSource(DataSource datasource) {
 * System.out.println(datasource); this.simpleJdbcCall=new
 * SimpleJdbcCall(datasource) .withProcedureName("UserDetails"); }
 * 
 * public UserRegistration getUserDetails(String emailid) { SqlParameterSource
 * in=new MapSqlParameterSource() .addValue("pemail",emailid); UserRegistration
 * userr1=new UserRegistration();
 * //userr1=jdbctemplate.queryForObject("select * from User where email=?",new
 * Object[] {userr1.getEmail()},new UserLoginJDBC());
 * //System.out.println("WeatherUser"+userr1); Map<String,Object> out =
 * simpleJdbcCall.execute(in); UserRegistration userr=new UserRegistration();
 * userr.setEmail(emailid); userr.setFirstname((String)out.get("pfirstname"));
 * userr.setLastname((String)out.get("plastname"));
 * userr.setMobile((Long)out.get("pmobile"));
 * userr.setCountry((String)out.get("pcountry"));
 * System.out.println((String)out.get("response")); return userr; }
 * 
 * }
 */
