package kr.co.koreanmagic.context.support.convert;

import java.nio.file.Path;
import java.nio.file.Paths;

import kr.co.koreanmagic.hibernate3.mapper.domain.Subcontractor;
import kr.co.koreanmagic.service.SubcontractorService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class StringToPath implements Converter<String, Path> {

	private Logger logger = Logger.getLogger(getClass());
	
	@Override
	@Transactional(readOnly=true)
	public Path convert(String source) {
		logger.debug(source);
		return Paths.get(source);
	}
}