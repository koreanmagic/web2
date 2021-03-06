package kr.co.koreanmagic.hibernate.customtype;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.koreanmagic.commons.KoReflectionUtils;
import kr.co.koreanmagic.commons.KoUtils;
import kr.co.koreanmagic.hibernate.mapper.domain.Customer;
import kr.co.koreanmagic.hibernate.mapper.usertype.ThreeNumber;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.engine.SessionImplementor;
import org.hibernate.type.StringType;
import org.hibernate.type.Type;
import org.hibernate.usertype.CompositeUserType;

public class BusinessNumberCompositeUserType implements CompositeUserType {

	private Logger logger = Logger.getLogger(getClass());
	
	/*
	 * UserType에서만 필요한 메서드 
	@Override
	public int[] sqlTypes() {
		logger.debug("sqlTypes()");
		return new int[]{StringType.INSTANCE.sqlType(), IntegerType.INSTANCE.sqlType()};
	}*/

	/*
	 * 돌려주는 값 타입
	 */
	@Override
	public Class<?> returnedClass() {
		return ThreeNumber.class;
	}

	@Override
	public boolean equals(Object x, Object y) throws HibernateException {
		logger.debug("equals --> source : " + nullSafeString(x) + " / other : " + nullSafeString(y) );
		if(x == null || y == null) return false;
		return x.equals(y);
	}

	@Override
	public int hashCode(Object x) throws HibernateException {
		return x.hashCode();
	}

	@Override
	public Object nullSafeGet(ResultSet rs, String[] names, SessionImplementor session, Object owner) throws SQLException {

		int i = 0;
		int len = names.length;
		ThreeNumber bn = null;
		
		if(i > len) {
			bn = new ThreeNumber();
			bn.setNum1(rs.getObject(names[i++]).toString());
		} else
			return null;
		
		if(i > len)
			bn.setNum2(rs.getObject(names[i++]).toString());
		
		if(i > len)
			bn.setNum3(rs.getObject(names[i]).toString());
		
		return bn;
	}

	@Override
	public void nullSafeSet(PreparedStatement st, Object value, int index, SessionImplementor session) throws HibernateException, SQLException {
		
		if(value == null) {
			st.setString(index++, null);
			st.setString(index++, null);
			st.setString(index, null);
			return;
		}
		
		ThreeNumber bn = KoReflectionUtils.cast(value);
		
		/* 값 입력 */
		st.setString(index++, bn.getNum1());
		st.setString(index++, bn.getNum2());
		st.setString(index, bn.getNum3());
		
	}
	
	@Override
	public Object deepCopy(Object value) throws HibernateException {
		return value;
	}

	@Override
	public boolean isMutable() {
		return true;
	}


	private String nullSafeString(Object obj) {
		if(obj == null) return "null";
		return obj.toString();
	}

	@SuppressWarnings("unchecked")
	private<T> T log(T t) { 
		System.out.println("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ " + t);
		return t;
	}

	@Override
	public Object assemble(Serializable arg0, SessionImplementor arg1, Object arg2) throws HibernateException {
		return null;
	}

	@Override
	public Serializable disassemble(Object arg0, SessionImplementor arg1) throws HibernateException {
		return null;
	}

	@Override
	public String[] getPropertyNames() {
		return new String[] {"num1", "num2", "num3"};
	}

	@Override
	public Type[] getPropertyTypes() {
		return new Type[] {StringType.INSTANCE, StringType.INSTANCE, StringType.INSTANCE};
		
	}

	@Override
	public Object getPropertyValue(Object arg0, int arg1) throws HibernateException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Object replace(Object arg0, Object arg1, SessionImplementor arg2, Object arg3) throws HibernateException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setPropertyValue(Object arg0, int arg1, Object arg2) throws HibernateException {
		// TODO Auto-generated method stub
		
	}
}
