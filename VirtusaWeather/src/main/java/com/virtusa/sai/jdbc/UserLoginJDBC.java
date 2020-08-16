/*
 * package com.virtusa.sai.jdbc;
 * 
 * import java.sql.ResultSet; import java.sql.SQLException;
 * 
 * import org.springframework.jdbc.core.RowMapper;
 * 
 * import com.virtusa.sai.dao.UserLogin; import
 * com.virtusa.sai.dao.UserRegistration;
 * 
 * public class UserLoginJDBC implements RowMapper<UserRegistration> {
 * 
 * @Override public UserRegistration mapRow(ResultSet rs, int rowNum) throws
 * SQLException { UserRegistration userreg = new UserRegistration();
 * userreg.setFirstname(rs.getString("firstname"));
 * userreg.setLastname(rs.getString("lastname"));
 * userreg.setEmail(rs.getString("email"));
 * userreg.setMobile(rs.getLong("mobile"));
 * userreg.setPassword1(rs.getString("password1"));
 * userreg.setPassword2(rs.getString("password2"));
 * userreg.setCountry(rs.getString("country")); return userreg; }
 * 
 * }
 */
