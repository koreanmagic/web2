package kr.co.koreanmagic.hibernate.mapper.config;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.context.annotation.Import;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Import(value={HibernateConfigAware.class, DatabaseConfiguration.class})
public @interface HibernateConfig {
	String name();
}
