package kr.co.koreanmagic.hibernate.mapper.category;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/*
 * Basic		일반인쇄
 * Advanced		고급인쇄
 * Design		디자인 작업
 * Hard			특수품목
 * Large		대형출력
 * Soft			경인쇄
 */

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@Table(name="item_category")
@GenericGenerator(name="seq_id", strategy="kr.co.koreanmagic.hibernate.mapper.generator.CategoryUniqueNum")
public abstract class ItemCategory implements Serializable {
	
	
	private Long id;
	private String name;
	private String description;
	
	public abstract String categoryName();
	
	@Id @GeneratedValue
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}


	@Column(name="itemtype_name", nullable=false)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItemCategory other = (ItemCategory) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return getName();
	}

	
	/*@Embeddable
	public static class PrimaryKey implements Serializable {
		
		private String categoryName;
		private Long num;
		
		@Column(name="category_name")
		public String getCategoryName() {
			return categoryName;
		}
		public void setCategoryName(String categoryName) {
			this.categoryName = categoryName;
		}
		
		@Column(name="num")
		public Long getNum() {
			return num;
		}
		public void setNum(Long num) {
			this.num = num;
		}
	}*/
}
