package kr.co.koreanmagic.hibernate.mapper.embeddable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class Website {
	
	private String url;
	private String id;
	private String password;
	
	public Website() {}
	public Website(String url) {
		setUrl(url);
	}
	public Website(String...s) {
		setUrl(s[0]);
		setId(s[1]);
		setPassword(s[2]);
	}
	
	
	@Column(name="website_url")
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	@Column(name="website_id")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Column(name="website_password")
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	

}
